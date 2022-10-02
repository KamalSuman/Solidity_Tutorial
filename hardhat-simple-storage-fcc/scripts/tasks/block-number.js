const { task } = require("hardhat/config")

task("block-number", "Print the bolck number").setAction(
    // hre can access lot of packages as hardhat can or it is synonym to hardhat
    async (taskArgs, hre) => {
        const blockNumber = hre.ethers.provider.getBlockNumber()
        console.log(`Current Block Number: ${blockNumber}`)
    }
)
module.exports = {}
