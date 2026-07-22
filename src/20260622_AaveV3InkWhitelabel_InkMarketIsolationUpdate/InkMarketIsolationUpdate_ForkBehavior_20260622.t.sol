// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console2} from 'forge-std/Test.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {IExecutor} from 'aave-address-book/governance-v3/IExecutor.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3InkWhitelabel_InkMarketIsolationUpdate_20260622} from './AaveV3InkWhitelabel_InkMarketIsolationUpdate_20260622.sol';

interface IDataProviderLike {
  function getReserveConfigurationData(
    address asset
  )
    external
    view
    returns (
      uint256 decimals,
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      uint256 reserveFactor,
      bool usageAsCollateralEnabled,
      bool borrowingEnabled,
      bool stableBorrowRateEnabled,
      bool isActive,
      bool isFrozen
    );

  function getReserveCaps(
    address asset
  ) external view returns (uint256 borrowCap, uint256 supplyCap);
}

interface IPoolDataLike {
  function getEModeCategoryLabel(uint8 id) external view returns (string memory);

  function getEModeCategoryCollateralConfig(
    uint8 id
  ) external view returns (uint16 ltv, uint16 liquidationThreshold, uint16 liquidationBonus);

  function getEModeCategoryCollateralBitmap(uint8 id) external view returns (uint128);

  function getEModeCategoryBorrowableBitmap(uint8 id) external view returns (uint128);

  function getEModeCategoryLtvzeroBitmap(uint8 id) external view returns (uint128);

  function getIsEModeCategoryIsolated(uint8 id) external view returns (bool);
}

contract InkMarketIsolationUpdate_ForkBehavior_20260622_Test is Test {
  IPool internal constant POOL = IPool(AaveV3InkWhitelabel.POOL);
  IPoolDataLike internal constant POOL_DATA = IPoolDataLike(address(AaveV3InkWhitelabel.POOL));
  IDataProviderLike internal constant DATA_PROVIDER =
    IDataProviderLike(0x96086C25d13943C80Ff9a19791a40Df6aFC08328);

  address internal constant EXECUTOR = 0x1dF462e2712496373A347f8ad10802a5E95f053D;
  address internal constant PAYLOADS_CONTROLLER = 0x1dE9CB9420Dd1f2cCeFFf9393E126b800D413b7A;

  address internal constant WETH = AaveV3InkWhitelabelAssets.WETH_UNDERLYING;
  address internal constant kBTC = AaveV3InkWhitelabelAssets.kBTC_UNDERLYING;
  address internal constant USDT0 = AaveV3InkWhitelabelAssets.USDT_UNDERLYING;
  address internal constant USDG = AaveV3InkWhitelabelAssets.USDG_UNDERLYING;
  address internal constant GHO = AaveV3InkWhitelabelAssets.GHO_UNDERLYING;
  address internal constant USDC = AaveV3InkWhitelabelAssets.USDC_UNDERLYING;
  address internal constant weETH = AaveV3InkWhitelabelAssets.weETH_UNDERLYING;
  address internal constant sUSDe = AaveV3InkWhitelabelAssets.sUSDe_UNDERLYING;
  address internal constant USDe = AaveV3InkWhitelabelAssets.USDe_UNDERLYING;
  address internal constant SolvBTC = AaveV3InkWhitelabelAssets.SolvBTC_UNDERLYING;
  address internal constant syrupUSDT = AaveV3InkWhitelabelAssets.syrupUSDT_UNDERLYING;

  address internal constant TOP_SUSDE_USDC_USER = 0xecd51A4842AB6eAf59c584Db3f48b7C075D58D96;
  address internal constant TOP_SUSDE_USDC_USDG_USER = 0xCa84e2a3f3a69BC117fe5e481000b5539fDd0e77;
  address internal constant MIXED_KBTC_USDT0_USDC_USER = 0xF7F47c7daa085214A533B53C325b3dE4934Dc5c4;
  address internal constant USDT0_USDC_USER = 0x9E0213A07e81F1b0b756DBF40E7D047Ca51C16e9;
  address internal constant WETH_USDT0_USER = 0x0777fB90c6188dA85AC7551130168E1B1D3B5aaf;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 48670574);
    AaveV3InkWhitelabel_InkMarketIsolationUpdate_20260622 payload = new AaveV3InkWhitelabel_InkMarketIsolationUpdate_20260622();

    vm.prank(PAYLOADS_CONTROLLER);
    IExecutor(EXECUTOR).executeTransaction(address(payload), 0, 'execute()', bytes(''), true);
  }

  function test_PostExecutionConfig() public view {
    _logReserve('WETH', WETH);
    _logReserve('kBTC', kBTC);
    _logReserve('USDT0', USDT0);
    _logReserve('USDC', USDC);
    _logReserve('USDG', USDG);
    _logReserve('GHO', GHO);
    _logReserve('weETH', weETH);
    _logReserve('USDe', USDe);
    _logReserve('SolvBTC', SolvBTC);
    _logReserve('syrupUSDT', syrupUSDT);

    _logEMode(1);
    _logEMode(2);
    _logEMode(3);
    _logEMode(4);
    _logEMode(5);
    _logEMode(6);
  }

  function test_RealWalletBorrowBehaviorAfterPayload() public {
    _logUser('top sUSDe + USDC debt', TOP_SUSDE_USDC_USER);
    _reportBorrow('top sUSDe user -> borrow USDC', TOP_SUSDE_USDC_USER, USDC, 1e6);
    _reportBorrow('top sUSDe user -> borrow USDT0', TOP_SUSDE_USDC_USER, USDT0, 1e6);
    _reportBorrow('top sUSDe user -> borrow USDG', TOP_SUSDE_USDC_USER, USDG, 1e6);

    _logUser('top sUSDe + USDC + USDG debt', TOP_SUSDE_USDC_USDG_USER);
    _reportBorrow('top sUSDe+USDG user -> borrow USDC', TOP_SUSDE_USDC_USDG_USER, USDC, 1e6);
    _reportBorrow('top sUSDe+USDG user -> borrow USDT0', TOP_SUSDE_USDC_USDG_USER, USDT0, 1e6);

    _logUser('mixed kBTC + USDT0 collateral + USDC debt', MIXED_KBTC_USDT0_USDC_USER);
    _reportBorrow('mixed kBTC user -> borrow USDC', MIXED_KBTC_USDT0_USDC_USER, USDC, 1e6);
    _reportBorrow('mixed kBTC user -> borrow USDT0', MIXED_KBTC_USDT0_USDC_USER, USDT0, 1e6);
    _reportBorrow('mixed kBTC user -> borrow USDG', MIXED_KBTC_USDT0_USDC_USER, USDG, 1e6);

    _logUser('USDT0 collateral + USDC debt', USDT0_USDC_USER);
    _reportBorrow('USDT0 collateral user -> borrow USDC', USDT0_USDC_USER, USDC, 1e6);
    _reportBorrow('USDT0 collateral user -> borrow USDT0', USDT0_USDC_USER, USDT0, 1e6);

    _logUser('WETH collateral + USDT0 debt', WETH_USDT0_USER);
    _reportBorrow('WETH collateral user -> borrow USDT0', WETH_USDT0_USER, USDT0, 1e6);
  }

  function test_SyntheticBorrowBehaviorAfterPayload() public {
    address ethenaUser = makeAddr('synthetic-ethena');
    _supplyAndSetEmode(ethenaUser, sUSDe, 10_000 ether, 2);
    _logUser('synthetic sUSDe-only eMode 2', ethenaUser);
    _reportBorrow('synthetic sUSDe eMode2 -> borrow USDC', ethenaUser, USDC, 1e6);
    _reportBorrow('synthetic sUSDe eMode2 -> borrow USDT0', ethenaUser, USDT0, 1e6);
    _reportBorrow('synthetic sUSDe eMode2 -> borrow USDG', ethenaUser, USDG, 1e6);

    address newStableUser = makeAddr('synthetic-new-stable-emode');
    _supplyAndSetEmode(newStableUser, sUSDe, 10_000 ether, 5);
    _logUser('synthetic sUSDe-only new eMode 5', newStableUser);
    _reportBorrow('synthetic sUSDe eMode5 -> borrow USDC', newStableUser, USDC, 1e6);
    _reportBorrow('synthetic sUSDe eMode5 -> borrow USDT0', newStableUser, USDT0, 1e6);
    _reportBorrow('synthetic sUSDe eMode5 -> borrow USDG', newStableUser, USDG, 1e6);

    address kbtcUser = makeAddr('synthetic-kbtc-in-legacy-emode');
    _supplyAndSetEmode(kbtcUser, kBTC, 1e8, 2);
    _logUser('synthetic kBTC-only selected into eMode 2', kbtcUser);
    _reportBorrow('synthetic kBTC eMode2 -> borrow USDC', kbtcUser, USDC, 1e6);
    _reportBorrow('synthetic kBTC eMode2 -> borrow USDT0', kbtcUser, USDT0, 1e6);
    _reportBorrow('synthetic kBTC eMode2 -> borrow USDG', kbtcUser, USDG, 1e6);

    address usdt0User = makeAddr('synthetic-usdt0-in-legacy-emode');
    _supplyAndSetEmode(usdt0User, USDT0, 10_000e6, 2);
    _logUser('synthetic USDT0-only selected into eMode 2', usdt0User);
    _reportBorrow('synthetic USDT0 eMode2 -> borrow USDC', usdt0User, USDC, 1e6);
    _reportBorrow('synthetic USDT0 eMode2 -> borrow USDT0', usdt0User, USDT0, 1e6);

    address mainKbtcUser = makeAddr('synthetic-kbtc-main-market');
    _supply(mainKbtcUser, kBTC, 1e8);
    _logUser('synthetic kBTC main market', mainKbtcUser);
    _reportBorrow('synthetic kBTC main -> borrow USDC', mainKbtcUser, USDC, 1e6);
    _reportBorrow('synthetic kBTC main -> borrow USDT0', mainKbtcUser, USDT0, 1e6);
    _reportBorrow('synthetic kBTC main -> borrow GHO', mainKbtcUser, GHO, 1 ether);

    address lrtUser = makeAddr('synthetic-lrt');
    _supplyAndSetEmode(lrtUser, weETH, 10 ether, 1);
    _logUser('synthetic weETH eMode 1', lrtUser);
    _reportBorrow('synthetic weETH eMode1 -> borrow WETH', lrtUser, WETH, 0.1 ether);
    _reportBorrow('synthetic weETH eMode1 -> borrow USDC', lrtUser, USDC, 1e6);

    address syrupUser = makeAddr('synthetic-syrup');
    _supplyAndSetEmode(syrupUser, syrupUSDT, 10_000e6, 4);
    _logUser('synthetic syrupUSDT eMode 4', syrupUser);
    _reportBorrow('synthetic syrup eMode4 -> borrow USDT0', syrupUser, USDT0, 1e6);
    _reportBorrow('synthetic syrup eMode4 -> borrow USDC', syrupUser, USDC, 1e6);

    address solvBtcUser = makeAddr('synthetic-solvbtc');
    _supplyAndSetEmode(solvBtcUser, SolvBTC, 1 ether, 6);
    _logUser('synthetic SolvBTC eMode 6', solvBtcUser);
    _reportBorrow('synthetic SolvBTC eMode6 -> borrow GHO', solvBtcUser, GHO, 1 ether);
    _reportBorrow('synthetic SolvBTC eMode6 -> borrow USDC', solvBtcUser, USDC, 1e6);
    _reportBorrow('synthetic SolvBTC eMode6 -> borrow USDT0', solvBtcUser, USDT0, 1e6);
  }

  function test_KbtcCannotBorrowThroughIsolatedEModes() public {
    _assertKbtcRouteBlocked(1, WETH, 0.01 ether);
    _assertKbtcRouteBlocked(4, USDT0, 1e6);
    _assertKbtcRouteBlocked(5, USDT0, 1e6);
    _assertKbtcRouteBlocked(5, USDG, 1e6);
    _assertKbtcRouteBlocked(6, GHO, 1 ether);
  }

  function test_AllActiveEModesAreIsolated() public view {
    for (uint8 category = 1; category <= 6; category++) {
      assertTrue(POOL_DATA.getIsEModeCategoryIsolated(category), 'eMode is not isolated');
    }
  }

  function test_IntendedIsolatedEModeRoutesRemainOpen() public {
    address lrtUser = makeAddr('asserted-lrt');
    _supplyAndSetEmode(lrtUser, weETH, 10 ether, 1);
    assertTrue(_probeBorrow(lrtUser, WETH, 0.1 ether), 'LRT eMode cannot borrow WETH');

    address syrupUser = makeAddr('asserted-syrup');
    _supplyAndSetEmode(syrupUser, syrupUSDT, 10_000e6, 4);
    assertTrue(_probeBorrow(syrupUser, USDT0, 1e6), 'syrup eMode cannot borrow USDT0');

    address stableUser = makeAddr('asserted-stable');
    _supplyAndSetEmode(stableUser, sUSDe, 10_000 ether, 5);
    assertTrue(_probeBorrow(stableUser, USDT0, 1e6), 'stable eMode cannot borrow USDT0');
    assertTrue(_probeBorrow(stableUser, USDG, 1e6), 'stable eMode cannot borrow USDG');

    address solvBtcUser = makeAddr('asserted-solvbtc');
    _supplyAndSetEmode(solvBtcUser, SolvBTC, 1 ether, 6);
    assertTrue(_probeBorrow(solvBtcUser, GHO, 1 ether), 'SolvBTC eMode cannot borrow GHO');
    assertFalse(_probeBorrow(solvBtcUser, USDC, 1e6), 'SolvBTC eMode can borrow USDC');
    assertFalse(_probeBorrow(solvBtcUser, USDT0, 1e6), 'SolvBTC eMode can borrow USDT0');
  }

  function test_SolvBTCGhoEModeConfiguration() public view {
    (uint16 ltv, uint16 liquidationThreshold, uint16 liquidationBonus) = POOL_DATA
      .getEModeCategoryCollateralConfig(6);

    assertEq(ltv, 70_00, 'unexpected SolvBTC eMode LTV');
    assertEq(liquidationThreshold, 72_00, 'unexpected SolvBTC eMode LT');
    assertEq(liquidationBonus, 107_50, 'unexpected SolvBTC eMode LB');
    assertEq(POOL_DATA.getEModeCategoryCollateralBitmap(6), 2048, 'unexpected collateral');
    assertEq(POOL_DATA.getEModeCategoryBorrowableBitmap(6), 16, 'unexpected borrowable');
    assertEq(POOL_DATA.getEModeCategoryLtvzeroBitmap(6), 0, 'unexpected ltvzero');
    assertTrue(POOL_DATA.getIsEModeCategoryIsolated(6), 'SolvBTC eMode is not isolated');
    assertEq(POOL_DATA.getEModeCategoryLabel(6), 'SolvBTC__GHO', 'unexpected label');
  }

  function test_CurrentLegacyEModeDistributionAfterPayload() public {
    address[] memory users = _currentLegacyUsers();
    uint256 usdcSuccess;
    uint256 usdt0Success;
    uint256 usdgSuccess;
    uint256 positiveAvailableBorrows;

    for (uint256 i = 0; i < users.length; i++) {
      address user = users[i];
      (, , uint256 availableBorrowsBase, , , ) = POOL.getUserAccountData(user);
      if (availableBorrowsBase > 0) positiveAvailableBorrows++;

      bool canBorrowUsdc = _probeBorrow(user, USDC, 1e6);
      bool canBorrowUsdt0 = _probeBorrow(user, USDT0, 1e6);
      bool canBorrowUsdg = _probeBorrow(user, USDG, 1e6);

      if (canBorrowUsdc) {
        usdcSuccess++;
        console2.log('DISTRIBUTION can borrow USDC', user);
      }
      if (canBorrowUsdt0) {
        usdt0Success++;
        console2.log('DISTRIBUTION can borrow USDT0', user);
      }
      if (canBorrowUsdg) {
        usdgSuccess++;
        console2.log('DISTRIBUTION can borrow USDG', user);
      }
    }

    console2.log('DISTRIBUTION users', users.length);
    console2.log('DISTRIBUTION positive availableBorrowsBase', positiveAvailableBorrows);
    console2.log('DISTRIBUTION can borrow USDC count', usdcSuccess);
    console2.log('DISTRIBUTION can borrow USDT0 count', usdt0Success);
    console2.log('DISTRIBUTION can borrow USDG count', usdgSuccess);
  }

  function _supplyAndSetEmode(address user, address asset, uint256 amount, uint8 eMode) internal {
    vm.prank(user);
    POOL.setUserEMode(eMode);
    _supply(user, asset, amount);
    vm.prank(user);
    (bool collateralSet, ) = address(POOL).call(
      abi.encodeWithSignature('setUserUseReserveAsCollateral(address,bool)', asset, true)
    );
    collateralSet;
  }

  function _assertKbtcRouteBlocked(uint8 eMode, address debtAsset, uint256 amount) internal {
    address user = makeAddr(
      string.concat('blocked-kbtc-', vm.toString(eMode), '-', vm.toString(debtAsset))
    );
    _supplyAndSetEmode(user, kBTC, 1e8, eMode);

    (, , uint256 availableBorrowsBase, , uint256 ltv, ) = POOL.getUserAccountData(user);
    assertEq(POOL.getUserEMode(user), eMode, 'unexpected eMode');
    assertEq(ltv, 0, 'kBTC retained borrowing power');
    assertEq(availableBorrowsBase, 0, 'kBTC has available borrow capacity');
    assertFalse(_probeBorrow(user, debtAsset, amount), 'kBTC cross-eMode borrow succeeded');
  }

  function _supply(address user, address asset, uint256 amount) internal {
    deal(asset, user, amount, true);
    vm.startPrank(user);
    IERC20(asset).approve(address(POOL), amount);
    POOL.supply(asset, amount, user, 0);
    vm.stopPrank();
  }

  function _reportBorrow(
    string memory label,
    address user,
    address asset,
    uint256 amount
  ) internal {
    bool ok = _tryBorrow(user, asset, amount);
    console2.log(label, ok ? 'SUCCESS' : 'REVERT');
  }

  function _tryBorrow(address user, address asset, uint256 amount) internal returns (bool) {
    vm.prank(user);
    (bool ok, ) = address(POOL).call(
      abi.encodeWithSelector(IPool.borrow.selector, asset, amount, 2, 0, user)
    );
    return ok;
  }

  function _probeBorrow(address user, address asset, uint256 amount) internal returns (bool) {
    uint256 snapshot = vm.snapshotState();
    bool ok = _tryBorrow(user, asset, amount);
    vm.revertToState(snapshot);
    return ok;
  }

  function _currentLegacyUsers() internal pure returns (address[] memory users) {
    users = new address[](57);
    users[0] = 0xecd51A4842AB6eAf59c584Db3f48b7C075D58D96;
    users[1] = 0xCa84e2a3f3a69BC117fe5e481000b5539fDd0e77;
    users[2] = 0x9E0213A07e81F1b0b756DBF40E7D047Ca51C16e9;
    users[3] = 0x94cD1D5c591DEDd39d2bbFc24EbeCBA05830fa36;
    users[4] = 0x354B10783337A446703A4B02F9e12B6791a89f54;
    users[5] = 0xF7F47c7daa085214A533B53C325b3dE4934Dc5c4;
    users[6] = 0x25D35ADD44Eea6592B96217C5263db9bE9837632;
    users[7] = 0xC6ece6faA7F349B801Ce8A6b22167F072147B7a6;
    users[8] = 0xF7079eFE4dd117249C818016D9B9eF0d817A122D;
    users[9] = 0x599529Eb2DC9699D81A2d147CEE247e7cAdA00D4;
    users[10] = 0x03235dd1BdCA853e711CBd86E835F0D704D9047C;
    users[11] = 0xD5f1F24a16A780716FC0e0839E8616f49AA3c4FC;
    users[12] = 0x920EefBCf1f5756109952E6Ff6dA1Cab950C64d7;
    users[13] = 0x38e481367E0c50f4166AD2A1C9fde0E3c662CFBa;
    users[14] = 0x2787BE615f13f740F36A3219eE5c009C3EBc9B90;
    users[15] = 0xd5E39C6564043F5d64AC14c530677bC4D6480251;
    users[16] = 0x387fe86D6AbfdC8C2C3a01feF3E6F8019CbFfDF2;
    users[17] = 0x5dA68351bD082aBDA73E42Ac981dB51d9364fe69;
    users[18] = 0xE27bA52311290dE54E9c8B0B1735D428Bf8E77e3;
    users[19] = 0xe22aC10e5A69A34aB7d3CfcA19FfDdb086a709Ec;
    users[20] = 0xF382743F7E246f93144Ef7DF5C40de408bfA9268;
    users[21] = 0xc468315a2df54f9c076bD5Cfe5002BA211F74CA6;
    users[22] = 0x6554874f13F5e953aEe06FF38B501CF233e8f438;
    users[23] = 0xCea458EF8d2Cb23A47443cCe3eeb1f20492669C5;
    users[24] = 0x99D6d7304cFE177123212eDd73FBaFA99314C301;
    users[25] = 0xEfFCcEc05CE3F78a3167F904ACe12a6dCBF588F1;
    users[26] = 0x0777fB90c6188dA85AC7551130168E1B1D3B5aaf;
    users[27] = 0x44f4DA18D1e9609E13B3d10cD091e3836C69Bff2;
    users[28] = 0xbeb72B567A4fE8F7419Ce7a42Fc0CfAd315f2D22;
    users[29] = 0x5AE279A6C89a5029dC09E675bC849aE97984757d;
    users[30] = 0x2F3d470277Ef636bdE128736A8A501188A8C54f3;
    users[31] = 0xD09e22250590eb71D758102E2658D947987D3750;
    users[32] = 0x6e4fBdD9354A2060736F2d0b68A864dAdf6C3475;
    users[33] = 0x51453CEef7c761d438d04Cf327885565b90fFd48;
    users[34] = 0x52A803A26D8caAbb9e702A9810267e2c4d6EEf48;
    users[35] = 0x98307799792618B0bC60Dda8200882da7A278C8A;
    users[36] = 0x50f461F471e7dCe973e27f0e319eBe868135D764;
    users[37] = 0xc1a3c560850166F41edF48988068383bfFBeAdF5;
    users[38] = 0xBF8f4F69d212569bCFcD102C8D6BdAd17B57C9a0;
    users[39] = 0xCcd95A8638306f7Bf6840280fa82354278AA8b5F;
    users[40] = 0xa08F903c2B6d46473D5c188B198560B19fe5D667;
    users[41] = 0x4a71111E877986894a0Cf60e06B5773B50f1b3fb;
    users[42] = 0x1202aC23922cB44C7dDea49cf3A72cA46E876A03;
    users[43] = 0x30fA559f0bB67de18580516C2ca67369e9624F88;
    users[44] = 0x00845073402E19E26F68f4Fc868DF4f8eC2deECd;
    users[45] = 0x2dF81c01A54384d289396d217c632E8147a3C28a;
    users[46] = 0x2e9fc681840e8B8332445Cb0049bA26B615F18A4;
    users[47] = 0xeEDee7818281a08e387212397804feA6907C529a;
    users[48] = 0xF3978Fb08C51415Ec81b72C3160B264cec5A16F9;
    users[49] = 0xEfa911756a790E0f9E806189dFA97E3fC96fB096;
    users[50] = 0xEd2017fc8fB843CBf6d5d2bF18b304EaBB8cBd69;
    users[51] = 0xD4Da14DaBe00acFe3e22B0e93A76F97e7f0aaC77;
    users[52] = 0x9C84548e084576e7f51A543133F6F17fD1aC3F27;
    users[53] = 0x3e756bE298ea913947525b0B0bABcD0B09E3E708;
    users[54] = 0xbCCA0722b3E3D9d45E956BDCd258C9a19b9dCddB;
    users[55] = 0xE723c40788E8b547d103be0D202437F8922B5594;
    users[56] = 0x18Ec5566Ad26E2aC609822395d6D9e98a39C90ef;
  }

  function _logUser(string memory label, address user) internal view {
    (
      uint256 totalCollateralBase,
      uint256 totalDebtBase,
      uint256 availableBorrowsBase,
      uint256 currentLiquidationThreshold,
      uint256 ltv,
      uint256 healthFactor
    ) = POOL.getUserAccountData(user);
    uint256 eMode = POOL.getUserEMode(user);
    console2.log('USER', label, user);
    console2.log('  eMode', eMode);
    console2.log('  totalCollateralBase', totalCollateralBase);
    console2.log('  totalDebtBase', totalDebtBase);
    console2.log('  availableBorrowsBase', availableBorrowsBase);
    console2.log('  currentLiquidationThreshold', currentLiquidationThreshold);
    console2.log('  ltv', ltv);
    console2.log('  healthFactor', healthFactor);
  }

  function _logReserve(string memory symbol, address asset) internal view {
    (
      ,
      uint256 ltv,
      uint256 liquidationThreshold,
      uint256 liquidationBonus,
      ,
      bool usageAsCollateralEnabled,
      bool borrowingEnabled,
      ,
      bool isActive,
      bool isFrozen
    ) = DATA_PROVIDER.getReserveConfigurationData(asset);
    (uint256 borrowCap, uint256 supplyCap) = DATA_PROVIDER.getReserveCaps(asset);
    console2.log('RESERVE', symbol);
    console2.log('  ltv', ltv);
    console2.log('  liquidationThreshold', liquidationThreshold);
    console2.log('  liquidationBonus', liquidationBonus);
    console2.log('  collateralEnabled', usageAsCollateralEnabled);
    console2.log('  borrowingEnabled', borrowingEnabled);
    console2.log('  active', isActive);
    console2.log('  frozen', isFrozen);
    console2.log('  borrowCap', borrowCap);
    console2.log('  supplyCap', supplyCap);
  }

  function _logEMode(uint8 id) internal view {
    (bool ok, bytes memory returndata) = address(POOL_DATA).staticcall(
      abi.encodeWithSelector(IPoolDataLike.getEModeCategoryCollateralConfig.selector, id)
    );
    if (!ok) {
      console2.log('EMODE', id);
      console2.log('  unavailable/reverted');
      return;
    }
    (uint16 ltv, uint16 liquidationThreshold, uint16 liquidationBonus) = abi.decode(
      returndata,
      (uint16, uint16, uint16)
    );
    uint128 collateralBitmap = POOL_DATA.getEModeCategoryCollateralBitmap(id);
    uint128 borrowableBitmap = POOL_DATA.getEModeCategoryBorrowableBitmap(id);
    uint128 ltvzeroBitmap = POOL_DATA.getEModeCategoryLtvzeroBitmap(id);
    string memory label = POOL_DATA.getEModeCategoryLabel(id);
    console2.log('EMODE', id);
    console2.log('  ltv', ltv);
    console2.log('  liquidationThreshold', liquidationThreshold);
    console2.log('  liquidationBonus', liquidationBonus);
    console2.log('  collateralBitmap', collateralBitmap);
    console2.log('  borrowableBitmap', borrowableBitmap);
    console2.log('  ltvzeroBitmap', ltvzeroBitmap);
    console2.log('  label', label);
  }
}
