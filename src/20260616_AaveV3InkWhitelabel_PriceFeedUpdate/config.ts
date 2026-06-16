import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'priceFeedUpdate',
    shortName: 'PriceFeedUpdate',
    date: '20260616',
    author: 'rohan',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {}, cache: {blockNumber: 48131599}}},
};
