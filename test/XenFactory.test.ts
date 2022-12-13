import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";
import { getCreate2ContractAddress } from "../utils";

describe("XENFacroty", function () {
  async function deployTargetContract() {
    const [wallet0, wallet1, wallet2, wallet3, wallet4, wallet5, wallet6, wallet7] = await ethers.getSigners();
    // Math
    const Math = await ethers.getContractFactory("./contracts/XEN-crypto/Math.sol:Math");
    const math = await Math.deploy();
    // XEN-crypto
    const XENCrypto = await ethers.getContractFactory("XENCryptoTest", {
      libraries: {
        Math: math.address
      }
    });
    const xenCrypto = await XENCrypto.deploy();

    // XENFactory
    const XENFacroty = await ethers.getContractFactory("XENFactory");
    const xenFactory = await XENFacroty.deploy();
    // XENProxy
    const XENProxy = await ethers.getContractFactory("XENProxyV1");
    const xenProxy = await XENProxy.deploy(xenCrypto.address, xenFactory.address);

    await xenFactory.connect(wallet0).initialize(xenProxy.address);

    return { xenCrypto, xenFactory, xenProxy, wallet0, wallet1, wallet2, wallet3, wallet4, wallet5, wallet6, wallet7 }
  }

  describe("铸造功能", function () {
    it("批量铸造gas消耗", async function () {
      const { xenFactory, wallet0 } = await loadFixture(deployTargetContract);
      await xenFactory.connect(wallet0).batchMint(1, 100);
    });

    it("单个铸造", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet1, wallet2 } = await loadFixture(deployTargetContract);

      const res = await xenFactory.connect(wallet1).batchMint(1, 1);
      await res.wait();

      const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet1.address, 1);
      const mintInfo = await xenCrypto.userMints(proxy);
      expect(mintInfo.rank.toNumber()).to.equal(1);

      const res2 = await xenFactory.connect(wallet2).batchMint(1, 100);
      await res2.wait();

      const proxy2 = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet2.address, 1);
      const mintInfo2 = await xenCrypto.userMints(proxy2);
      expect(mintInfo2.rank.toNumber()).to.equal(2);

      const proxy23 = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet2.address, 100);
      const mintInfo23 = await xenCrypto.userMints(proxy23);
      expect(mintInfo23.rank.toNumber()).to.equal(101);
    });

    it("批量铸造", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet1 } = await loadFixture(deployTargetContract);

      const count = 100;
      const res = await xenFactory.connect(wallet1).batchMint(1, count);
      await res.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet1.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.equal(i);
      }
    });

    it("除了XENFactory其他的合约不能使用代理铸造合约", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet2, wallet3 } = await loadFixture(deployTargetContract);

      const res1 = await xenFactory.connect(wallet2).batchMint(1, 1);
      await res1.wait();
      const proxy1 = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet2.address, 1);
      const mintInfo1 = await xenCrypto.userMints(proxy1);
      expect(mintInfo1.rank.toNumber()).to.equal(1);

      const XENFacroty2 = await ethers.getContractFactory("XENFactory");
      const xenFactory2 = await XENFacroty2.connect(wallet2).deploy();
      await xenFactory2.connect(wallet2).initialize(xenProxy.address);

      const res2 = await xenFactory2.connect(wallet2).batchMint(1, 1);
      await res2.wait();
      const proxy2 = getCreate2ContractAddress(xenFactory2.address, xenProxy.address, wallet2.address, 1);
      const mintInfo2 = await xenCrypto.userMints(proxy2);
      expect(mintInfo2.rank.toNumber()).to.equal(0);

      const res3 = await xenFactory2.connect(wallet3).batchMint(1, 1);
      await res3.wait();
      const proxy3 = getCreate2ContractAddress(xenFactory2.address, xenProxy.address, wallet3.address, 1);
      const mintInfo3 = await xenCrypto.userMints(proxy3);
      expect(mintInfo3.rank.toNumber()).to.equal(0);
    });
  });

  describe("提取功能", function () {
    it("批量提取铸造的XEN", async function () {
      const { xenCrypto, xenFactory, wallet3 } = await loadFixture(deployTargetContract);

      const res = await xenFactory.connect(wallet3).batchMint(1, 100);
      await res.wait();

      const res2 = await xenFactory.connect(wallet3).batchClaim(Array.from({ length: 100 }, (v, k) => k + 1));
      await res2.wait();

      const balance = await xenCrypto.balanceOf(wallet3.address);
      expect(balance).to.gt(ethers.BigNumber.from(10000))
    });
    it("计算出来的奖励 == 提取的XEN奖励", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet1, wallet2, wallet3 } = await loadFixture(deployTargetContract);

      const res1 = await xenFactory.connect(wallet1).batchMint(1, 1);
      await res1.wait();

      let count = 100;
      const res2 = await xenFactory.connect(wallet2).batchMint(1, count);
      await res2.wait();

      const res3 = await xenFactory.connect(wallet3).batchMint(1, 1);
      await res3.wait();

      const getRewards = async (deployer: string, template: string, user: string) => {
        let rewards = 0;
        const globalRank = (await xenCrypto.globalRank()).toNumber();
        const counts = await xenFactory.userMintIndex(wallet2.address);
        for (let i = 1; i < counts.toNumber() + 1; i++) {
          let proxy = getCreate2ContractAddress(deployer, template, user, i);
          const mintInfo2 = await xenCrypto.userMints(proxy);
          const itemBase = {
            rank: mintInfo2.rank.toNumber(),
            term: mintInfo2.term.toNumber(),
            amplifier: mintInfo2.amplifier.toNumber(),
            eaaRate: mintInfo2.eaaRate.toNumber()
          }
          const rankDiffLog = Number(Math.log2(globalRank - itemBase.rank).toFixed(4));
          const penalty = 1;
          rewards += rankDiffLog * itemBase.term * itemBase.amplifier * (1 + itemBase.eaaRate / 1000) * penalty;
        }
        return rewards;
      }
      const totalRewards = await getRewards(xenFactory.address, xenProxy.address, wallet2.address);

      // claim
      const res22 = await xenFactory.connect(wallet2).batchClaim(Array.from({ length: count }, (v, k) => k + 1));
      await res22.wait();
      const balance2 = await xenCrypto.balanceOf(wallet2.address);

      expect(parseInt(totalRewards + '') - parseInt(ethers.utils.formatEther(balance2))).to.lt(50);
    });
  });

  describe("复用功能", function () {
    it("批量复用", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet4 } = await loadFixture(deployTargetContract);

      let count = 100;
      const res = await xenFactory.connect(wallet4).batchMint(1, count);
      await res.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet4.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.gt(0);
      }

      const res2 = await xenFactory.connect(wallet4).batchClaim(Array.from({ length: 100 }, (v, k) => k + 1));
      await res2.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet4.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.equal(0);
      }

      const res3 = await xenFactory.connect(wallet4).multiReuseMint(Array.from({ length: 100 }, (v, k) => k + 1), 1);
      await res3.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet4.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.gt(0);
      }
    });

    it("批量提取 + 复用", async function () {
      const { xenCrypto, xenFactory, xenProxy, wallet4 } = await loadFixture(deployTargetContract);

      let count = 100;
      const res = await xenFactory.connect(wallet4).batchMint(1, count);
      await res.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet4.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.gt(0);
      }

      const res2 = await xenFactory.connect(wallet4).batchClaimAndReuse(Array.from({ length: count }, (v, k) => k + 1), 1);
      await res2.wait();

      for (let i = 1; i < count + 1; i++) {
        const proxy = getCreate2ContractAddress(xenFactory.address, xenProxy.address, wallet4.address, i);
        const mintInfo = await xenCrypto.userMints(proxy);
        expect(mintInfo.rank.toNumber()).to.gt(0);
      }
    });
  });
});
