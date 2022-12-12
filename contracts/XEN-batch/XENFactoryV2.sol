// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IXENProxy.sol";

contract XENFactoryV2 {
    // @TODO:
    address public constant XEN_PROXY =
        0xFE86E8b070ab4E478FB17CD8648780A6232B763A;

    mapping(address => uint256) public userMintIndex;

    function batchMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(XEN_PROXY),
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
            IXENProxy(proxy).callClaimRank(term);
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
                    bytes20(XEN_PROXY),
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
            IXENProxy(proxy).callClaimRank(term);
            unchecked {
                i++;
            }
        }
    }

    function batchClaim(uint256[] calldata ids) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(XEN_PROXY),
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
            IXENProxy(proxy).callClaimMintRewardTo(msg.sender);
            unchecked {
                i++;
            }
        }
    }

    function batchClaimAndReuse(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(XEN_PROXY),
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
            IXENProxy(proxy).callClaimMintRewardTo(msg.sender);
            IXENProxy(proxy).callClaimRank(term);
            unchecked {
                i++;
            }
        }
    }
}
