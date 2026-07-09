import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20260622_AaveV3InkWhitelabel_InkMarketIsolationUpdate/config.ts',
    force: true,
    pools: ['AaveV3InkWhitelabel'],
    title: 'Ink Market Isolation Update',
    shortName: 'InkMarketIsolationUpdate',
    date: '20260622',
    author: 'EvanInkFnd',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'USDC',
            params: {
              optimalUtilizationRate: '90',
              baseVariableBorrowRate: '6.5',
              variableRateSlope1: '0',
              variableRateSlope2: '0',
            },
          },
        ],
        COLLATERALS_UPDATE: [
          {asset: 'WETH', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
          {asset: 'kBTC', ltv: '85', liqThreshold: '87', liqBonus: '5', liqProtocolFee: ''},
          {asset: 'USDT', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
          {asset: 'weETH', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
          {asset: 'ezETH', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
          {asset: 'SolvBTC', ltv: '0', liqThreshold: '', liqBonus: '', liqProtocolFee: ''},
        ],
        BORROWS_UPDATE: [
          {
            asset: 'WETH',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
          {
            asset: 'kBTC',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
          {
            asset: 'USDT',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
          {
            asset: 'USDG',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
          {
            asset: 'GHO',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
          {
            asset: 'USDe',
            enabledToBorrow: 'DISABLED',
            flashloanable: 'KEEP_CURRENT',
            reserveFactor: '',
          },
        ],
        EMODES_UPDATES: [
          {
            eModeCategory: '2',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            label: '',
            isolated: 'ENABLED',
          },
          {
            eModeCategory: '3',
            ltv: '',
            liqThreshold: '',
            liqBonus: '',
            label: '',
            isolated: 'ENABLED',
          },
        ],
        EMODES_ASSETS: [
          {
            asset: 'sUSDe',
            eModeCategory: '2',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
            ltvzero: 'ENABLED',
          },
          {
            asset: 'USDe',
            eModeCategory: '2',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
            ltvzero: 'ENABLED',
          },
          {
            asset: 'USDe',
            eModeCategory: '3',
            collateral: 'KEEP_CURRENT',
            borrowable: 'KEEP_CURRENT',
            ltvzero: 'ENABLED',
          },
        ],
        EMODES_CREATION: [
          {
            ltv: '90',
            liqThreshold: '92',
            liqBonus: '4',
            label: 'sUSDe_USDe__USDT0_USDG',
            isolated: 'DISABLED',
            collateralAssets: ['sUSDe', 'USDe'],
            borrowableAssets: ['USDT', 'USDG'],
          },
        ],
      },
      cache: {blockNumber: 48658329},
    },
  },
};
