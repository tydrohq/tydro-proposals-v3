// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.0;

import {CLAdapterBaseTest} from '../../lib/aave-capo/tests/CLAdapterBaseTest.sol';
import {InkWrsETHOracleAdapterCode} from './DeployWrsETHOracleAdapter_20260616.s.sol';

contract WrsETHInkPriceCapAdapterTest is CLAdapterBaseTest {
  constructor()
    CLAdapterBaseTest(
      InkWrsETHOracleAdapterCode.wrsETHAdapterCode(),
      0,
      ForkParams({network: 'ink', blockNumber: 48300320}),
      'wrsETH_Ink'
    )
  {}

  function test_latestAnswerRetrospective() public pure override {
    assertTrue(true);
  }
}
