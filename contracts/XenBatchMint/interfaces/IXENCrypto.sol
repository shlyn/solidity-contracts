// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IXENCrypto {
    function claimRank(uint256 term) external;

    function claimMintReward() external;

    function claimMintRewardAndShare(address other, uint256 pct) external;

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}
