// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

import "../utils/TransferHelper.sol";
import "../interfaces/Miner/IXenFactory.sol";
import "../interfaces/XenFactory/BulkType.sol";

contract MinerV1 is OwnableUpgradeable, TransferHelper {
    // INTERNAL TYPE TO DESCRIBE MINT TASK CONFIG INFO
    struct MintInfo {
        address member;
        uint256 term;
        uint256 maxGasPrice;
        uint256 targetValue;
        uint256 maxGasConsumedPerBatchMint;
        uint256 claimId;
        bool stopped;
    }

    // INTERNAL TYPE TO DESCRIBE MINT RESULT
    struct MintResult {
        uint256 gasConsumed;
        uint256 accountsMinted;
        uint256 valueLeft;
    }

    // INTERNAL TYPE TO DESCRIBE CLAIM TASK CONFIG INFO
    struct ClaimInfo {
        uint256 mintId;
        address member;
        uint256 maxGasPrice;
        uint256 targetValue;
        uint256 maxGasConsumedPerBatchClaim;
        bool stopped;
    }

    // INTERNAL TYPE TO DESCRIBE CLAIM RESULT
    struct ClaimResult {
        uint256 gasConsumed;
        uint256 accountsClaimed;
        uint256 valueLeft;
    }

    // INTERNAL TYPE TO DESCRIBE MULTIPLE MINT INFO
    struct MultiMintInfo {
        uint256 mintId;
        MintInfo info;
        MintResult result;
    }

    // INTERNAL TYPE TO DESCRIBE MULTIPLE CLAIM INFO
    struct MultiClaimInfo {
        uint256 claimId;
        ClaimInfo info;
        ClaimResult result;
    }

    uint256 public constant COUNT_PER_BULK = 100;
    uint256 public constant GAS_USED_PER_BULK_MINT = 19_000_000;
    uint256 public constant GAS_USED_PER_BULK_CLAIM = 7_000_000;

    address public factory;
    uint256 public totalFee;

    uint256 public joinFeeReceived;
    uint256 public globalMintIndex;
    uint256 public globalClaimIndex;

    uint256 public minGasPrice;
    uint256 public taskCountPerMember;

    mapping(address => bool) public isRobot;

    mapping(uint256 => MintInfo) public mintInfo;
    mapping(uint256 => MintResult) public mintResult;
    mapping(uint256 => ClaimInfo) public claimInfo;
    mapping(uint256 => ClaimResult) public claimResult;

    mapping(uint256 => uint256) public claimedAccounts;
    mapping(uint256 => uint256[]) internal _batchIds;

    mapping(address => uint256[]) internal _mintTasks;
    mapping(address => uint256[]) internal _stoppedMintTasks;
    mapping(address => uint256[]) internal _claimTasks;
    mapping(address => uint256[]) internal _stoppedClaimTasks;

    receive() external payable {
        totalFee += msg.value;
    }

    function initialize(address _factory) external initializer {
        __Ownable_init();
        factory = _factory;
        minGasPrice = 100_000_000;
        // taskCountPerMember = 5;
    }

    // 开始一个自动铸造任务
    function startMintTask(uint256 term, uint256 maxGasPrice) external payable {
        require(term > 0, "invalid term");
        require(maxGasPrice >= minGasPrice, "max gas price is too small");

        uint256 maxGasConsumedPerBatchMint = maxGasPrice *
            GAS_USED_PER_BULK_MINT;

        require(msg.value >= maxGasConsumedPerBatchMint, "insufficient value");

        uint256 mintId = ++globalMintIndex;
        _mintTasks[msg.sender].push(mintId);

        mintInfo[mintId] = MintInfo(
            msg.sender,
            term,
            maxGasPrice,
            msg.value,
            maxGasConsumedPerBatchMint,
            0,
            false
        );
        mintResult[mintId] = MintResult(0, 0, msg.value);

        emit StartMintTask(msg.sender, mintId);
    }

    // 自动铸造
    function mint(uint256 mintId) external {
        require(mintId <= globalMintIndex, "invalid mint id");

        MintInfo memory info = mintInfo[mintId];
        require(tx.gasprice <= info.maxGasPrice, "gas price exceeds the limit");
        require(!info.stopped, "stopped");

        MintResult memory result = mintResult[mintId];
        require(
            result.valueLeft >= info.maxGasConsumedPerBatchMint,
            "task done"
        );

        uint256 batchId = IXenFactory(factory).minerBulkMint(
            info.member,
            info.term,
            uint256(100)
        );

        uint256 gasConsumed;
        unchecked {
            gasConsumed = GAS_USED_PER_BULK_MINT * tx.gasprice;
            result.gasConsumed += gasConsumed;
            result.valueLeft -= gasConsumed;
            result.accountsMinted += COUNT_PER_BULK;
        }

        mintResult[mintId] = result;
        _batchIds[mintId].push(batchId);

        _transfer(msg.sender, gasConsumed);

        // emit Mint(mintId, batchId, gasConsumed, msg.sender);
    }

    // 自动提取
    function claim(uint256 mintId, uint256 batchId) external {
        require(mintId <= globalMintIndex, "invelid mint id");

        MintInfo memory minfo = mintInfo[mintId];
        uint256 claimId = minfo.claimId;
        require(claimId > 0, "no claim task");

        ClaimInfo memory info = claimInfo[claimId];
        require(!info.stopped, "stopped");
        require(tx.gasprice <= info.maxGasPrice, "gas price exceeds the limit");

        ClaimResult memory result = claimResult[claimId];
        require(
            result.valueLeft >= info.maxGasConsumedPerBatchClaim,
            "task done"
        );

        // IFactory(factory).claimBatch(info.member, batchId);

        uint256 gasConsumed;
        unchecked {
            gasConsumed = GAS_USED_PER_BULK_CLAIM * tx.gasprice;
            result.accountsClaimed += COUNT_PER_BULK;
            result.valueLeft -= gasConsumed;
            result.gasConsumed += gasConsumed;
        }

        claimResult[claimId] = result;

        _transfer(msg.sender, gasConsumed);

        emit Claim(mintId, claimId, batchId, gasConsumed, msg.sender);
    }

    event SetBot(address bot, uint256 startValue);
    event SetMinGasPrice(uint256 minGasPrice);
    event SetTaskCountPerMember(uint256 count);
    event WithdrawJoinFee(address receiver, uint256 fee);

    event Mint(
        uint256 indexed mintId,
        uint256 batchId,
        uint256 gasConsumed,
        address bot
    );
    event Claim(
        uint256 indexed mintId,
        uint256 claimId,
        uint256 batchId,
        uint256 gasConsumed,
        address bot
    );

    event StartMintTask(address indexed member, uint256 mintId);
    event StopMintTask(uint256 indexed mintId, uint256 valueLeft);
    event TopUpMintTask(uint256 indexed mintId, uint256 value);
    event SetMintMaxGasPrice(uint256 indexed mintId, uint256 maxGsPrice);
    event StartClaimTask(uint256 indexed mintId, uint256 claimId);
    event StopClaimTask(
        uint256 indexed mintId,
        uint256 claimId,
        uint256 valueLeft
    );
    event TopUpClaimTask(uint256 indexed mintId, uint256 value);
    event SetClaimMaxGasPrice(
        uint256 indexed mintId,
        uint256 claimId,
        uint256 maxGsPrice
    );
}
