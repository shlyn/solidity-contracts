import { ethers } from "hardhat";

const deployMiner = async () => {
  const Contract = await ethers.getContractFactory("Miner");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`MiniProxy deployed to ${contract.address}`);
}

async function main() {
    await deployMiner()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});