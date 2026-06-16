import {ConfigFile} from '../../generator/types';
export const config: ConfigFile = {
  rootOptions: {
    pools: ['AaveV3InkWhitelabel'],
    title: 'update SolvBTC supply cap to 400',
    shortName: 'UpdateSolvBTCSupplyCapTo400',
    date: '20260520',
    author: 'EvanInkFnd',
  },
  poolOptions: {
    AaveV3InkWhitelabel: {
      configs: {CAPS_UPDATE: [{asset: 'SolvBTC', supplyCap: '400', borrowCap: ''}]},
      cache: {blockNumber: 45824470},
    },
  },
};
