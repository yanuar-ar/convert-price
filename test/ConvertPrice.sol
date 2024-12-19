// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { console } from 'forge-std/console.sol';
import { Math } from '@openzeppelin/contracts/utils/math/Math.sol';

contract ConvertPrice {
    using Math for uint256;

    struct PriceData {
        uint256 priceInUSD;
        uint256 priceInUSDDecimals;
        uint256 tokenDecimals;
    }
    function convertPrice1(
        uint256 amount,
        PriceData memory basePriceData,
        PriceData memory quotePriceData
    ) external view virtual returns (uint256) {
        // 1. Convert amount to USD (maintaining precision)
        uint256 amountInUSD = amount.mulDiv(
            basePriceData.priceInUSD,
            10 ** basePriceData.tokenDecimals,
            Math.Rounding.Floor
        );

        // 2. Convert USD amount to quote token
        // Need to adjust for decimal differences between USD price decimals
        if (basePriceData.priceInUSDDecimals > quotePriceData.priceInUSDDecimals) {
            amountInUSD = amountInUSD.mulDiv(
                10 ** (basePriceData.priceInUSDDecimals - quotePriceData.priceInUSDDecimals),
                1,
                Math.Rounding.Floor
            );
        } else if (quotePriceData.priceInUSDDecimals > basePriceData.priceInUSDDecimals) {
            amountInUSD = amountInUSD.mulDiv(
                1,
                10 ** (quotePriceData.priceInUSDDecimals - basePriceData.priceInUSDDecimals),
                Math.Rounding.Floor
            );
        }
        // 3. Convert USD value to quote token
        return amountInUSD.mulDiv(10 ** quotePriceData.tokenDecimals, quotePriceData.priceInUSD, Math.Rounding.Floor);
    }

    function convertPrice2(
        uint256 amount,
        PriceData memory basePriceData,
        PriceData memory quotePriceData
    ) external view virtual returns (uint256) {
        // 1. Convert amount to USD (maintaining precision)
        uint256 amountInUSD = amount.mulDiv(
            basePriceData.priceInUSD,
            10 ** basePriceData.tokenDecimals,
            Math.Rounding.Floor
        );

        // 2. Convert USD amount to quote token
        // Need to adjust for decimal differences between USD price decimals
        if (basePriceData.priceInUSDDecimals > quotePriceData.priceInUSDDecimals) {
            amountInUSD = amountInUSD.mulDiv(
                1,
                10 ** (basePriceData.priceInUSDDecimals - quotePriceData.priceInUSDDecimals),
                Math.Rounding.Floor
            );
        } else if (quotePriceData.priceInUSDDecimals > basePriceData.priceInUSDDecimals) {
            amountInUSD = amountInUSD.mulDiv(
                10 ** (quotePriceData.priceInUSDDecimals - basePriceData.priceInUSDDecimals),
                1,
                Math.Rounding.Floor
            );
        }

        // 3. Convert USD value to quote token
        return amountInUSD.mulDiv(10 ** quotePriceData.tokenDecimals, quotePriceData.priceInUSD, Math.Rounding.Floor);
    }
}
