// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

interface IXENProxyImplementation {
    function callClaimRank(uint256 term) external;
}

/// @title XENCrypto batch
/// @author Forrest.liu
/// @notice EOA can use this contact to batch mint XENCrypto token
/// @dev it is a upgradeable contract
contract XENFactoryUpgradeable is OwnableUpgradeable {
    address public proxyImplementation;
    bytes32 public bytecodeHash;

    mapping(address => uint256) public userMintIndex;

    /// @notice Set the owner
    /// @dev Just only excute once
    function initialize() external initializer {
        __Ownable_init();
    }

    /// @dev set proxy implementation contact address
    /// @param _proxyImplementation The address of XENProxyImplementation contract
    function setProxyImplementation(address _proxyImplementation) external onlyOwner {
        proxyImplementation = _proxyImplementation;
        bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(_proxyImplementation),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
    }

    /// @notice Batch create the proxy contract
    /// @dev Just create the proxy contract ant not to mint XENCrypto
    /// @param count The amount of proxy contract to create
    function batchCreateProxy(uint256 count) external {
        require(tx.origin == msg.sender);
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(proxyImplementation),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        uint256 index = userMintIndex[msg.sender] + 1;
        uint256 stop = index + count;
        for (uint256 i = index; i < stop;) {
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
    

    /// @notice  Batch create proxy and to mint XENCrypto
    /// @dev Create and Mint 
    /// @param term uint256 the mint term
    /// @param count uint256 the amount to mint
    function batchMint(uint256 term, uint256 count) external {
        require(tx.origin == msg.sender);
        bytes memory bytecode = bytes.concat(
            bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
            bytes20(proxyImplementation),
            bytes15(0x5af43d82803e903d91602b57fd5bf3)
        );
        bytes memory data = abi.encodeWithSignature("callClaimRank(uint256)", term);
        uint256 index = userMintIndex[msg.sender] + 1;
        uint256 length = index + count;
        for (uint256 i = index; i < length;) {
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

    /// @notice To Batch claim XENCrypto
    /// @dev Only batch to claim, not include the action of mint
    /// @param ids uint256[] the id of proxy contract
    function batchClaim(uint256[] calldata ids) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(proxyImplementation), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        bytes memory data = abi.encodeWithSignature("callClaimMintRewardAndShare(address)", msg.sender);
        uint256 length = ids.length;
        for (uint256 i = 0; i < length;) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked( hex"ff", address(this), salt, _bytecodeHash)))));
            assembly {
                // solhint-disable-next-line
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                ++i;
            }
        }
    }

    /// @notice
    /// @dev batchClaimAndMint
    /// @param ids uint256[]
    /// @param term uint256
    function batchReuseMint(uint256[] calldata ids, uint256 term) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(
            abi.encodePacked(
                bytes.concat(
                    bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73),
                    bytes20(proxyImplementation),
                    bytes15(0x5af43d82803e903d91602b57fd5bf3)
                )
            )
        );
        bytes memory data = abi.encodeWithSignature("callClaimRank(uint256)", uint256(term));
        uint256 length = ids.length;
        for (uint256 i = 0; i < length;) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            assembly {
                // solhint-disable-next-line
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                ++i;
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
        bytes memory claimData = abi.encodeWithSignature("callClaimMintRewardAndShare(address)", msg.sender);
        bytes memory mintData = abi.encodeWithSignature("callClaimRank(uint256)", uint256(term));
        uint256 length = ids.length;
        for (uint256 i = 0; i < length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            assembly {
                // solhint-disable-next-line
                let claimed := call(gas(), proxy, 0, add(claimData, 0x20), mload(claimData), 0, 0)
                // solhint-disable-next-line
                let minted := call(gas(), proxy, 0, add(mintData, 0x20), mload(mintData), 0, 0)
            }
            unchecked {
                ++i;
            }
        }
    }

    /// @notice
    /// @dev callKill
    /// @param ids The number of proxy contract
    function callKill(uint256[] calldata ids) external {
        require(tx.origin == msg.sender);
        bytes32 _bytecodeHash = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(proxyImplementation), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        bytes memory data = abi.encodeWithSignature("destroy(address)", msg.sender);
        for (uint256 i = 0; i < ids.length; ) {
            bytes32 salt = keccak256(abi.encodePacked(msg.sender, ids[i]));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex"ff", address(this), salt, _bytecodeHash)))));
            assembly {
                // solhint-disable-next-line
                let killed := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
            }
            unchecked {
                ++i;
            }
        }
    }
}
