// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol";

import "../utils/TransferHelper.sol";
// import "../interfaces/Miner/MinerType.sol";
import "../interfaces/Miner/IXenFactory.sol";
import "../interfaces/xen-batch/BulkType.sol";

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

    receive() external payable {
        totalFee += msg.value;
    }

    function initialize(address _factory) external initializer {
        __Ownable_init();
        factory = _factory;
        minGasPrice = 100_000_000;
        taskCountPerMember = 5;
    }

    // 获取铸造任务的批量数据
    function getBatchInfos(
        uint256 mintId
    )
        external
        view
        returns (uint256 totalCount, BulkType.BulkInfo[] memory infos)
    {
        // uint256[] memory ids = _batchIds[mintId];
        // totalCount = ids.length;
    }

    // 获取一个地址的铸造信息
    function getUserMintInfo(
        address user
    ) external view returns (MultiMintInfo[] memory infos) {}

    // 获取一个地址的 claim信息
    function getUserClaimInfo(
        address user
    ) external view returns (MultiClaimInfo[] memory infos) {}

    // 设置EOA账户
    function setBot(address eoa, uint256 startValue) external onlyOwner {
        isRobot[eoa] = true;

        require(joinFeeReceived >= startValue, "insufficient join fee");
        joinFeeReceived -= startValue;

        _transfer(eoa, startValue);
        emit SetBot(eoa, startValue);
    }

    // 设置最小的 GasPrice
    function setMinGasPrice(uint256 newMinGasPrice) external onlyOwner {
        minGasPrice = newMinGasPrice;
        emit SetMinGasPrice(newMinGasPrice);
    }

    // 设置每个地址的最大任务数量
    function setTaskCountPerMember(uint256 count) external onlyOwner {
        taskCountPerMember = count;
        emit SetTaskCountPerMember(count);
    }

    // 开始一个自动铸造任务
    function startMintTask(uint256 term, uint256 maxGasPrice) external payable {
        require(term > 0, "invalid term");
        require(maxGasPrice >= minGasPrice, "max gas price is too small");
        require(
            _mintTasks[msg.sender].length -
                _stoppedMintTasks[msg.sender].length <
                taskCountPerMember,
            "mint task count exceeds limit"
        );

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

    // 重置铸造任务的最大Gwei
    function setMintMaxGasPrice(uint256 mintId, uint256 maxGasPrice) external {
        require(maxGasPrice >= minGasPrice, "max gas price is too small");
        MintInfo memory info = mintInfo[mintId];
        require(msg.sender == info.member, "invalid caller");
        require(!info.stopped, "stopped");

        info.maxGasPrice = maxGasPrice;
        info.maxGasConsumedPerBatchMint = maxGasPrice * GAS_USED_PER_BULK_MINT;

        MintResult memory result = mintResult[mintId];
        require(
            result.valueLeft >= info.maxGasConsumedPerBatchMint,
            "value left if less than fee of one batch mint"
        );

        mintInfo[mintId] = info;

        emit SetMintMaxGasPrice(mintId, maxGasPrice);
    }

    // 充值铸造任务
    function topUpMintTask(uint256 mintId) external payable {
        require(msg.value > 0, "need none zero value");

        MintInfo memory info = mintInfo[mintId];
        require(msg.sender == info.member, "invalid caller");
        require(!info.stopped, "stopped");

        info.targetValue += msg.value;
        mintInfo[mintId] = info;

        mintResult[mintId].valueLeft += msg.value;

        emit TopUpMintTask(mintId, msg.value);
    }

    // 终止铸造任务
    function stopMintTask(uint256 mintId) external {
        MintInfo memory info = mintInfo[mintId];
        require(msg.sender == info.member, "invalid caller");
        require(!info.stopped, "stopped");

        info.stopped = true;
        mintInfo[mintId] = info;

        MintResult memory result = mintResult[mintId];
        uint256 valueLeft = result.valueLeft;
        result.valueLeft = 0;
        mintResult[mintId] = result;

        _stoppedMintTasks[msg.sender].push(mintId);

        _transfer(msg.sender, valueLeft);

        emit StopMintTask(mintId, valueLeft);
    }

    // 开始自动提取任务
    function startClaimTask(
        uint256 mintId,
        uint256 maxGasPrice
    ) external payable {
        require(maxGasPrice >= minGasPrice, "max gas price is too small");
        MintInfo memory info = mintInfo[mintId];
        require(info.member == msg.sender, "invalid caller");
        require(info.claimId == 0, "claim info has been set");

        require(
            _claimTasks[msg.sender].length -
                _stoppedClaimTasks[msg.sender].length <
                taskCountPerMember,
            "claim task count exceeds limit"
        );

        uint256 maxGasConsumedPerBatchClaim = maxGasPrice *
            GAS_USED_PER_BULK_CLAIM;
        require(msg.value >= maxGasConsumedPerBatchClaim, "insufficient value");

        uint256 claimId = ++globalClaimIndex;
        _claimTasks[msg.sender].push(claimId);

        info.claimId = claimId;
        mintInfo[mintId] = info;

        claimInfo[claimId] = ClaimInfo(
            mintId,
            info.member,
            maxGasPrice,
            msg.value,
            maxGasConsumedPerBatchClaim,
            false
        );
        claimResult[claimId] = ClaimResult(0, 0, msg.value);

        emit StartClaimTask(mintId, claimId);
    }

    // 设置提取任务的最大Gwei
    function setClaimMaxGasPrice(uint256 mintId, uint256 maxGasPrice) external {
        require(maxGasPrice >= minGasPrice, "max gas price is too small");
        MintInfo memory minfo = mintInfo[mintId];
        require(minfo.member == msg.sender, "invalid caller");

        uint256 claimId = minfo.claimId;
        require(claimId > 0, "no claim task");

        ClaimInfo memory info = claimInfo[claimId];
        require(!info.stopped, "stopped");

        info.maxGasPrice = maxGasPrice;
        info.maxGasConsumedPerBatchClaim =
            maxGasPrice *
            GAS_USED_PER_BULK_CLAIM;

        ClaimResult memory result = claimResult[claimId];
        require(
            result.valueLeft >= info.maxGasConsumedPerBatchClaim,
            "value left if less than fee of one batch claim fee"
        );

        claimInfo[claimId] = info;

        emit SetClaimMaxGasPrice(mintId, claimId, maxGasPrice);
    }

    // 自动提取任务充值
    function topUpClaimTask(uint256 mintId) external payable {
        require(msg.value > 0, "need none zero value");

        MintInfo memory minfo = mintInfo[mintId];
        require(msg.sender == minfo.member, "invalid caller");

        uint256 claimId = minfo.claimId;
        require(claimId > 0, "no claim task");

        ClaimInfo memory info = claimInfo[claimId];
        require(!info.stopped, "stopped");

        info.targetValue += msg.value;
        claimInfo[claimId] = info;

        claimResult[claimId].valueLeft += msg.value;

        emit TopUpClaimTask(mintId, msg.value);
    }

    // 停止自动提取任务
    function stopClaimTask(uint256 mintId) external {
        MintInfo memory minfo = mintInfo[mintId];
        require(minfo.member == msg.sender, "invalid caller");

        uint256 claimId = minfo.claimId;
        require(claimId > 0, "no claim task");

        minfo.claimId = 0;
        mintInfo[mintId] = minfo;

        ClaimInfo memory info = claimInfo[claimId];
        require(!info.stopped, "stopped");

        info.stopped = true;
        claimInfo[claimId] = info;

        ClaimResult memory result = claimResult[claimId];
        uint256 valueLeft = result.valueLeft;
        result.valueLeft = 0;
        claimResult[claimId] = result;

        _stoppedClaimTasks[msg.sender].push(claimId);
        claimedAccounts[mintId] += result.accountsClaimed;

        _transfer(msg.sender, valueLeft);

        emit StopClaimTask(mintId, claimId, valueLeft);
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

        // uint256 batchId = IFactory(factory).mintBatch(info.member, info.term, COUNT_PER_BATCH);

        uint256 gasConsumed;
        unchecked {
            gasConsumed = GAS_USED_PER_BULK_MINT * tx.gasprice;
            result.gasConsumed += gasConsumed;
            result.valueLeft -= gasConsumed;
            result.accountsMinted += COUNT_PER_BULK;
        }

        mintResult[mintId] = result;
        // batchIds[mintId].push(batchId);

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
}
