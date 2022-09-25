// SPDX-License-Identifier: MIT   
// Above line depicts the license which you need to include otherwise it will give warning

//-----------> Types of declarations that you are using which compiler

//  pragma solidity 0.8.7  // pragma tells the current solidity version
//  pragma solidity ^0.8.7; // this tells that we are okay with 8.7 and above version of solidity
pragma solidity >=0.8.7 <0.9.0;   // tells that any version between the range is okay to work

// Below is the declaration of contract i.e. how we declare contract

contract SimpleStorage{
    uint public favoritenumber;     // public keyword make it public and it acts as function which shows the value of favoritenumber 

    function store(uint _favoritenumber) public{    // we are declaring function which is setting the value of favoritenumber
        favoritenumber=_favoritenumber;             // we EVM execute this smart contract this store function will appear in which you can give the value
        // retrieve();                              // all this function which causes the modification need to deployed again and you need to give gas fee.
    }
    
    mapping(string => uint256) public nameToage; // mapping ia a data structure in which a key points to a value . Here nameTopage becomes a dictionary that holds the key-value pair.
    // mapping is introduced to get the value if we know a particular key then we can easily get the value by mapping. Otherwise we would have iterated the whole array to get the value. 

    // view, pure are the keywords in which you dont need to spend any gas i.e. they dont cause any modification hence does not ask for transaction
    function retrieve() public view returns(uint){
        return favoritenumber;
    }      // example of view functions

    struct person{      // if we want more than one functionality we made struct to store the properties.
        uint age;
        string name;
    }
    person[] public persons;  // array of struct 
    function  addPerson(string memory _name, uint _age) public {
         // memory keyword is actually adding the data in the memory
        persons.push(person(_age,_name)); // pushing values int the array   
        // another method first create a peoples then add in the array
        // person memory newperson=person({age:_age,name:_name});
        // persons.push(newperson);


        // In solidity we need to specify the memory for array , structure, mapping and string is considered as array that's why memory is assigned to it
        // calldata is temporary variables that cannot be modidfied, memory is a temporary variables that can be modidified and storage is a permanent variable that cannot be modified
        
        nameToage[_name]=_age;
    }
}