// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/XenFactory/IMiniProxy.sol";
import "../interfaces/XenFactory/BulkType.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";

contract XenFactory is BulkType {
    address public constant MINI_PROXY =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public constant MINER = 0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;

    mapping(address => uint256) public userBulkAmount;
    // address => batchId => batchInfo
    mapping(address => mapping(uint256 => BulkInfo)) public bulkInfo;

    event MinerBulkClaimRank(
        address indexed user,
        uint256 batchId,
        uint256 count,
        uint256 term
    );
    event MinerBulkClaimMintReward(address indexed user, uint256 batchId);

    modifier onlyMiner() {
        require(msg.sender == MINER, "unauthorized");
        _;
    }

    function bulkClaimRank(uint256 term, uint256 count) external {
        require(term > 0 && count > 0, "Illedge term or count");
        uint batchId = ++userBulkAmount[msg.sender];
        bulkInfo[msg.sender][batchId] = BulkInfo(
            batchId,
            count,
            false,
            // solhint-disable-next-line
            block.timestamp + term * 3600 * 24
        );
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address clone;
        for (uint256 i = 1; i < count; i++) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, batchId, i));
            // solhint-disable-next-line
            assembly {
                clone := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(clone).callClaimRank(term);
        }
        emit MinerBulkClaimRank(msg.sender, batchId, count, term);
    }

    function minerBulkClaimRank(
        address user,
        uint256 term,
        uint256 count
    ) external onlyMiner returns (uint256 batchId) {
        require(term > 0 && count > 0, "Illedge term or count");
        batchId = ++userBulkAmount[user];

        bulkInfo[user][batchId] = BulkInfo(
            batchId,
            count,
            false,
            // solhint-disable-next-line
            block.timestamp + term * 3600 * 24
        );
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address proxy;
        for (uint256 i = 1; i < count; i++) {
            bytes32 salt = keccak256(abi.encodePacked(user, batchId, i));

            // solhint-disable-next-line
            assembly {
                proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(proxy).callClaimRank(term);
        }
        emit MinerBulkClaimRank(user, batchId, count, term);
    }

    function bulkClaimMint(uint256 batchId) external {
        _bulkMint(msg.sender, batchId);
    }

    function minerBulkClaimMint(
        address user,
        uint256 batchId
    ) external onlyMiner {
        _bulkMint(user, batchId);
    }

    function _bulkMint(address user, uint256 batchId) private {
        require(
            batchId > 0 && batchId <= userBulkAmount[user],
            "Invalid batchId"
        );
        BulkInfo memory info = bulkInfo[user][batchId];
        require(!info.claimed, "Batch is claimed already");
        require(
            // solhint-disable-next-line
            block.timestamp >= info.unlockTime,
            "Unlock time has not yet arrived"
        );

        info.claimed = true;
        bulkInfo[user][batchId] = info;
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(MINI_PROXY),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 1; i < info.volume; i++) {
            bytes32 salt = keccak256(abi.encodePacked(user, batchId, i));
            address clone = address(
                uint160(
                    uint(
                        keccak256(
                            abi.encodePacked(
                                hex"ff",
                                address(this),
                                salt,
                                bytecodeHash
                            )
                        )
                    )
                )
            );
            IMiniProxy(clone).callClaimMintRewardTo(user);
        }
        emit MinerBulkClaimMintReward(user, batchId);
    }
}
