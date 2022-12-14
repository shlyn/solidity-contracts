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
  const contract = await upgrades.deployProxy(XENFactory)
  console.log(`XENFactory be deployed to ${contract.address}`);
  return contract.address;
}

const deploy_XENProxyImplementation = async (xenFactory: string, xenCrypto: string) => {
  const Contract = await ethers.getContractFactory("XENProxyImplementation");
  const contract = await Contract.deploy(xenFactory, xenCrypto);

  await contract.deployed();
  console.log(`XENProxy be deployed to ${contract.address}`);
  return contract.address;
}

const upgrade_XENFactory = async () => {
  const proxies = "0x1AF8fD96EF4E6B64f42e97e34D5751e96a39192d"
  const XENFactory = await ethers.getContractFactory("XENFactory");
  const factory = await upgrades.upgradeProxy(proxies, XENFactory);
  console.log("XENFactory is upgrade to: ", factory.address);
}

async function main() {
  // @One
  // const xenFactory = await deploy_XENFactory()

  // @Two
  // const xenCrypto = DeployedContractAddress.goerli.XENCrypto
  // await deploy_XENProxyImplementation(xenFactory, xenCrypto)

  // upgrade XENFactory
  // await upgrade_XENFactory()
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
