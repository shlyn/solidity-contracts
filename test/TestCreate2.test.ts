import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("TestCreate2", function(){
    async function deployContracts() {
        const [address1, address2, address3] = await ethers.getSigners();
        const Template = await ethers.getContractFactory("Template");
        // const template = await Template.connect(address1).deploy();
        const template = await Template.deploy(10);

        const TestCreate2 = await ethers.getContractFactory("TestCreate2");
        const testCreate2 = await TestCreate2.deploy(template.address);
        return { template, testCreate2, address1, address2, address3};
    }

    describe("Template storage", function() {
        it("a", async function() {
            const { template, address1 } = await deployContracts();
            expect((await template.a()).toString()).to.equal("0");
            await template.connect(address1).setA(100);
            expect((await template.a()).toString()).to.equal("100");
        })
        it("setA", async function() {
            const { template, address1 } = await deployContracts();
            await template.connect(address1).setA(100);
            expect((await template.a()).toString()).to.equal("100");
        })
        it("b", async function() {
            const { template } = await deployContracts();
            expect((await template.b()).toString()).to.equal("10");
            expect(await template.c()).to.equal(template.address);
        })
        it("c", async function() {
            const { template } = await deployContracts();
            expect(await template.c()).to.equal(template.address);
        })
    })

    describe("Check TestCreate2 storage", function() {
        it("res", async function() {
            const { template, testCreate2 } = await deployContracts();
            expect((await testCreate2.res1()).toString()).to.equal("0");
            expect((await testCreate2.res2()).toString()).to.equal("0");
            expect((await testCreate2.template()).toString()).to.equal(template.address);
        })
    })

    describe("TestCreate2 createMinimalProxy", function() {
        it("createMinimalProxy", async function() {
            const { testCreate2 } = await deployContracts();
            for (let i = 1; i < 2; i++) {
                await testCreate2.createMinimalProxy(i);
            }
        })
        it("createMinimalProxy2", async function() {
            const { testCreate2 } = await deployContracts();
            for (let i = 1; i < 2; i++) {
                await testCreate2.createMinimalProxy2(i);
            }
        })
    })
})