// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./MinerStorage.sol";

// import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// contract Miner is MinerStorage, Ownable, Initializable {
contract Miner is MinerStorage {
    receive() external payable {
        memberFee += msg.value;
    }

    // function initialize(address _factory) external initializer {
    // __Ownable_init();

    // factory = _factory;
    // minGasPrice = 100_000_000;
    // taskCountPerMember = 5;
    // }
}
