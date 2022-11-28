
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Call && DelegateCall", function () {
    async function deployContracts() {
        const [deployer1, deployer2, user1] = await ethers.getSigners();
        const BeCall = await ethers.getContractFactory("Logic");
        const beCall = await BeCall.connect(deployer1).deploy();

        const Caller = await ethers.getContractFactory("Proxy");
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

    describe("Proxy Call mode", function () {
        it("Proxy storage should not be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect((await caller.num()).toString()).to.equal("0");
        })
        it("Logic storage should be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect((await beCall.num()).toString()).to.equal("10");
        })
        it("Proxy msg.sender should be AddressZero", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect(await caller.sender()).to.equal(ethers.constants.AddressZero);
        })
        it("Logic msg.sender should be Caller Contract address", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).callSetNum(beCall.address, 10);
            await tx.wait();
            expect(await beCall.sender()).to.equal(caller.address);
        })
    });

    describe("Proxy DelegateCall mode", function () {
        it("Proxy storage should be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect((await caller.num()).toString()).to.equal("100");
        })

        it("Logic storage should not be changed", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect((await beCall.num()).toString()).to.equal("0");
        })

        it("Proxy msg.sender should be user address", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect(await caller.sender()).to.equal(user1.address);
        })

        it("Logic msg.sender should be AddressZero", async function () {
            const { beCall, caller, user1 } = await loadFixture(deployContracts);
            const tx = await caller.connect(user1).delegatecallSetNum(beCall.address, 100);
            await tx.wait();
            expect(await beCall.sender()).to.equal(ethers.constants.AddressZero);
        })
    });
});