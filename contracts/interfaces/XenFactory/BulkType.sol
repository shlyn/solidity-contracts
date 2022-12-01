// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface BulkType {
    struct BulkInfo {
        uint256 bulkId;
        uint256 volume;
        bool claimed;
        uint256 unlockTime;
    }
}
