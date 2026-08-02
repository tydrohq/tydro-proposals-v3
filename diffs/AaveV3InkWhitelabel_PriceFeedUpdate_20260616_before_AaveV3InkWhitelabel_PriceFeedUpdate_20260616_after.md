## Reserve changes

### Reserves altered

#### wrsETH ([0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4](https://explorer.inkonchain.com/address/0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4))

| description | value before | value after |
| --- | --- | --- |
| oracle | [0x771a1668f973f2485D32580aB53F5C4934e81531](https://explorer.inkonchain.com/address/0x771a1668f973f2485D32580aB53F5C4934e81531) | [0x3F727547A7F6af12156573253D91e44aC64845a3](https://explorer.inkonchain.com/address/0x3F727547A7F6af12156573253D91e44aC64845a3) |
| oracleLatestAnswer | 1835.36566524 $ | 1828.01213164 $ |


## Event logs

#### 0x4758213271BFdC72224A7a8742dC865fC97756e1 (AaveV3InkWhitelabel.ORACLE)

| index | event |
| --- | --- |
| 0 | AssetSourceUpdated(asset: 0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4 (symbol: wrsETH), source: 0x3F727547A7F6af12156573253D91e44aC64845a3) |

#### 0x1dF462e2712496373A347f8ad10802a5E95f053D (AaveV3InkWhitelabel.ACL_ADMIN, GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR)

| index | event |
| --- | --- |
| 1 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1781817310, withDelegatecall: true, resultData: 0x) |

#### 0x1dE9CB9420Dd1f2cCeFFf9393E126b800D413b7A (GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 2 | PayloadExecuted(payloadId: 26) |

## Raw storage changes

### 0x1de9cb9420dd1f2ccefff9393e126b800d413b7a (GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x68fc0e82119a780903c8e97d959a36d433d1e401ad7b7a461ff2087e524d54a8 | 0x006a345fdd000000000002000000000000000000000000000000000000000000 | 0x006a345fdd000000000003000000000000000000000000000000000000000000 |
| 0x68fc0e82119a780903c8e97d959a36d433d1e401ad7b7a461ff2087e524d54a9 | 0x000000000000000000093a800000000000006a62845e00000000000000000000 | 0x000000000000000000093a800000000000006a62845e0000000000006a345fde |

### 0x4758213271bfdc72224a7a8742dc865fc97756e1 (AaveV3InkWhitelabel.ORACLE)

| slot | previous value | new value |
| --- | --- | --- |
| 0x1a6e1b289f404787ae22d2707a86057da6028484caa1a0b1e041a3ca4f19044e | 0x000000000000000000000000771a1668f973f2485d32580ab53f5c4934e81531 | 0x0000000000000000000000003f727547a7f6af12156573253d91e44ac64845a3 |


## Raw diff

```json
{
  "reserves": {
    "0x9f0a74A92287E323Eb95c1cd9eCdBEb0e397cAe4": {
      "oracle": {
        "from": "0x771a1668f973f2485D32580aB53F5C4934e81531",
        "to": "0x3F727547A7F6af12156573253D91e44aC64845a3"
      },
      "oracleLatestAnswer": {
        "from": "183536566524",
        "to": "182801213164"
      }
    }
  }
}
```
