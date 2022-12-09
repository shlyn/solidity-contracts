import { ethers } from "hardhat";

const _deployMiniProxy = async () => {
  const Contract = await ethers.getContractFactory("MiniProxy");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`MiniProxy deployed to ${contract.address}`);
}

const _deployXenFactory = async () => {
  const Contract = await ethers.getContractFactory("XenFactory");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`XenFactory deployed to ${contract.address}`);
}

async function main() {
    // await _deployMiniProxy()
    // await _deployXenFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
