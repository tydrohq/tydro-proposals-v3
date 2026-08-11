import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'update ezETH and weETH supply caps',
    shortName: 'UpdateEzETHAndWeETHSupplyCaps',
    date: '20260804',
    author: 'EvanInkFnd',
    discussion: '',
    snapshot: '',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {
        CAPS_UPDATE: [
          {asset: 'ezETH', supplyCap: '492', borrowCap: ''},
          {asset: 'weETH', supplyCap: '12106', borrowCap: ''},
        ],
      },
      cache: {blockNumber: 52378351},
    },
  },
};
