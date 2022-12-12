import { ethers, upgrades } from "hardhat";
import { DeployedContractAddress } from "../config"

/**
 * @TODO: For upgradable deploy
 * Contract   || Nonce  || Address
 * XENProxy   || 38     || 0xFE86E8b070ab4E478FB17CD8648780A6232B763A
 * XENFactory || 39     || 0xa5e6a194635A956d2cBa837ab30ab9d1Ff62f607
 * Admin      || 40     || 0x9756B99BF162B8FD67092E39BEDE79F663260E44
 * proxies    || 41     || 0x39CBC7985fC8563C30eB98306B18Bdb96C5dB1bF
 */

const deploy_XENProxy = async () => {
  const XENCrypto_ = DeployedContractAddress.goerli.XENCrypto
  const proxies_ = "0x39CBC7985fC8563C30eB98306B18Bdb96C5dB1bF"
  const Contract = await ethers.getContractFactory("XENProxy");
  const contract = await Contract.deploy(proxies_, XENCrypto_);

  await contract.deployed();
  console.log(`XENProxy be deployed to ${contract.address}`);
}

const deploy_XENFactory = async () => {
  const XENFactory = await ethers.getContractFactory("XENFactory");
  // First check the contant XEN_PROXY = ?
  const contract = await upgrades.deployProxy(XENFactory)
  await contract.deployed();
  console.log(`XENFactory be deployed to ${contract.address}`);
}


const upgrade_XENFactory = async () => {
  const proxies = "0x9756B99BF162B8FD67092E39BEDE79F663260E44"
  const XENFactory = await ethers.getContractFactory("XENFactoryV2");
  const factory = await upgrades.upgradeProxy(proxies, XENFactory);
  console.log("XENFactory is upgrade to: ", factory.address);
}

async function main() {
  // await deploy_XENProxy()

  // await deploy_XENFactory()

  // upgrade XENFactory
  await upgrade_XENFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
