// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";  // Basically this copies the whole code of SimpleStorage contract into here 
contract StorageFactory{
    SimpleStorage[] public simpleStorageArray;  // Cautious this can lead you declaration error i.e.
    // what you have "SimpleStorage" as a datatype should match with the name of SimpleStorage contract.
    
    function createSimpleStorageContract() public{ // making a public function which is calling our SimpleStorage contract
        SimpleStorage simpleStorage=new SimpleStorage(); // this is the call for SimpleStorage function which gives the address of contract 
        simpleStorageArray.push(simpleStorage); // The address is stored in the array by push function
    }
    function sfStore(uint _simpleStorageIndex,uint _simpleStorageValue) public{ // making a public function which is setting the value of favorite number in the simplestorage contract
        SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex]; // first getting the address of the contract with the help of index
        simpleStorage.store(_simpleStorageValue); // setting the favorite value using the store function of simple storage
    }
    function sfGet(uint _simpleStorageIndex) public view returns(uint256){ //// making a public function which is getting the value of favorite number in the simplestorage contract
        SimpleStorage simpleStorage=simpleStorageArray[_simpleStorageIndex]; // first getting the address of the contract with the help of index
        return simpleStorage.retrieve(); // setting the favorite value using the store function of simple storage
    }
}