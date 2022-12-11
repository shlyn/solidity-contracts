import { ethers } from "hardhat";

const _deployMiner = async () => {
  const Contract = await ethers.getContractFactory("Miner");
  const contract = await Contract.deploy("0xd93CcDfD32390A235959707244921E4eeb85ac6c");

  await contract.deployed();
  console.log(`Deployed to ${contract.address}`);
}

const _deployXenFactory = async () => {
  const Contract = await ethers.getContractFactory("Batcher");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`Deployed to ${contract.address}`);
}

async function main() {
    await _deployMiner()
    await _deployXenFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});