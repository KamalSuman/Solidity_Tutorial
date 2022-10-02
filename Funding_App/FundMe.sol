// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// This is one of the most important contract because it is depicting the Applications of chain-link i.e. Decentralized oracles 
// to get the off-chain (real world ) data into on-chain i.e. (blockchain) to create some hybrid smart contact which produces some realistic projects.

// This contract is using data feeds of chain link and creating a transaction app which is having debiting and crediting facilities i.e. what 
// what our conventional banks do. 

// In this we are specifically using chain-link to get conversion rate of USD ( off-chain data) to ETH ( on-chain data) 

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

import "./PriceConvertor.sol";

contract FundMe{  // fund me contract 
    using PriceConvertor for uint256;
    uint256 public minimumUsd=50;

    address[] public funders; /// to keep the address of funders who are donating to our contract
    mapping(address=>uint256) public addressToAmountFunded;

    function fund() public payable{   // making the function payable by adding this keyword payable now it can get value of value button in the ide
        
        require(msg.value.getConversionRate() >= minimumUsd*1e18  , "Didn't send enough"); // if minimumUSD<50 then it will revert the changes changes i.e. if we have done any computation before require function then revert will undo the change
        funders.push(msg.sender); // just like msg.value gives the amount of money msg.sender gives the address of sender
        addressToAmountFunded[msg.sender]=msg.value;
    }
    address public owner;
    // making constructor to get owner address because it will give you the deployer address when it is deployed.
    constructor(){
        owner=msg.sender; // i.e. your wallet address
    }

    // creating a withdraw function to reset the amount to 0 which is sent by funder

    function withdraw()  public onlyOwner { // here 

        for(uint256 funderIndex=0;funderIndex<funders.length;funderIndex++){
            addressToAmountFunded[funders[funderIndex]]=0;
        }
    // Reseting the funders array 
    funders = new address[](0); // 0 elements to start with i.e. totally reseting the array
    // There are 3 methods to withdraw money 
    // transfer --> In this method maximum gas available is 2300 and throws an error if it fails 
    // syntax payable(msg.sender).transfer(address(this).balance) ?? here "this" represents the contract address
    // send:    --> In this method maximum gas available is 2300 but returns a bool if it fails
    // syntax bool sendSuccess=payable(msg.sender).send(address(this).balance)
    // require(sendSuccess, "Transaction Failed")
    // call:    --> In this method you can use any amount of gas and it returns 2 variables i.e. a bool which gives the success of transaction and byte data objects. It is one the most used method
    (bool sendSuccess,)=payable(msg.sender).call{value:address(this).balance}("");
    require(sendSuccess, "Transaction Failed");
    
    }
    // modifier is basically a piece a code which is basically used to modify function i.e. in this modifier first the require statement will run and check whether it is the real owner or not  
    modifier onlyOwner{
        require(msg.sender==owner,"You are not an owner");
        _; // it represents the whole code
    }

    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \ 
    //         yes  no
    //         /     \
    //    receive()?  fallback() 
    //     /   \ 
    //   yes   no
    //  /        \
    //receive()  fallback()

    // Basically fallback and receive functions are used to import mopney i.e. ETH to contract if you don't have any fund function but you won't be able to store the address of funder
    // difference between them is receive function only used when no data is passed in call data otherwise fallback triggers
    // In our case we have called function inside this recieve and fallback to store the data of funders also.pwd\p 
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }


}