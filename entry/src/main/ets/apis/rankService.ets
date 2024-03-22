import { Rank } from '../types/rank';
import { BaseService } from './axios';
import { paths } from './path';

export class RankService extends BaseService {
  getRankDataList(type: 'weekly'|'monthly'|'historical') {
    return this.get<Rank>(paths.RANK, {
      params: {
        strategy: type
      },
    });
  }
}