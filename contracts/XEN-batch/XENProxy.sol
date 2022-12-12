// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IXENCrypto.sol";
import "./IXENProxy.sol";

contract XENProxy is IXENProxy {
    address public immutable factory;
    address public immutable xenCrypto;

    constructor(address factory_, address xenCrypto_) {
        factory = factory_;
        xenCrypto = xenCrypto_;
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(xenCrypto).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(xenCrypto).claimMintRewardAndShare(to, uint256(100));
    }

    function destroy(address receiver) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        selfdestruct(payable(receiver));
    }
}
