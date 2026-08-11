// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811} from './AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260811_AaveV3InkWhitelabel_UpdateKBTCCapRate/AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811.t.sol -vv
 */
contract AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 52962553);
    proposal = new AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_UpdateKBTCCapRate_20260811',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }
}
