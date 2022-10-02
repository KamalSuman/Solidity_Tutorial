require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("@nomiclabs/hardhat-etherscan");
require("hardhat-gas-reporter");
require("solidity-coverage");
// require("./tasks/block-number");
const GOERLI_RPC_URL =
  "https://eth-goerli.alchemyapi.io/v2/nR5sE3bB8ZG7lsZA1aI7s9w1-PUxXW-g";
const PRIVATE_KEY =
  "ad16092a5adedb66497858432351798083966ef52f1179912cbe1dff847aef73";
const ETHERSCAN_API_KEY = "N12KU6WWWCMF644K4R34AZP6DQGE79C4YD";
const COINMARKET_API_KEY = process.env.COINMARKET_API_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.8",
  networks: {
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 5,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
  localhost: {
    url: "http://127.0.0.1:8545/",
    chainId: 31337,
  },
  gasReporter: {
    enabled: true,
    outputFile: "gas-repot.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: COINMARKET_API_KEY,
  },
};
