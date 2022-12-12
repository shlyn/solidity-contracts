import { ethers, upgrades } from "hardhat";

const _deployXENProxy = async () => {
  const Contract = await ethers.getContractFactory("XENProxy");
  const contract = await Contract.deploy();

  await contract.deployed();
  console.log(`XENProxy be deployed to ${contract.address}`);
}

const _deployXENFactory = async () => {
  const XENFactory = await ethers.getContractFactory("XENFactory");
  // First check the contant XEN_PROXY = ?
  const contract = await upgrades.deployProxy(XENFactory)
  await contract.deployed();
  console.log(`XENFactory be deployed to ${contract.address}`);
}


const _upgradeXENFactory = async () => {
  const agenter = ""
  const XENFactory = await ethers.getContractFactory("XENFactory");
  const factory = await upgrades.upgradeProxy(agenter, XENFactory);
  console.log("XENFactory is upgrade to: ", factory.address);
}

async function main() {
  // await _deployXENProxy()

  await _deployXENFactory()

  // upgrade XENFactory
  // await _upgradeXENFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
