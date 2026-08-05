## Reserve changes

### Reserves altered

#### ezETH ([0x2416092f143378750bb29b79eD961ab195CcEea5](https://explorer.inkonchain.com/address/0x2416092f143378750bb29b79eD961ab195CcEea5))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 36,000 ezETH | 492 ezETH |


#### weETH ([0xA3D68b74bF0528fdD07263c60d6488749044914b](https://explorer.inkonchain.com/address/0xA3D68b74bF0528fdD07263c60d6488749044914b))

| description | value before | value after |
| --- | --- | --- |
| supplyCap | 6,000 weETH | 12,106 weETH |


## Event logs

#### 0x4f221e5c0B7103f7e3291E10097de6D9e3BfC02d (AaveV3InkWhitelabel.POOL_CONFIGURATOR)

| index | event |
| --- | --- |
| 0 | SupplyCapChanged(asset: 0x2416092f143378750bb29b79eD961ab195CcEea5 (symbol: ezETH), oldSupplyCap: 36000, newSupplyCap: 492) |
| 1 | SupplyCapChanged(asset: 0xA3D68b74bF0528fdD07263c60d6488749044914b (symbol: weETH), oldSupplyCap: 6000, newSupplyCap: 12106) |

#### 0x1dF462e2712496373A347f8ad10802a5E95f053D (AaveV3InkWhitelabel.ACL_ADMIN, GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR)

| index | event |
| --- | --- |
| 2 | ExecutedAction(target: 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f, value: 0, signature: execute(), data: 0x, executionTime: 1785876762, withDelegatecall: true, resultData: 0x) |

#### 0x1dE9CB9420Dd1f2cCeFFf9393E126b800D413b7A (GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER)

| index | event |
| --- | --- |
| 3 | PayloadExecuted(payloadId: 29) |

## Raw storage changes

### 0x1de9cb9420dd1f2ccefff9393e126b800d413b7a (GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER)

| slot | previous value | new value |
| --- | --- | --- |
| 0x4ba0d371c59a4c8176901cb7799ecdd8b41b974be3a1349b5d0a9ff9aaa230d9 | 0x006a725119000000000002000000000000000000000000000000000000000000 | 0x006a725119000000000003000000000000000000000000000000000000000000 |
| 0x4ba0d371c59a4c8176901cb7799ecdd8b41b974be3a1349b5d0a9ff9aaa230da | 0x000000000000000000093a800000000000006aa0759a00000000000000000000 | 0x000000000000000000093a800000000000006aa0759a0000000000006a72511a |

### 0x2816cf15f6d2a220e789aa011d5ee4eb6c47feba (AaveV3InkWhitelabel.POOL)

| slot | previous value | new value |
| --- | --- | --- |
| 0x52f7f1440ab20fcadde51b79423bd2f17e1c58bc3878efc43624e8de64ae798f | 0x100000000000000000000003e800000177000000000103e881122af8000a0005 | 0x100000000000000000000003e8000002f4a00000000103e881122af8000a0005 |
| 0x80d3b16018b60b749d2bc1c0b179418bf0067c8de4f67a7e0e09c0f02bf661b2 | 0x100000000000000000000003e8000008ca000000000103e881122af8000a0005 | 0x100000000000000000000003e80000001ec00000000103e881122af8000a0005 |


## Raw diff

```json
{
  "reserves": {
    "0x2416092f143378750bb29b79eD961ab195CcEea5": {
      "supplyCap": {
        "from": 36000,
        "to": 492
      }
    },
    "0xA3D68b74bF0528fdD07263c60d6488749044914b": {
      "supplyCap": {
        "from": 6000,
        "to": 12106
      }
    }
  }
}
```
