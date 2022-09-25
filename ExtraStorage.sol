// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage { // inheritance is occuring i.e. ExtraStorage is deriving its contract from SimpleStorage
    function store(uint _favoriteNumber) public override{  // in this way we are overriding the actual store function and i.e. with the help of override keyword
        favoriteNumber =_favoriteNumber + 5;
    }
}