// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/AutoMiner/MinerType.sol";
import "../interfaces/XenFactory/BulkType.sol";

contract MinerStorage {
    uint256 public constant COUNT_PER_BULK = 100;
    uint256 public constant GAS_USED_PER_BULK_MINT = 19_000_000;
    uint256 public constant GAS_USED_PER_BULK_CLAIM = 7_000_000;

    address public factory;
    uint256 public memberFee;

    uint256 public globalMintIndex;
    uint256 public taskCountPerMember;

    mapping(address => bool) public isRobot;
}
