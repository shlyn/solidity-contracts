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


// console.log(ethers.utils.hexZeroPad("0x51F92552B230e7Ea3dd4591D4704b5083d1f3C10", 32))

const getStorage = async () => {
    const provider = await (new ethers.providers.JsonRpcProvider("https://goerli.infura.io/v3/ca59e94e13e84a1d8ca4ccd2ed56d45d"))
    // const res = await provider.getStorageAt("0x2c44D520c09A6895E3756CB8A32B188Fc726677b", 1)
    const res = await provider.getCode("0x2c44D520c09A6895E3756CB8A32B188Fc726677b")
    return res

}

// getStorage().then(res => console.log(res))
