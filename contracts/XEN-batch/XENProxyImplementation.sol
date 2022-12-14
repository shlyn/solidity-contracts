// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IXENCrypto.sol";

contract XENProxyImplementation {
    address public immutable self = address(this);
    address public immutable xenCrypto;
    address public immutable factory;

    constructor(address _xenCrypto, address _factory) {
        require(_xenCrypto != address(0) && _factory != address(0), "Invalid");
        xenCrypto = _xenCrypto;
        factory = _factory;
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == factory, "Only XENFactory.");
        IXENCrypto(xenCrypto).claimRank(term);
    }

    function callClaimMintRewardAndShare(address to) external {
        require(msg.sender == factory, "Only XENFactory.");
        IXENCrypto(xenCrypto).claimMintRewardAndShare(to, uint256(100));
    }

    function destroy(address receiver) external {
        require(msg.sender == factory && self != address(this));
        selfdestruct(payable(receiver));
    }
}
