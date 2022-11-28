// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Logic {
    address public owner;
    uint256 public num;
    address public sender;

    constructor() {
        owner = msg.sender;
    }

    function setNum(uint256 number) external {
        require(number > 1, "BeCall: number value should large 1");
        sender = msg.sender;
        num = number;
    }
}
