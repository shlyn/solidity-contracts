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
    address public constant XEN_CRYPTO =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public constant XEN_FACTORY =
        0x271fF3bEB4859973422e3E04De1f25dAA1757A23;
    address public immutable origin;

    constructor() {
        origin = address(this);
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == XEN_FACTORY, "MiniProxy: only xen factory.");
        IXENCrypto(XEN_CRYPTO).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external {
        require(msg.sender == XEN_FACTORY, "MiniProxy: only xen factory.");
        IXENCrypto(XEN_CRYPTO).claimMintRewardAndShare(to, uint256(100));
    }

    function destroy(address receiver) external {
        require(origin != address(this), "MiniProxy: unauthorized");
        require(msg.sender == XEN_FACTORY, "MiniProxy: only xen factory.");
        selfdestruct(payable(receiver));
    }
}
