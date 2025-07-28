// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


// get funds from users
// withdraw funds
// set a minimum funding value in USD

contract FundMe {

    uint256 public minimumUsd = 5;

    function fund() public payable {
        // allow users to send $
        // have a minimum of $5 sent
        // 1. how do we send ETH to this contract?
        require( msg.value >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH

        // What is a revert
        // undi any action that have been done
    }


    // function withdraw() public {}

    function getPrice() public  {
        // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // abi

    }

    function getConversionRate() public  {

    }


}