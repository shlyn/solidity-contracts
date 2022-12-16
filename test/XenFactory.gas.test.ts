import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { ethers, upgrades } from "hardhat";

describe("XENFacroty-gas-report", function () {
  // non-upgradeable
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
    const XENProxy = await ethers.getContractFactory("XENProxyImplementation");
    const xenProxy = await XENProxy.deploy(xenCrypto.address, xenFactory.address);

    await xenFactory.connect(wallet0).setProxyImplementation(xenProxy.address);

    return { xenCrypto, xenFactory, xenProxy, wallet0, wallet1, wallet2, wallet3, wallet4, wallet5, wallet6, wallet7 }
  }

  async function deployUpgradeableTargetContract() {
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
    const XENFacroty = await ethers.getContractFactory("XENFactoryUpgradeable");
    const xenFactory = await upgrades.deployProxy(XENFacroty)

    // XENProxy
    const XENProxy = await ethers.getContractFactory("XENProxyImplementation");
    const xenProxy = await XENProxy.deploy(xenCrypto.address, xenFactory.address);

    await xenFactory.connect(wallet0).setProxyImplementation(xenProxy.address);

    return { xenCrypto, xenFactory, xenProxy, wallet0, wallet1, wallet2, wallet3, wallet4, wallet5, wallet6, wallet7 }
  }

  describe("XENFactory gas 消耗", function () {
    it("批量gas消耗", async function () {
      const { xenFactory, wallet1 } = await loadFixture(deployTargetContract);

      await xenFactory.connect(wallet1).batchMint(1, 2);
      // await xenFactory.connect(wallet1).batchMint(1, 100);
      // await xenFactory.connect(wallet1).batchMint(1, 100);

      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 1));
      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 100));
      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 200));


      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 1), 1);
      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 100), 1);
      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 200), 1);

      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 1), 1);
      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 100), 1);
      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 200), 1);
    });
  });

  describe("XENFactoryUpgradeable gas 消耗", function () {
    it("批量gas消耗", async function () {
      const { xenFactory, wallet1 } = await loadFixture(deployTargetContract);

      await xenFactory.connect(wallet1).batchMint(1, 2);
      // await xenFactory.connect(wallet1).batchMint(1, 100);
      // await xenFactory.connect(wallet1).batchMint(1, 100);

      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 1));
      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 100));
      // await xenFactory.connect(wallet1).batchClaim(Array.from({ length: 100 }, (v, k) => k + 200));


      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 1), 1);
      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 100), 1);
      // await xenFactory.connect(wallet1).batchReuseMint(Array.from({ length: 100 }, (v, k) => k + 200), 1);

      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 1), 1);
      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 100), 1);
      // await xenFactory.connect(wallet1).batchClaimAndMint(Array.from({ length: 100 }, (v, k) => k + 200), 1);
    });
  });
});
