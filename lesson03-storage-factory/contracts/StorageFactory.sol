// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // Creating a new contract like this cost 503022 gas for the first time, 483357 for the 2nd time
        SimpleStorage simpleStorage = new SimpleStorage();
        /// The new contract's address is stored in the array
        simpleStorageArray.push(simpleStorage);
    }

    function sfAddPerson(uint256 _simpleStorageIndex, string memory _name, uint256 _favoriteNumber) public {
        // When we retrieve the contract address from simpleStorageArray, it also comes with the ABI - Application Binary Interface
        simpleStorageArray[_simpleStorageIndex].addPerson(_name, _favoriteNumber);
    }

    function sfGetFavoriteNumber(uint256 _simpleStorageIndex, string memory name) view public returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].getFavoriteNumber(name);
    }
}