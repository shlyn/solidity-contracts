// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IXENCrypto.sol";
import "./interfaces/IXENProxy.sol";

contract XENProxy is IXENProxy {
    address public immutable factory;
    address public immutable xenCrypto;

    constructor(address factory_, address xenCrypto_) {
        factory = factory_;
        xenCrypto = xenCrypto_;
    }

    function callClaimRank(address _xenCrypto, uint256 term) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(_xenCrypto).claimRank(term);
    }

    function callClaimMintRewardTo(address _xenCrypto, address to) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(_xenCrypto).claimMintRewardAndShare(to, uint256(100));
    }

    function callClaimRank(uint256 term) external {
        require(msg.sender == factory, "MiniProxy: only factory.");
        IXENCrypto(xenCrypto).claimRank(term);
    }

    function callXEN(bytes memory data) external {
        require(msg.sender == factory, "invalid caller");
        address xenAddress = xenCrypto;
        assembly {
            // solhint-disable-next-line
            let succeeded := call(
                gas(),
                xenAddress,
                0,
                add(data, 0x20),
                mload(data),
                0,
                0
            )
        }
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
