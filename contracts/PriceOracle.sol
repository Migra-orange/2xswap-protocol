// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

/// @title PriceOracle (MVP owner-settable)
/// @notice Simple owner-settable oracle returning price in USDC with 1e18 precision
contract PriceOracle is Ownable {
    mapping(address => uint256) public prices; // asset => price in USDC (1e18)

    event PriceUpdated(address indexed asset, uint256 price);

    /// @notice Set price for an asset (owner)
    function setPrice(address asset, uint256 price) external onlyOwner {
        require(price > 0, "price>0");
        prices[asset] = price;
        emit PriceUpdated(asset, price);
    }

    /// @notice Get price for asset in USDC (1e18)
    function getPrice(address asset) external view returns (uint256) {
        uint256 p = prices[asset];
        require(p > 0, "price not set");
        return p;
    }
}
