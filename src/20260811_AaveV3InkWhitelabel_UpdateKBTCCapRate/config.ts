import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Update kBTC cap & rate',
    shortName: 'UpdateKBTCCapRate',
    date: '20260811',
    author: 'Martin',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        RATE_UPDATE_V3: [
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
        CAPS_UPDATE: [{asset: 'kBTC', supplyCap: '', borrowCap: '20'}],
      },
      cache: {blockNumber: 52962553},
    },
  },
};
