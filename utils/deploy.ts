import * as hre from "hardhat"

interface DeployConfig {
    [index: string]: string;
}

type ContractName = "AAA"

export const ethers = hre.ethers

export const network = hre.hardhatArguments.network

export async function DeployContract(contractName: ContractName, libraries?: DeployConfig) {
    const Contract = await ethers.getContractFactory(contractName, { libraries })
    const contract = await Contract.deploy()
    await contract.deployed()

    console.log(`${contractName} be deployed to ${contract.address}`);
    return contract.address
}
