// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/XenFactory/IMiniProxy.sol";

contract XenFactory {
    // @TODO:
    address public constant MINI_PROXY =
        0x3176A1200B2c00F50E3C648597508CB784aE021F;

    mapping(address => uint256) public userMintIndex;

    function multiMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(count > 0, "Invalid count");
        require(term > 0, "Invalid term");
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 startIndex = userMintIndex[msg.sender] + 1;
        userMintIndex[msg.sender] += count;
        address proxy;
        for (uint256 i = startIndex; i < startIndex + count; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            assembly {
                proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(proxy).callClaimRank(term);
            unchecked {
                i++;
            }
        }
    }

    function multiReuseMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(term > 0, "Invalid term");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(MINI_PROXY),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
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

    function multiClaim(uint256[] calldata ids) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(MINI_PROXY),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
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
            IMiniProxy(proxy).callClaimMintRewardTo(msg.sender);
            unchecked {
                i++;
            }
        }
    }
}
