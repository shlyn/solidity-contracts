
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Call && DelegateCall", function () {
    async function deployContracts() {
        const [deployer1, deployer2, user1] = await ethers.getSigners();
        const BeCall = await ethers.getContractFactory("BeCall");
        const beCall = await BeCall.connect(deployer1).deploy();

        const Caller = await ethers.getContractFactory("Caller");
        const caller = await Caller.connect(deployer2).deploy();

        return { beCall, caller, deployer1, deployer2, user1 };
    }

    describe("Deploy Props", function () {
        it("deployer address", async function () {
            const { beCall, caller, deployer1, deployer2 } = await loadFixture(deployContracts);
            expect(await beCall.owner()).to.equal(deployer1.address);
            expect(await caller.owner()).to.equal(deployer2.address);
        })
    })

    describe("Call mode", function () {
        it("Caller storage should not be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect((await caller.num()).toString()).to.equal("0");
        })
        it("BeCall storage should be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect((await beCall.num()).toString()).to.equal("10");
        })
        it("Caller sender should be AddressZero", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect(await caller.sender()).to.equal(ethers.constants.AddressZero);
        })
        it("BeCall sender should be Caller Contract address", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect(await beCall.sender()).to.equal(caller.address);
        })
    });

    describe("DelegateCall mode", function () {
        it("Caller storage should be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect((await caller.num()).toString()).to.equal("100");
        })

        it("BeCall storage should not be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect((await beCall.num()).toString()).to.equal("0");
        })

        it("Caller sender should be user address", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect(await caller.sender()).to.equal(user1.address);
        })

        it("BeCall sender should be AddressZero", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect(await beCall.sender()).to.equal(ethers.constants.AddressZero);
        })
    });
});