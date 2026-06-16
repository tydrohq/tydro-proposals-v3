// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520} from './AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260520_AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400/AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520.t.sol -vv
 */
contract AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 45824470);
    proposal = new AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_UpdateSolvBTCSupplyCapTo400_20260520',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }
}
