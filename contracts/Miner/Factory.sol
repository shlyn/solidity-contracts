// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../interfaces/xen-batch/BulkType.sol";
import "../interfaces/xen-batch/IMiniProxy.sol";

contract Factory is OwnableUpgradeable, BulkType {
    // @TODO:
    address public constant MINI_PROXY =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;

    // @TODO:
    // address public constant MINER = 0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    // solhint-disable-next-line
    address public MINER;

    mapping(address => uint256) public userBulkIndex;
    mapping(address => uint256[]) public minerBulkIds;
    /// (address => (bulkId => bulkInfo))
    mapping(address => mapping(uint256 => BulkInfo)) public bulkInfo;

    event BulkMint(
        address indexed user,
        uint256 bulkId,
        uint256 count,
        uint256 term
    );
    event BulkClaim(address indexed user, uint256 bulkId);

    modifier onlyMiner() {
        require(MINER != address(0), "XenFactory: invalid miner");
        require(msg.sender == MINER, "unauthorized");
        _;
    }

    function initialize() external initializer {
        __Ownable_init();
    }

    function setMiner(address _miner) external onlyOwner {
        MINER = _miner;
    }

    /**
     * ***************************************************************************
     * read contract functions
     * ***************************************************************************
     */

    function getUserMintInfo(
        address user
    ) external view returns (BulkInfo[] memory infos) {
        require(user != address(0), "XenFactory: illedge address");
        for (uint i = 1; i < userBulkIndex[user] + 1; ) {
            infos[i - 1] = bulkInfo[user][i];
            unchecked {
                i++;
            }
        }
    }

    /**
     * ***************************************************************************
     * Following is user operations
     * ***************************************************************************
     */

    function bulkMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Only EOA");
        require(count > 0, "Invalid count value");
        require(term > 0, "Illedge term");
        uint256 bulkId = _bulkMint(msg.sender, count, term);
        emit BulkMint(msg.sender, bulkId, count, term);
    }

    function bulkClaim(uint256 bulkId) external {
        require(tx.origin == msg.sender, "Only EOA");
        require(
            bulkId > 0 && bulkId <= userBulkIndex[msg.sender],
            "Invalid bulkId"
        );
        _bulkClaim(msg.sender, bulkId);
        emit BulkClaim(msg.sender, bulkId);
    }

    function multiMint(
        uint256[] calldata a,
        bytes memory data,
        bytes calldata _salt
    ) external payable {
        require(msg.sender == tx.origin);
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(address(this)),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 i = 0;
        for (i; i < a.length; ++i) {
            bytes32 salt = keccak256(abi.encodePacked(_salt, a[i], msg.sender));
            // solhint-disable-next-line
            bool succeeded;
            assembly {
                let proxy := create2(
                    0,
                    add(bytecode, 32),
                    mload(bytecode),
                    salt
                )
                succeeded := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            require(succeeded);
        }
    }

    function multiClaim(
        uint256[] calldata a,
        bytes memory data,
        bytes memory _salt
    ) external payable {
        require(msg.sender == tx.origin);
        bytes32 bytecode = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(address(this)),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        uint256 i = 0;
        for (i; i < a.length; ++i) {
            bytes32 salt = keccak256(abi.encodePacked(_salt, a[i], msg.sender));
            address proxy = address(
                uint160(
                    uint(
                        keccak256(
                            abi.encodePacked(
                                hex"ff",
                                address(this),
                                salt,
                                bytecode
                            )
                        )
                    )
                )
            );
            // solhint-disable-next-line
            bool succeeded;
            assembly {
                succeeded := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            // @TODO:
            require(succeeded);
        }
    }

    /**
     * ***************************************************************************
     * Following is miner operation
     * ***************************************************************************
     */

    function minerBulkMint(
        address user,
        uint256 term,
        uint256 count
    ) external onlyMiner returns (uint256 bulkId) {
        require(count > 0 && count < 101, "Invalid count value");
        require(term > 0, "Illedge term");
        bulkId = _bulkMint(user, count, term);
        emit BulkMint(user, bulkId, count, term);
    }

    function reuseBulkMint(address user, uint256 bulkId) external onlyMiner {
        require(bulkId > 0 && bulkId <= userBulkIndex[user], "Invalid bulkId");
        BulkInfo memory bulk = bulkInfo[user][bulkId];
        require(!bulk.claimable, "Bulk has not yet claimed");
        bulk.claimable = true;
        uint256 term = bulk.term;
        bulk.unlockTime = block.timestamp + term * 3600 * 24;
        bulkInfo[msg.sender][bulkId] = bulk;
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(MINI_PROXY),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 1; i < bulk.count + 1; ) {
            bytes32 salt = keccak256(abi.encodePacked(user, bulkId, i));
            address proxy = address(
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
            IMiniProxy(proxy).callClaimRank(term);
            unchecked {
                i++;
            }
        }
    }

    function minerBulkClaim(address user, uint256 bulkId) external onlyMiner {
        require(user != address(0), "Illedge user address");
        require(bulkId > 0 && bulkId <= userBulkIndex[user], "Invalid bulkId");
        _bulkClaim(user, bulkId);
        emit BulkClaim(user, bulkId);
    }

    /**
     * ***************************************************************************
     * Following is private function
     * ***************************************************************************
     */

    function _bulkMint(
        address user,
        uint256 count,
        uint256 term
    ) private returns (uint256 bulkId) {
        bulkId = ++userBulkIndex[user];
        bulkInfo[user][bulkId] = BulkInfo(
            bulkId,
            count,
            term,
            true,
            block.timestamp + term * 3600 * 24
        );
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address proxy;
        for (uint256 i = 1; i < count + 1; ) {
            bytes32 salt = keccak256(abi.encodePacked(user, bulkId, i));
            // solhint-disable-next-line
            assembly {
                proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(proxy).callClaimRank(term);
            unchecked {
                i++;
            }
        }
    }

    function _bulkClaim(address user, uint256 bulkId) private {
        BulkInfo memory info = bulkInfo[user][bulkId];
        require(
            block.timestamp >= info.unlockTime,
            "Unlock time has not yet arrived"
        );
        require(info.claimable, "Bulk is claimed already");
        info.claimable = false;
        bulkInfo[user][bulkId] = info;

        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(MINI_PROXY),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 1; i < info.count + 1; ) {
            bytes32 salt = keccak256(abi.encodePacked(user, bulkId, i));
            address proxy = address(
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
            IMiniProxy(proxy).callClaimMintRewardTo(user);
            unchecked {
                i++;
            }
        }
    }
}
