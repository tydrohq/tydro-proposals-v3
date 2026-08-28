import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    configFile: 'src/20260828_AaveV3InkWhitelabel_RaiseReserveFactors/config.ts',
    force: true,
    pools: ['AaveV3InkWhitelabel'],
    title: 'Raise Reserve Factors',
    shortName: 'RaiseReserveFactors',
    date: '20260828',
    author: 'EvanInkFnd',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        BORROWS_UPDATE: [
          {
            asset: 'USDC',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
          },
          {
            asset: 'USDT',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '17.5',
          },
          {
            asset: 'USDG',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
          },
          {
            asset: 'GHO',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '15',
          },
          {
            asset: 'WETH',
            enabledToBorrow: 'KEEP_CURRENT',
            flashloanable: 'KEEP_CURRENT',
            borrowableInIsolation: 'KEEP_CURRENT',
            withSiloedBorrowing: 'KEEP_CURRENT',
            reserveFactor: '17.5',
          },
        ],
      },
      cache: {blockNumber: 54385286},
    },
  },
};
