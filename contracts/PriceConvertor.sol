// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;


// 1. Limit self-triage to 15/20 minutes
// 2. Don't be afraid to ask AI, but don't skip learning
// "Hallucinations" 
// 3. Use the forums!!!
// 4. Google the exact error
// 5. Post in stack exchange or peeranhe


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
        // address priceFeedAddress = 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF;
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        return priceFeed.version();
    }
}