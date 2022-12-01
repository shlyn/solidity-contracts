// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../interfaces/XenFactory/IMiniProxy.sol";
import "../interfaces/XenFactory/IXENCrypto.sol";

// XENCrypto mini proxy
contract MiniProxy is IMiniProxy {
    address public constant XEN_CRYPTO =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public constant XEN_FACTORY =
        0xAE272C6Ea3FdB317BCA0e83A9CB169f0d0f1073E;

    modifier onlyFactory() {
        require(msg.sender == XEN_FACTORY, "unauthorized");
        _;
    }

    function callClaimRank(uint term) external onlyFactory {
        IXENCrypto(XEN_CRYPTO).claimRank(term);
    }

    function callClaimMintRewardTo(address to) external onlyFactory {
        IXENCrypto(XEN_CRYPTO).claimMintRewardAndShare(to, 100);
        // solhint-disable-next-line
        selfdestruct(payable(tx.origin));
    }
}
