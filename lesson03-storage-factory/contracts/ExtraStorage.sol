// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract ExtraStorage is SimpleStorage {
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public override{
        _favoriteNumber += 5;
        // super keyword will return the immediate parent
        super.addPerson(_name, _favoriteNumber);
        // Using the parent's name is more explicit
        // SimpleStorage.addPerson(_name, _favoriteNumber);        
    }
}