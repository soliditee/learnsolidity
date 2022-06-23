// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage {
    // uint will be initialized as 0
    uint256 public favoriteNumber;

    function store(uint256 _favoriteNumber) public {
        // _favoriteNumber = _favoriteNumber + 1; // Doing this would cost 26826 gas
        favoriteNumber = _favoriteNumber;
        // favoriteNumber = favoriteNumber + 1; // Doing this would cost 27032 gas and result in the same thing as above

        // Note: the first transaction to set a new value (other than the default init value) would cost as much as 43724 gas
        // Subsequent transactions would cost 26636 gas (when the value is changed)
        // If we call this function but provide the same value as the previous transaction, it's cheaper (23836 gas) because there's no change in the state tree
    }
}