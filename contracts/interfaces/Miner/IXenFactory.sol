// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IXenFactory {
    function minerBulkMint(
        address user,
        uint256 term,
        uint256 count
    ) external returns (uint256 bulkId);

    function minerBulkClaim(address user, uint256 bulkId) external;
}
