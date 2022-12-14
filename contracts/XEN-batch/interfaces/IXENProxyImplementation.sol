// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IXENProxyImplementation {
    function callClaimRank(uint256 term) external;

    function callClaimMintRewardAndShare(address to) external;

    function destroy(address receiver) external;
}
