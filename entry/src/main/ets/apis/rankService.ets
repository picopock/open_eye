import { Rank } from '../types/rank';
import axios from './axios/index';
import { paths } from './path';

export class RankService {
  constructor(baseUrl = '') {
  }

  getRankDataList(type: 'weekly'|'monthly'|'historical') {
    return axios.get<any, Rank>(paths.RANK, {
      params: {
        strategy: type
      },
    });
  }
}