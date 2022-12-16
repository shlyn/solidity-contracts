// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/// @title XENCrypto manual batch mint and claim contract
/// @author Forrest.liu
/// @notice You can use this contact to batch mint XENCrypto token
/// @dev All function calls
contract XENFactory {
    address public immutable owner;
    address public proxyImplementation;

    mapping(address => uint256) public userMintIndex;

    constructor() {
        owner = tx.origin;
    }

    /// @dev set proxy implementation contact address
    /// @param _proxyImplementation The address of XENProxyImplementation
    function setProxyImplementation(address _proxyImplementation) external {
        require(owner == msg.sender, "noauthority");
        proxyImplementation = _proxyImplementation;
    }

    /// @notice
    /// @dev
    /// @param count The amount of proxy contract
    function batchCreateProxy(uint256 count) external {
        require(tx.origin == msg.sender);
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(proxyImplementation),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 index = userMintIndex[msg.sender] + 1;
        for (uint256 i = index; i < index + count;) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            assembly {
                let proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            unchecked {
                ++i;
            }
        }
        userMintIndex[msg.sender] += count;
    }
    

    /// @notice
    /// @dev batchMint
    /// @param term uint256
    /// @param count uint256
    function batchMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender);
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(proxyImplementation),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        bytes memory data = abi.encodeWithSignature("callClaimRank(uint256)", term);
        uint256 index = userMintIndex[msg.sender] + 1;
        for (uint256 i = index; i < index + count;) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, i));
            assembly {
                let proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
                // solhint-disable-next-line
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                ++i;
            }
        }
        userMintIndex[msg.sender] += count;
    }

    /// @notice
    /// @dev batchClaim
    /// @param ids uint256[]
    function batchClaim(uint256[] calldata ids) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(proxyImplementation), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        for (uint256 i = 0; i < ids.length;) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked( hex"ff", address(this), salt, _bytecodeHash)))));
            bytes memory data = abi.encodeWithSignature("callClaimMintRewardAndShare(address)", msg.sender);
            assembly {
                // solhint-disable-next-line
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                i++;
            }
        }
    }

    function batchReuseMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender, "Error: Only EOA");
        require(ids.length > 0 && term > 0, "Invalid Params");
        bytes32 _bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            bytes memory data = abi.encodeWithSignature("callClaimRank(uint256)", uint256(term));
            assembly {
                // solhint-disable-next-line
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice
    /// @dev batchClaimAndMint
    /// @param ids uint256[]
    /// @param term uint256
    function batchClaimAndMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(proxyImplementation), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            bytes memory claimData = abi.encodeWithSignature("callClaimMintRewardAndShare(address)", msg.sender);
            bytes memory mintData = abi.encodeWithSignature("callClaimRank(uint256)", uint256(term));
            assembly {
                // solhint-disable-next-line
                let claimRes := call(gas(), proxy, 0, add(claimData, 0x20), mload(claimData), 0, 0)
                // solhint-disable-next-line
                let mintRes := call(gas(), proxy, 0, add(mintData, 0x20), mload(mintData), 0, 0)
            }
            unchecked {
                i++;
            }
        }
    }

    /// @notice
    /// @dev callKill
    /// @param ids The number of proxy contract
    function callKill(uint256[] calldata ids) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(proxyImplementation), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            bytes memory data = abi.encodeWithSignature("destroy(address)", msg.sender);
            assembly {
                // solhint-disable-next-line
                let Res := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                i++;
            }
        }
    }
}
