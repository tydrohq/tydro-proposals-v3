import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'updateSyrupSupplyCap',
    shortName: 'UpdateSyrupSupplyCap',
    date: '20260701',
    author: 'rohan',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'syrupUSDT', supplyCap: '10000000', borrowCap: ''}]},
      cache: {blockNumber: 49422195},
    },
  },
};
