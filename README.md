# 2xSwap Protocol

A decentralized co-investment protocol with **dynamic profit sharing**, **unified B-side liquidity pool**, and **liquidation-free leverage** for crypto and tokenized real-world assets (RWAs).

2xSwap replaces interest-based lending with a **partnership model** where two parties —  
**A (Initiator)** and **B (Capital Provider)** — co-invest into real on-chain assets.  
Profits are shared according to a **utilization-based ratio**, and positions never face forced liquidation.

## Key Features

- **Liquidation-Free Leverage** – positions stay open until voluntary close or maturity  
- **Dynamic Profit Sharing** – A/B split adjusts automatically per pool utilization  
- **Unified B-Side Liquidity Pool** (ERC-4626)  
- **Real Asset Exposure** – swaps executed on-chain via DEX aggregators  
- **RWA-Ready Architecture** – supports tokenized stocks, bonds, real estate  
- **Idle Liquidity Optimization** – unused funds auto-deployed into MakerDAO DSR  
- **Fully Non-Custodial & MEV-Protected** order flow  

## Architecture Overview

The protocol consists of four main smart contract modules:

### 1. LiquidityPool (ERC-4626)

- Accepts USDC deposits from B participants  
- Issues 2xLP tokens  
- Tracks free and allocated liquidity  
- FIFO withdrawal queue when utilization reaches 100%  
- Auto-deploy idle liquidity into MakerDAO DSR  

### 2. Co-Investment Strategy

Handles A-side positions:

- Creates Position NFTs  
- Calculates dynamic profit-share via utilization  
- Executes swaps (buy/sell)  
- Settlement logic (profit waterfall, downside ordering)  

### 3. IntentSwapRouter

- Stateless intent verification  
- Routing to CoWSwap / UniswapX  
- MEV-protected execution via private relays  

### 4. OracleGuard

- TWAP deviation checks  
- Staleness protection  
- Validation only at entry/exit  

## Profit-Share Mechanism

Profit share is determined at the moment a position is opened, based on **pool utilization U**.

**Threshold Model v2:**

| Utilization | Mode       | A : B Split |
|-------------|------------|-------------|
| 0–90%       | Normal     | 80 : 20     |
| 90–92%      | Pre-Stress | 70 : 30     |
| 92–94%      | Overload   | 60 : 40     |
| >94%        | Critical   | 50 : 50     |

---

## Repository Structure

2xswap-protocol/
├── contracts/
├── test/
├── scripts/
└── docs/
  └── specs/
   ├── profit-share-spec.md
   ├── settlement-spec.md
   ├── position-nft-spec.md
   └── utilization-spec.md


## Development
Install dependencies:
npm install
Run tests:
npx hardhat test
Run gas report:
REPORT_GAS=true npx hardhat test

## Contributing

We welcome contributions via Pull Requests.

1. Fork the repository  
2. Create a feature branch  
3. Commit with clear messages  
4. Submit a PR  
5. All PRs must pass tests, linting, and code review  

Contribution guidelines and PR template will be added soon.

## Security

- Independent audits required before mainnet  
- Multisig-controlled governance  
- Timelocked upgrades  
- Community bug bounties  
- No custodial components  

## License

MIT License.

## Vision

**To replace debt with partnership — and speculation with shared ownership.**

2xSwap introduces a new financial primitive:  
interest-free, liquidation-free, profit-sharing co-investment for crypto and the $10T on-chain RWA economy.

