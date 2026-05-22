// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabel, AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';

/**
 * @title Restore WETH LTV levels
 * @author EvanInkFnd
 */
contract AaveV3InkWhitelabel_RestoreWETHLTVLevels_20260518 is IProposalGenericExecutor {
  function execute() external {
    AaveV3InkWhitelabel.POOL_CONFIGURATOR.setReserveLtvzero({
      asset: AaveV3InkWhitelabelAssets.WETH_UNDERLYING,
      ltvzero: false
    });
  }
}
