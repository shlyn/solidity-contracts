import { ethers } from "hardhat";

const deployContract = async () => {
  const Contract = await ethers.getContractFactory("CoinTool_App");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`Contract deployed to ${contract.address}`);
}

async function main() {
    await deployContract()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});