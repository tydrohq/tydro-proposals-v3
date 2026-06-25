import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'aaveAdapter',
    shortName: 'AaveAdapter',
    date: '20260624',
    author: 'rohan',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {}, cache: {blockNumber: 48829233}}},
};
