import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'Restore WETH LTV levels',
    author: 'EvanInkFnd',
    force: true,
    shortName: 'RestoreWETHLTVLevels',
    date: '20260518',
  },
  poolOptions: {AaveV3InkWhitelabel: {configs: {OTHERS: {}}, cache: {blockNumber: 45627082}}},
};
