import { HardhatUserConfig } from "hardhat/config";
import "@openzeppelin/hardhat-upgrades";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config()

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    dashboard: {
      url: "http://localhost:24012/rpc",
      timeout: 56000,
      allowUnlimitedContractSize: true
    },
    hardhat: {
      // forking: {
      //   url: `https://eth-mainnet.alchemyapi.io/v2/${process.env.API_KEY_ALCHEMY}`,
      //   blockNumber: 21577481
      // },
      // blockGasLimit: DEFAULT_BLOCK_GAS_LIMIT,
      // gas: DEFAULT_BLOCK_GAS_LIMIT,
      gasPrice: 8_000_000_000,
      allowUnlimitedContractSize: true
    },
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.API_KEY_INFURA}`,
      gasPrice: 8_000_000_000,
      chainId: 5,
      throwOnTransactionFailures: true,
      throwOnCallFailures: true,
      from: "0xF3b60C1d342B964E5aBa270741AA56e2C22b47BC",
      accounts: [process.env.DEPLOYER_PRIVEKEY],
      allowUnlimitedContractSize: true,
      timeout: 56000
    },
    bsc_testnet: {
      url: "https://data-seed-prebsc-1-s1.binance.org:8545",
      chainId: 97
    },
    pulsechain_testnet: {
      url: "https://rpc.v2b.testnet.pulsechain.com",
      chainId: 941,
    },
    ethw_testnet: {
      url: "https://iceberg.ethereumpow.org/",
      chainId: 10_002
    },
    mumbai: {
      url: "https://rpc-mumbai.maticvigil.com/v1/53a113316e0a9e20bcf02b13dd504ac33aeea3ba",
      chainId: 80001
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.17",
        settings: {
          optimizer: {
            runs: 200,
            enabled: true
          }
        }
      },
      {
        version: "0.8.16",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          }
        }
      },
      {
        version: "0.8.10",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          },
        }
      },
      {
        version: "0.8.9"
      }
    ]
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 40000
  },
  etherscan: {
    apiKey: process.env.API_KEY_ETHERESCAN
  }
};

export default config;
