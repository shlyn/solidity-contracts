// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IMiniProxy.sol";
import "./interfaces/IXENCrypto.sol";

// XENCrypto mini proxy
contract MiniProxy is IMiniProxy {
    address public constant XEN_CRYPTO =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public constant XEN_BATCH_MINT =
        0xAE272C6Ea3FdB317BCA0e83A9CB169f0d0f1073E;
    address private immutable _original;

    constructor() {
        _original = address(this);
    }

    modifier onlyOwner() {
        require(msg.sender == XEN_BATCH_MINT, "unauthorized");
        _;
    }

    function callClaimRank(uint term) external onlyOwner {
        IXENCrypto(XEN_CRYPTO).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external onlyOwner {
        IXENCrypto(XEN_CRYPTO).claimMintRewardAndShare(to, 100);
        if (_original == address(0)) {
            // solhint-disable-next-line
            selfdestruct(payable(tx.origin));
        }
    }
}
