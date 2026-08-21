import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update kBTC and WETH params',
    shortName: 'UpdateKBTCAndWETHParams',
    date: '20260813',
    author: 'Martin',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        RATE_UPDATE_V3: [
          {
            asset: 'WETH',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '2',
              variableRateSlope1: '1',
              variableRateSlope2: '1',
            },
          },
          {
            asset: 'kBTC',
            params: {
              optimalUtilizationRate: '',
              baseVariableBorrowRate: '8',
              variableRateSlope1: '',
              variableRateSlope2: '',
            },
          },
        ],
        CAPS_UPDATE: [
          {asset: 'WETH', supplyCap: '', borrowCap: '8200'},
          {asset: 'kBTC', supplyCap: '', borrowCap: '5'},
        ],
      },
      cache: {blockNumber: 53127846},
    },
  },
};
