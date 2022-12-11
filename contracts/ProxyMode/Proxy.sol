// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface ILogic {
    function setNum(uint256 number) external;
}

contract Proxy {
    address public owner;
    uint256 public num;
    address public sender;

    constructor() {
        owner = msg.sender;
    }

    function callSetNum(address _becall, uint256 number) external {
        ILogic(_becall).setNum(number);
        // (bool success,) = _becall.call(abi.encodeWithSignature("setNum(uint256)", number));
        // require(success, "Error: call failed");
    }

    function delegatecallSetNum(address _becall, uint256 number) external {
        // solhint-disable-next-line
        (bool success, ) = _becall.delegatecall(
            abi.encodeWithSignature("setNum(uint256)", number)
        );
        require(success, "Error: delegatecall failed");
    }
}
