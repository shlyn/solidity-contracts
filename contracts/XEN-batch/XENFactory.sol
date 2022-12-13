// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IXENProxy.sol";
import "./interfaces/IXENCrypto.sol";
import "hardhat/console.sol";

contract XENProxyV1 is IXENProxy {
    address public immutable xenCrypto;
    address public immutable factory;

    constructor(address _xenCrypto, address _factory) {
        require(_factory != address(0), "Invalid factory");
        xenCrypto = _xenCrypto;
        factory = _factory;
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(xenCrypto).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(xenCrypto).claimMintRewardAndShare(to, uint256(100));
    }

    // @TODO:
    // function destroy(address receiver) external {
    //     require(self != address(this));
    //     require(msg.sender == factory, "MiniProxy: only factory.");
    //     selfdestruct(payable(receiver));
    // }
}

contract XENFactory {
    // @TODO:
    address public constant XEN_PROXY =
        0x97d4Cb159b67F92F0053a5371fCEa3FA97445AD5;
    address public xenProxy;

    mapping(address => uint256) public userMintIndex;

    // @TEST
    function initialize(address _xenProxy) external {
        xenProxy = _xenProxy;
    }

    function batchMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        // require(count > 0, "Invalid count");
        // require(term > 0, "Invalid term");
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(xenProxy),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 startIndex = userMintIndex[msg.sender] + 1;
        userMintIndex[msg.sender] += count;
        address proxy;
        bytes memory data = abi.encodeWithSignature(
            "callClaimRank(uint256)",
            uint256(term)
        );
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

    function batchReuseMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(term > 0, "Invalid term");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(xenProxy),
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
                    bytes20(xenProxy),
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

    function batchClaimAndMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        bytes32 bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(xenProxy),
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
