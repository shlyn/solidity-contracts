// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IMiniProxy.sol";

contract XenFactoryV1 {
    address public immutable miniProxy_;

    mapping(address => uint) public claimRank;
    mapping(address => uint) public claimMint;

    constructor(address _miniProxy) {
        require(_miniProxy != address(0), "Illegal address");
        miniProxy_ = _miniProxy;
    }

    function batchClaimRank(uint counts, uint term) external {
        require(counts > 0, "Illegal count");
        require(term > 0, "Illegal term");
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(address(miniProxy_)),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address proxy;
        uint startIndex = claimRank[msg.sender] + 1;

        for (uint i = startIndex; i < startIndex + counts; i++) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            // solhint-disable-next-line
            assembly {
                proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            IMiniProxy(proxy).callClaimRank(term);
        }
        claimRank[msg.sender] += counts;
    }

    function batchClaimMintRewardTo(uint counts) external {
        require(counts > 0, "Illegal count");
        uint claimRanked = claimRank[msg.sender];
        uint claimMinted = claimMint[msg.sender];
        uint claimMintPos = claimMinted + counts < claimRanked
            ? claimMinted + counts
            : claimRanked;

        for (uint i = claimMinted + 1; i < claimMintPos + 1; i++) {
            address proxy = _proxyFor(msg.sender, i);
            IMiniProxy(proxy).callClaimMintRewardTo(msg.sender);
        }

        claimMint[msg.sender] = claimMintPos;
    }

    function _proxyFor(
        address sender,
        uint i
    ) private view returns (address proxy) {
        bytes32 salt = keccak256(abi.encodePacked(sender, i));
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(address(miniProxy_)),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        proxy = address(
            uint160(
                uint(
                    keccak256(
                        abi.encodePacked(
                            hex"ff",
                            address(this),
                            salt,
                            keccak256(abi.encodePacked(bytecode))
                        )
                    )
                )
            )
        );
    }
}
