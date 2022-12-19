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

const deploy_XENFactory = async () => {
  const XENFactory = await ethers.getContractFactory("XENFactory");
  const contract = await XENFactory.deploy()
  console.log(`XENFactory be deployed to ${contract.address}`);
  return contract.address;
}

const deploy_XENFactoryUpgradeable = async () => {
  const XENFactory = await ethers.getContractFactory("XENFactoryUpgradeable");
  const contract = await upgrades.deployProxy(XENFactory)
  console.log(`XENFactory be deployed to ${contract.address}`);
  return contract.address;
}

const upgrade_XENFactory = async () => {
  const proxies = "0xDfec2d9c03d713f25C88494404510389B17C1BCC"
  const XENFactory = await ethers.getContractFactory("XENFactoryUpgradeable");
  // validate
  // await upgrades.validateUpgrade(proxies, XENFactory);
  // validate and deploy
  await upgrades.validateImplementation(XENFactory);

  const factory = await upgrades.upgradeProxy(proxies, XENFactory);
  console.log("XENFactory is upgrade to: ", factory.address);

}

const deploy_XENProxyImplementation = async (xenFactory: string, xenCrypto: string) => {
  const Contract = await ethers.getContractFactory("XENProxyImplementation");
  const contract = await Contract.deploy(xenFactory, xenCrypto);

  await contract.deployed();
  console.log(`XENProxy be deployed to ${contract.address}`);
  return contract.address;
}

async function main() {
  // @non-upgradeable
  // const xenFactory = await deploy_XENFactory()

  // @upgradeable
  // const xenFactory = await deploy_XENFactoryUpgradeable()

  // @Two
  // const xenCrypto = DeployedContractAddress.goerli.XENCrypto
  // await deploy_XENProxyImplementation(xenCrypto, xenFactory)

  // upgrade XENFactory
  await upgrade_XENFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
