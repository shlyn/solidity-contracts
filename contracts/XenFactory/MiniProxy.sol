// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/XenFactory/IMiniProxy.sol";
import "../interfaces/XenFactory/IXENCrypto.sol";

/**
 * XEN_CRYPTO:
 * mainnet:
 * goerli: 0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93
 *
 * XEN_FACTORY:
 * mainnet:
 * goerli:
 *
 */
contract MiniProxy is IMiniProxy {
    address constant _XEN_CRYPTO = 0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address immutable _owner;
    address private _factory;

    constructor() {
        _owner = msg.sender;
    }

    function setFactory(address factory_) external {
        require(msg.sender == _owner, "MiniProxy: unauthorized");
        require(factory_ != address(0), "MiniProxy: invalid factory");
        _factory = factory_;
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == _factory, "MiniProxy: only factory.");
        IXENCrypto(_XEN_CRYPTO).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external {
        require(msg.sender == _factory, "MiniProxy: only factory.");
        IXENCrypto(_XEN_CRYPTO).claimMintRewardAndShare(to, uint256(100));
    }

    function destroy(address receiver) external {
        require(msg.sender == _factory, "MiniProxy: only factory.");
        selfdestruct(payable(receiver));
    }
}
