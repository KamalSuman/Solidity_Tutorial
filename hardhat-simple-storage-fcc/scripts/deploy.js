// imports
const { ethers, run, network } = require("hardhat")

// async main
async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )
    console.log("Deploying contarct ...")
    const simpleStorage = await SimpleStorageFactory.deploy() // hardhat comes with default rpc and private key
    await simpleStorage.deployed()
    console.log(`Deployed Contract to: ${simpleStorage.address}`)
    // what happens when we deploy to our hardhat network
    // console.log(network.config)
    if (network.config.chainId === 4 /*&& process.env.ETHERSCAN_API_KEY*/) {
        console.log("Waiting for block txes...")
        await simpleStorage.deployTransaction.wait(6)
        await verify(simpleStorage.address, [])
    }
    const currentValue = await simpleStorage.retrieve()
    console.log(`Current Value is: ${currentValue}`)

    // Update the current value
    const transactionResponse = await simpleStorage.store(7)
    await transactionResponse.wait(1)
    const updatedValue = await simpleStorage.retrieve()
    console.log(`Updated Value is: ${updatedValue}`)
}

// automatically verify the contarct
async function verify(contrcatAddress, args) {
    console.log("Verifying contract...")
    try {
        await run("verify:verify", {
            address: contrcatAddress,
            constructorArguments: args,
        })
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Already Verified!")
        } else {
            console.log(e)
        }
    }
}
// main
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
