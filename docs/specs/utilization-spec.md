# Utilization Module – Technical Specification

## Overview
The Utilization Module defines how the protocol calculates the pool utilization value `U`.  
Utilization is one of the core risk indicators used by the protocol to determine profit-share ranges, capital efficiency, and system health.

All calculations use **1e18 precision (WAD)** to ensure accuracy and consistency with Solidity fixed-point math.

The invariant:
- `0 ≤ U ≤ 1e18`

---

## Inputs
The function receives two parameters:

- **totalLiquidity** — total available liquidity in the B-side pool  
- **allocatedLiquidity** — liquidity currently locked in active A-positions  

Both parameters are `uint256` values representing token units (e.g., USDC, 6 decimals).

---

## Core Formula
Utilization is computed as:
U = allocatedLiquidity * 1e18 / totalLiquidity

This gives:
- `0`      → 0%
- `0.5e18` → 50%
- `1e18`   → 100%

Multiplication MUST occur before division to avoid truncation errors.

---

## Edge Cases

### 1. Zero Liquidity
If `totalLiquidity == 0`:
- Utilization MUST return `0`
- Function MUST NOT revert

### 2. Over-Allocation
If `allocatedLiquidity > totalLiquidity`:
- Utilization MUST be capped at `1e18`

### 3. Precision Requirements
Must always return a value in `1e18` format.

---

## Constraints
- Function MUST be `pure`
- No storage access
- No external calls
- No unnecessary branching
- Output MUST satisfy: **0 ≤ U ≤ 1e18**

---

## Recommended Function Signature
```
solidity
function calculateUtilization(
    uint256 totalLiquidity,
    uint256 allocatedLiquidity
) internal pure returns (uint256 utilization);
```

## Examples
## Example 1 — 50% Utilization
totalLiquidity     = 1,000,000
allocatedLiquidity = 500,000
U = 0.5e18

## Example 2 — 90% Utilization
totalLiquidity     = 2,000,000
allocatedLiquidity = 1,800,000
U = 0.9e18

## Example 3 — Over-Allocated (Cap to 100%)
totalLiquidity     = 1,000,000
allocatedLiquidity = 1,200,000
U = 1e18

## Example 4 — Empty Pool
totalLiquidity     = 0
allocatedLiquidity = 0
U = 0

## Unit Test Requirements
Unit tests MUST include:
Zero liquidity → returns 0
Exact boundaries:
0.90e18
0.92e18
0.94e18
Over-allocation → must return 1e18
Random fuzz tests for:
no reverts when totalLiquidity == 0
output always between 0 and 1e18
Invariant validation: always 0 ≤ U ≤ 1e18

## Future Extensions
Time-smoothed utilization (EMA)
Weighted utilization for risk-adjusted capital
Differentiation between idle vs deployed liquidity
Public analytics view helpers


