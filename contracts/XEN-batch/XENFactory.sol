// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title XENCrypto manual batch mint and claim contract
/// @author Forrest.liu
/// @notice You can use this contact to batch mint XENCrypto token
/// @dev All function calls
contract XENFactory {
    address public immutable owner;
    address public proxyImplementation;

    mapping(address => uint256) public userMintIndex;

    constructor() {
        owner = tx.origin;
    }

    receive() external payable {}

    /// @dev set proxy implementation contact address
    /// @param _proxyImplementation The address of XENProxyImplementation
    function setFactory(address _proxyImplementation) external {
        require(owner == msg.sender, "noauthority");
        proxyImplementation = _proxyImplementation;
    }

    // batch create Proxy contract

    /// @notice
    /// @dev
    /// @param term The number of days to mint
    /// @param count The number of proxy contract
    function batchMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(count > 0 && term > 0, "Invalid Params");
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(proxyImplementation),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 startIndex = userMintIndex[msg.sender] + 1;
        userMintIndex[msg.sender] += count;
        bytes memory data = abi.encodeWithSignature(
            "callClaimRank(uint256)",
            uint256(term)
        );
        address proxy;
        for (uint256 i = startIndex; i < startIndex + count; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            assembly {
                proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
                // solhint-disable-next-line
                let succeeded := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            unchecked {
                ++i;
            }
        }
    }

    /// @notice
    /// @dev
    /// @param ids The number of days to mint
    /// @param term The number of proxy contract
    function batchReuseMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(ids.length > 0 && term > 0, "Invalid Params");

        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
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
            bytes memory data = abi.encodeWithSignature(
                "callClaimRank(uint256)",
                uint256(term)
            );
            assembly {
                // solhint-disable-next-line
                let succeeded := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice
    /// @dev
    /// @param ids The number of days to mint
    function batchClaim(uint256[] calldata ids) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
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
            bytes memory data = abi.encodeWithSignature(
                "callClaimMintRewardAndShare(address)",
                msg.sender
            );
            assembly {
                // solhint-disable-next-line
                let succeeded := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice
    /// @dev
    /// @param ids The number of days to mint
    /// @param term The number of proxy contract
    function batchClaimAndMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(term > 0, "Invalid Params");

        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
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
            bytes memory claimData = abi.encodeWithSignature(
                "callClaimMintRewardAndShare(address)",
                msg.sender
            );
            bytes memory mintData = abi.encodeWithSignature(
                "callClaimRank(uint256)",
                uint256(term)
            );
            assembly {
                // solhint-disable-next-line
                let claimRes := call(
                    gas(),
                    proxy,
                    0,
                    add(claimData, 0x20),
                    mload(claimData),
                    0,
                    0
                )
                // solhint-disable-next-line
                let mintRes := call(
                    gas(),
                    proxy,
                    0,
                    add(mintData, 0x20),
                    mload(mintData),
                    0,
                    0
                )
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice
    /// @dev
    /// @param ids The number of days to mint
    function callKill(uint256[] calldata ids) external {
        require(tx.origin == msg.sender, "Error: Only EOA");

        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
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
            bytes memory data = abi.encodeWithSignature(
                "destroy(address)",
                msg.sender
            );
            assembly {
                // solhint-disable-next-line
                let Res := call(
                    gas(),
                    proxy,
                    0,
                    add(data, 0x20),
                    mload(data),
                    0,
                    0
                )
            }
            unchecked {
                i++;
            }
        }
    }
}
