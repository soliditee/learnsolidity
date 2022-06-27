// Receive funds from any user
// Withdraw funds (contract owner only)
// Set a minimum funding value

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {

    address public owner;

    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        owner = msg.sender;
    }

    // payable = this function can send and receive funds
    function fund() public payable {
        // If this "require" condition is not satisfied, the transaction is reverted
        // "Revert" means to undo any action before and send the remaining gas back
        // 1e18 = 1 * 10^18 Wei = 1 Ether
        // require(getConversionRate(msg.value) >= minimumUsd, "Not enough Ether");
        require(msg.value.getConversionRate() > minimumUsd, "Please send more than 50 USD worth of Ether");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        // Reset the mapping that tracks funders and their amount
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funderAddress = funders[funderIndex];
            addressToAmountFunded[funderAddress] = 0;
        }
        
        // Reset an array
        // (0) means the new array will have 0 elements to begin with
        funders = new address[](0);

        // 3 ways to withdraw the fund:
        // 1) Transfer
        // Ether can only be sent to payable addresses
        // Transfer will return error and auto-revert if fail
        // payable(msg.sender).transfer(address(this).balance);

        // 2) Send
        // Send will return bool and will not auto-revert
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // 3) Call
        // This is the most powerful, we can call any function without knowing the ABI.
        // We use "call" to create a new transaction to the sender's address and send the "value"
        // instead of making an actual function call
        // (bool callSuccess, bytes memory dataReturned)
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner.");
        // This means execute the rest of the code
        _;
    }
}