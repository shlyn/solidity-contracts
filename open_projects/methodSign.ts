import { ethers } from 'ethers'

// const getTopic = () => {
//     // RankClaimed(address indexed user, uint256 term, uint256 rank)
//     // const hash = ethers.utils.keccak256(ethers.utils.solidityPack(["address", "uint256"], [userAddress, index]))
//     const hash = ethers.utils.id("RankClaimed(address,uint256,uint256)")
//     // const hash = ethers.utils.id("batchMint(uint256,uint256)")
//     console.log(hash)
// } 

// getTopic()

const getTopic = () => {
    const hash = ethers.utils.id("RankClaimed(address,uint256,uint256)")
    console.log(hash)
} 


console.log(ethers.utils.hexZeroPad("0x51F92552B230e7Ea3dd4591D4704b5083d1f3C10", 32))