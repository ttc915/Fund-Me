// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
        function getPrice() internal view returns (uint256) {
        // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // abi
        address priceFeedAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (, int256 price,,,) = priceFeed.latestRoundData();
        // prie of ETH in USD
        // 3800.000000000
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmmount) internal view returns (uint256) {
        uint256 price = getPrice();
        uint256 priceInUsd = (price * ethAmmount) / 1e18;
        return priceInUsd;

    }

    function getVersion() internal view returns (uint256) {
        address priceFeedAddress = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        return priceFeed.version();
    }
}