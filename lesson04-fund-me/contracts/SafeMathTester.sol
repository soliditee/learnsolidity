// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        // Before 0.8, reaching max int + 1 will overflow and reset the value back to 0
        // After 0.8, reaching max int + 1 will return VM error
        bigNumber += 1;

        // Running code with unchecked keyword will remove the overflow check
        // unchecked {bigNumber += 1;}
    }
}