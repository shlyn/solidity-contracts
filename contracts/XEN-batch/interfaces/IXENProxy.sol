// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IXENProxy {
    function callClaimRank(uint256 term) external;

    function callClaimMintRewardTo(address to) external;
}
