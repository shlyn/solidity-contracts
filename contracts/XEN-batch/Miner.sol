// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Miner {
    // @TODO:
    address public constant XEN_CRYPTO =
        0xDd68332Fe8099c0CF3619cB3Bb0D8159EF1eCc93;
    address public immutable factory;

    constructor(address factory_) {
        factory = factory_;
    }

    function xenCaller(bytes memory data) external {
        require(msg.sender == factory, "Miner: invalid caller");
        address destination = XEN_CRYPTO;
        // solhint-disable-next-line
        assembly {
            // solhint-disable-next-line
            let succeeded := call(
                gas(),
                destination,
                0,
                add(data, 0x20),
                mload(data),
                0,
                0
            )
        }
    }

    // @TODO:
    function destroy(address receiver) external {
        require(msg.sender == factory, "Miner: unauthorized");
        selfdestruct(payable(receiver));
    }
}
