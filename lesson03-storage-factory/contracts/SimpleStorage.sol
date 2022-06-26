// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;
    //In this mapping, the returned value (uint256) is defaulted to 0 for any input (string)
    mapping(string => uint256) public nameToFavoriteNumber;

    // calldata = read-only temporary variables
    // memory = editable temporary variables
    // storage = editable permanent variables stored on the blockchain
    // virtual specifier will make the function overridable
    function addPerson(string memory _name, uint256 _favoriteNumber) public virtual{
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    function getFavoriteNumber(string memory _name) view public returns(uint256) {
        return nameToFavoriteNumber[_name];
    }
}