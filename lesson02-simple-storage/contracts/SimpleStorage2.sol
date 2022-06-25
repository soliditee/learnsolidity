// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage2 {
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
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People({favoriteNumber: _favoriteNumber, name: _name}));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}