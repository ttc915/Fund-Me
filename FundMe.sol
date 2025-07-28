// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


// get funds from users
// withdraw funds
// set a minimum funding value in USD

contract FundMe {

    uint256 public minimumUsd = 5 * 1e18;

    function fund() public payable {
        // allow users to send $
        // have a minimum of $5 sent
        // 1. how do we send ETH to this contract?
        require( getConversionRate(msg.value) >= minimumUsd, "Didn't sent enough ETH"); // 1e18 = 1 ETH

        // What is a revert
        // undi any action that have been done
    }


    // function withdraw() public {}

    function getPrice() public view returns (uint256) {
        // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // abi
        address priceFeedAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (, int256 price,,,) = priceFeed.latestRoundData();
        // prie of ETH in USD
        // 3800.000000000
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmmount) public view returns (uint256) {
        uint256 price = getPrice();
        uint256 priceInUsd = (price * ethAmmount) / 1e18;
        return priceInUsd;

    }

    function getVersion() public view returns (uint256) {
        address priceFeedAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        return priceFeed.version();
    }

}