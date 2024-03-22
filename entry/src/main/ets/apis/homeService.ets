import { FeedResponse } from '../types/home';
import { BaseService } from './axios';
import { paths } from './path';

export class HomeService extends BaseService {
  getHomeDataList(params: string = '') {
    return this.get<FeedResponse>(paths.FEED, {
      params: {
        data: params
      },
    });
  }
}