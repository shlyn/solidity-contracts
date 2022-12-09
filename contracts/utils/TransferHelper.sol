// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract TransferHelper {
    function _transfer(address to, uint256 value) internal {
        if (value > 0) {
            (bool success, ) = payable(to).call{value: value, gas: 8000}("");
            require(success, "transfer native token failed");
        }
    }
}
