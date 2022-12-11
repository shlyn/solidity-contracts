// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract BoxV2 {
    uint256 private _value;

    event ValueChanged(uint256 newValue);

    function store(uint256 newValue) public {
        _value = newValue;
        emit ValueChanged(newValue);
    }

    function retrieve() public view returns (uint256) {
        return _value;
    }

    // new add
    function increment() public {
        _value = _value + 1;
        emit ValueChanged(_value);
    }
}
