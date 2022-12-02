// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
}

contract CoinTool_App {
    address owner;
    address private immutable original;
    mapping(address => mapping(bytes =>uint256)) public map;

    constructor() payable {
        original = address(this);
        owner = tx.origin;
    }

    receive() external payable {}
    fallback() external payable{}

    function t(uint256 total,bytes memory data,bytes calldata _salt) external payable {
        require(msg.sender == tx.origin);
        bytes memory bytecode = bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(address(this)), bytes15(0x5af43d82803e903d91602b57fd5bf3));
        uint256 i = map[msg.sender][_salt]+1;
        uint256 end = total+i;
        for (i; i < end;++i) {
	        bytes32 salt = keccak256(abi.encodePacked(_salt,i,msg.sender));
			assembly {
	            let proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
			}
        }
        map[msg.sender][_salt] += total;
    }


    function t_(uint256[] calldata a,bytes memory data,bytes calldata _salt) external payable {
        require(msg.sender == tx.origin);
        bytes memory bytecode = bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(address(this)), bytes15(0x5af43d82803e903d91602b57fd5bf3));
        uint256 i = 0;
        for (i; i < a.length; ++i) {
	        bytes32 salt = keccak256(abi.encodePacked(_salt,a[i],msg.sender));
			assembly {
	            let proxy := create2(0, add(bytecode, 32), mload(bytecode), salt)
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
			}
        }
        uint256 e = a[a.length-1];
        if(e>map[msg.sender][_salt]){
           map[msg.sender][_salt] = e;
        }
    }

    function f(uint256[] calldata a,bytes memory data,bytes memory _salt) external payable {
        require(msg.sender == tx.origin);
        bytes32 bytecode = keccak256(abi.encodePacked(bytes.concat(bytes20(0x3D602d80600A3D3981F3363d3d373d3D3D363d73), bytes20(address(this)), bytes15(0x5af43d82803e903d91602b57fd5bf3))));
        uint256 i = 0;
        for (i; i < a.length; ++i) {
	        bytes32 salt = keccak256(abi.encodePacked(_salt,a[i],msg.sender));
            address proxy = address(uint160(uint(keccak256(abi.encodePacked(hex'ff', address(this), salt, bytecode)))));
			assembly {
                let succeeded := call(gas(), proxy, 0, add(data, 0x20), mload(data), 0, 0)
			}
        }
    }

    // function d(address a,bytes memory data) external payable{
    //     require(msg.sender == original);
    //     a.delegatecall(data);
    // }

    function c(address a,bytes calldata data) external payable {
       require(msg.sender == original);
       external_call(a,data);
    }

    // function dKill(address a,bytes memory data) external payable{
    //     require(msg.sender == original);
    //     a.delegatecall(data);
    //     selfdestruct(payable(msg.sender));
    // }

    function cKill(address a,bytes calldata data) external payable {
       require(msg.sender == original);
       external_call(a,data);
       selfdestruct(payable(msg.sender));
    }

    function k() external {
        require(msg.sender == original);
        selfdestruct(payable(msg.sender));
    }
   
    function external_call(address destination,bytes memory data) internal {
        assembly {
            let succeeded := call(gas(), destination, 0, add(data, 0x20), mload(data), 0, 0)
        }
    }


    function claimTokens(address _token) external  {
        require(owner == msg.sender);
        if (_token == address(0x0)) {
           payable (owner).transfer(address(this).balance);
            return;
        }
        IERC20 erc20token = IERC20(_token);
        uint256 balance = erc20token.balanceOf(address(this));
        erc20token.transfer(owner, balance);
    }
}

// 0x59635f6f00000000000000000000000006450dee7fd2fb8e39061434babcfc05599a6fb8000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000441c560305000000000000000000000000f3b60C1d342b964e5aBa270741AA56e2C22b47BC000000000000000000000000000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000000000
// 0x51F92552B230e7Ea3dd4591D4704b5083d1f3C10
// 06450dee7fd2fb8e39061434babcfc05599a6fb8
// f3b60c1d342b964e5aba270741aa56e2c22b47bc
// 0x59635f6f00000000000000000000000006450dee7fd2fb8e39061434babcfc05599a6fb8000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000441c560305000000000000000000000000f3b60c1d342b964e5aba270741aa56e2c22b47bc000000000000000000000000000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000000000
