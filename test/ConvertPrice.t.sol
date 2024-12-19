// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import 'forge-std/Test.sol';
import { ConvertPrice } from './ConvertPrice.sol';

contract ConvertPriceTest is Test {
    ConvertPrice public convertPrice;
    function setUp() public {
        convertPrice = new ConvertPrice();
    }

    function test_convert_price_weth_usdc() public {
        // weth
        ConvertPrice.PriceData memory basePriceData = ConvertPrice.PriceData({
            priceInUSD: 99998376,
            priceInUSDDecimals: 8,
            tokenDecimals: 6
        });

        // usdc
        ConvertPrice.PriceData memory quotePriceData = ConvertPrice.PriceData({
            priceInUSD: 369522421300,
            priceInUSDDecimals: 8,
            tokenDecimals: 18
        });
        uint256 amount = 1e6;
        uint256 convertedPrice1 = convertPrice.convertPrice1(amount, basePriceData, quotePriceData);
        uint256 convertedPrice2 = convertPrice.convertPrice2(amount, basePriceData, quotePriceData);

        // proof both has same result
        assertEq(convertedPrice1, convertedPrice2);
    }

    function test_convert_price_ezeth_wsteth() public {
        // ezETH
        ConvertPrice.PriceData memory basePriceData = ConvertPrice.PriceData({
            priceInUSD: 1029287592037868000,
            priceInUSDDecimals: 18,
            tokenDecimals: 18
        });

        // wstETH
        ConvertPrice.PriceData memory quotePriceData = ConvertPrice.PriceData({
            priceInUSD: 1185990073530475800,
            priceInUSDDecimals: 18,
            tokenDecimals: 18
        });
        uint256 amount = 1e18;
        uint256 convertedPrice1 = convertPrice.convertPrice1(amount, basePriceData, quotePriceData);
        uint256 convertedPrice2 = convertPrice.convertPrice2(amount, basePriceData, quotePriceData);

        // proof both has same result
        assertEq(convertedPrice1, convertedPrice2);
    }
}
