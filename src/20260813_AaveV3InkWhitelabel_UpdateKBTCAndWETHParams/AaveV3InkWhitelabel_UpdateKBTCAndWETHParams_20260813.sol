// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Update kBTC and WETH params
 * @author Martin
 */
contract AaveV3InkWhitelabel_UpdateKBTCAndWETHParams_20260813 is AaveV3PayloadInkWhitelabel {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](2);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3InkWhitelabelAssets.WETH_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: 2_00,
        variableRateSlope1: 1_00,
        variableRateSlope2: 1_00
      })
    });
    rateStrategies[1] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3InkWhitelabelAssets.kBTC_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: 8_00,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
  function capsUpdates() public pure override returns (IAaveV3ConfigEngine.CapsUpdate[] memory) {
    IAaveV3ConfigEngine.CapsUpdate[] memory capsUpdate = new IAaveV3ConfigEngine.CapsUpdate[](2);

    capsUpdate[0] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.WETH_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 8_200
    });
    capsUpdate[1] = IAaveV3ConfigEngine.CapsUpdate({
      asset: AaveV3InkWhitelabelAssets.kBTC_UNDERLYING,
      supplyCap: EngineFlags.KEEP_CURRENT,
      borrowCap: 5
    });

    return capsUpdate;
  }
}
