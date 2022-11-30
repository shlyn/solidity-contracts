// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IMiniProxy.sol";

contract XenFactoryV2 {
    struct BatchInfo {
        uint256 batchId;
        uint256 volume;
        bool isClaimed;
        uint256 unlockTime;
    }

    address public constant MINER = 0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public constant MINI_PROXY =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;

    mapping(address => uint256) public userBatchAmount;
    // address => batchId => batchInfo
    mapping(address => mapping(uint256 => BatchInfo)) public batchInfo;

    event MinerBulkClaimRank(
        address indexed user,
        uint256 term,
        uint256 count,
        uint256 batchId
    );
    event MinerBulkClaimMintReward(address indexed user, uint256 batchId);

    modifier onlyMiner() {
        require(msg.sender == MINER, "unauthorized");
        _;
    }

    function minerBulkClaimRank(
        address user,
        uint256 term,
        uint256 count
    ) external onlyMiner returns (uint256 batchId) {
        batchId = ++userBatchAmount[user];
        batchInfo[user][batchId] = BatchInfo(
            batchId,
            count,
            false,
            block.timestamp + term * 3600 * 24
        );
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address clone;
        for (uint256 i = 1; i < count; i++) {
            bytes32 salt = keccak256(abi.encodePacked(user, batchId, i));
            assembly {
                clone := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(clone).callClaimRank(term);
        }
        emit MinerBulkClaimRank(user, term, count, batchId);
    }

    function minerBulkClaimMintReward(address user, uint256 batchId) external {
        require(
            batchId > 0 && batchId <= userBatchAmount[user],
            "Invalid batchId"
        );
        BatchInfo memory info = batchInfo[user][batchId];
        require(!info.isClaimed, "Batch is claimed already");
        require(
            block.timestamp >= info.unlockTime,
            "Unlock time has not yet arrived"
        );

        info.isClaimed = true;
        batchInfo[user][batchId] = info;
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
