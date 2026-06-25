// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';

/**
 * @title aaveAdapter
 * @author rohan
 */
contract AaveV3InkWhitelabel_AaveAdapter_20260624 is IProposalGenericExecutor {
  address public constant NEW_FLASH_BORROWER = address(0); // placeholder, change once we add the adapter

  function execute() external {
    AaveV3InkWhitelabel.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
