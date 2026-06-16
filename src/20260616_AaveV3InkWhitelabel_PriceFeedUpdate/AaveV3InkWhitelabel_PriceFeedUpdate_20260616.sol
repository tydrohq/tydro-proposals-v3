// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import 'forge-std/console.sol';

/**
 * @title priceFeedUpdate
 * @author rohan
 */
contract AaveV3InkWhitelabel_PriceFeedUpdate_20260616 is AaveV3PayloadInkWhitelabel {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    console.log('wrsETH_UNDERLYING', AaveV3InkWhitelabelAssets.wrsETH_UNDERLYING);
    console.log('updating price feed!!');

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3InkWhitelabelAssets.wrsETH_UNDERLYING,
      priceFeed: AaveV3InkWhitelabelAssets.wrsETH_ORACLE // placeholder oracle
    });

    return priceFeedUpdates;
  }
}
