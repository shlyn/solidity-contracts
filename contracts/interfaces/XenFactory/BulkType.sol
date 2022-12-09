// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface BulkType {
    struct BulkInfo {
        uint256 bulkId;
        uint256 count;
        uint256 term;
        bool claimable;
        uint256 unlockTime;
    }
}
