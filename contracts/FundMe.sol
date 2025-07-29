// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConvertor.sol";

// get funds from users
// withdraw funds
// set a minimum funding value in USD


error notOwner();

// 596947
contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5 * 1e18;
    //  347 gas - constant
    // 2446 gas - non-constant

    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    //  439 gas - imutable
    // 2574 gas - non-imutable

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // allow users to send $
        // have a minimum of $5 sent
        // 1. how do we send ETH to this contract?
        // require( getConversionRate(msg.value) >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH
        require( (msg.value.getConversionRate()) >= MINIMUM_USD, "Didn't sent enough ETH"); // 1e18 = 1 ETH


        // What is a revert
        // undo any action that have been done

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }


    function withdraw() public onlyOwner{
        /* starting index, ending index, step amount */
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
            payable(funder).transfer(address(this).balance);
        }

        // reset array
        funders = new address[](0);
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) { revert notOwner(); }
        _;
    }

    // what happens if somebody sends this contract etH without calling the fund function

    receive () external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }



}