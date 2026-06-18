// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.20;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {CLRatePriceCapAdapter} from 'aave-capo/contracts/CLRatePriceCapAdapter.sol';
import {IPriceCapAdapter} from 'aave-capo/interfaces/IPriceCapAdapter.sol';
import {InkScript} from 'solidity-utils/contracts/utils/ScriptUtils.sol';

library InkWrsETHOracleAdapterCode {
  address public constant ETH_PRICE_FEED = 0xcc2cBeC935a472B01c9d791c22056C2D6E7E86ef;
  address public constant WrsETH_ETH_PRICE_FEED = 0xA653031eDf7E9b3cad850BC2B996107F197046B1;

  uint104 public constant WrsETH_ETH_SNAPSHOT_RATIO = 1_073325399414165120;
  uint48 public constant WrsETH_ETH_SNAPSHOT_TIMESTAMP = 1780956747;
  uint16 public constant WrsETH_MAX_YEARLY_RATIO_GROWTH_PERCENT = 9_83;

  function wrsETHAdapterCode() internal pure returns (bytes memory) {
    return
      abi.encodePacked(
        type(CLRatePriceCapAdapter).creationCode,
        abi.encode(
          IPriceCapAdapter.CapAdapterParams({
            aclManager: AaveV3InkWhitelabel.ACL_MANAGER,
            baseAggregatorAddress: ETH_PRICE_FEED,
            ratioProviderAddress: WrsETH_ETH_PRICE_FEED,
            pairDescription: 'Capped wrsETH / ETH / USD',
            minimumSnapshotDelay: 7 days,
            priceCapParams: IPriceCapAdapter.PriceCapUpdateParams({
              snapshotRatio: WrsETH_ETH_SNAPSHOT_RATIO,
              snapshotTimestamp: WrsETH_ETH_SNAPSHOT_TIMESTAMP,
              maxYearlyRatioGrowthPercent: WrsETH_MAX_YEARLY_RATIO_GROWTH_PERCENT
            })
          })
        )
      );
  }
}

/**
 * @dev Deploy Ink
 * deploy-command: make deploy-ledger contract=src/20260616_AaveV3InkWhitelabel_DeployWrsETHOracleAdapter/DeployWrsETHOracleAdapter_20260616.s.sol:DeployInk chain=ink
 * verify-command: FOUNDRY_PROFILE=deploy npx catapulta-verify -b broadcast/DeployWrsETHOracleAdapter_20260616.s.sol/57073/run-latest.json
 */
contract DeployInk is InkScript {
  function run() external broadcast {
    GovV3Helpers.deployDeterministic(InkWrsETHOracleAdapterCode.wrsETHAdapterCode());
  }
}
