// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "hardhat/console.sol";

contract Template {
    uint256 public a;
    uint256 public immutable b;
    address public immutable c = address(this);

    constructor(uint256 b_) {
        b = b_;
    }

    function setA(uint256 a_) external {
        a = a_;
    }
}

interface ITemplate {
    function a() external returns (uint256);

    function b() external returns (uint256);

    function c() external returns (address);

    function setA(uint256 a_) external;
}

contract TestCreate2 {
    uint256 public res1;
    uint256 public res2;
    address public res3;
    address public immutable template;

    constructor(address template_) {
        template = template_;
    }

    function createMinimalProxy(uint256 i) external {
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(template),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address proxy;
        bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
        assembly {
            proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        ITemplate(proxy).setA(uint256(1000));
    }

    function createMinimalProxy2(uint256 i) external {
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(template),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        address proxy;
        bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
        bytes memory data = abi.encodeWithSignature(
            "setA(uint256)",
            uint256(1000)
        );
        assembly {
            proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            // solhint-disable-next-line
            let succeed := call(
                gas(),
                proxy,
                0,
                add(data, 0x20),
                mload(data),
                0,
                0
            )
        }
    }
}
