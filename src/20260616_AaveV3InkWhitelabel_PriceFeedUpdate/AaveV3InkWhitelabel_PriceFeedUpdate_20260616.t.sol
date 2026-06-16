// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_PriceFeedUpdate_20260616} from './AaveV3InkWhitelabel_PriceFeedUpdate_20260616.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_PriceFeedUpdate_20260616
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260616_AaveV3InkWhitelabel_PriceFeedUpdate/AaveV3InkWhitelabel_PriceFeedUpdate_20260616.t.sol -vv
 */
contract AaveV3InkWhitelabel_PriceFeedUpdate_20260616_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_PriceFeedUpdate_20260616 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 48131599);
    proposal = new AaveV3InkWhitelabel_PriceFeedUpdate_20260616();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_PriceFeedUpdate_20260616',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }
}
