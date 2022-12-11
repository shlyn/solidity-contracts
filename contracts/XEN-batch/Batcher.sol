// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Batcher {
    // @TODO:
    address public constant MINI_PROXY =
        0x1572d014e1E5D1d668dE8A4984Cf830b3b68BA35;

    mapping(address => uint256) public userMintIndex;

    function multiMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        // require(count > 0, "Invalid count");
        // require(term > 0, "Invalid term");
        uint256 startIndex = userMintIndex[msg.sender] + 1;
        userMintIndex[msg.sender] += count;
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(MINI_PROXY),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        bytes memory data = abi.encodeWithSignature(
            "xenCaller(bytes)",
            abi.encodeWithSignature("claimRank(uint256)", term)
        );
        for (uint256 i = startIndex; i < startIndex + count; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            assembly {
                let proxy := create2(
                    0,
                    add(bytecode, 32),
                    mload(bytecode),
                    salt
                )
                // solhint-disable-next-line
                let success := call(
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
        bytes memory data = abi.encodeWithSignature(
            "xenCaller(bytes)",
            abi.encodeWithSignature("claimRank(uint256)", term)
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
            assembly {
                // solhint-disable-next-line
                let success := call(
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
        bytes memory data = abi.encodeWithSignature(
            "xenCaller(bytes)",
            abi.encodeWithSignature(
                "claimMintRewardAndShare(address,uint256)",
                msg.sender,
                uint256(100)
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
            assembly {
                // solhint-disable-next-line
                let success := call(
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
