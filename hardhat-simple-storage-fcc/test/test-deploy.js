// const ethers = require("hardhat");
const { expect, assert } = require("chai");
// it is a keyword that hardhat and mocha will recognize and take two parameter
describe("SimpleStorage", function () {
  // what command we want to run before each test i.e. it function
  let simpleStorageFactory, simpleStorage;
  beforeEach(async function () {
    simpleStorageFactory = await ethers.getContractFactory("SimpleStorage");
    simpleStorage = await simpleStorageFactory.deploy();
  });
  // what specific test we ant to do is symbolized by it function
  it("Should start with a favorite number 0", async function () {
    const currentValue = await simpleStorage.retrieve();
    const expectedValue = "0";
    // expect
    // assert
    assert.equal(currentValue.toString(), expectedValue);
  });
  it("Should update when we call storage", async function () {
    const expectedValue = "7";
    const transactionResponse = await simpleStorage.store(expectedValue);
    await transactionResponse.wait(1);
    const currentValue = await simpleStorage.retrieve();
    assert.equal(currentValue.toString(), expectedValue);
  });
});
