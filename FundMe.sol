// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConvertor.sol";

// get funds from users
// withdraw funds
// set a minimum funding value in USD

contract FundMe {

    using PriceConverter for uint256;

    uint256 public minimumUsd = 5 * 1e18;

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    function fund() public payable {
        // allow users to send $
        // have a minimum of $5 sent
        // 1. how do we send ETH to this contract?
        // require( getConversionRate(msg.value) >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH
        require( (msg.value.getConversionRate()) >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH


        // What is a revert
        // undo any action that have been done

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }


    // function withdraw() public {}



}