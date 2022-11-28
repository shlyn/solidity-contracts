import { ethers, upgrades } from "hardhat"

async function main() {
    const BoxV2 = await ethers.getContractFactory("BoxV2");
    const box = await upgrades.upgradeProxy("0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0", BoxV2);
    console.log("Box upgrade to: ", box.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
})