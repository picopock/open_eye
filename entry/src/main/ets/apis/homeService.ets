import { FeedResponse } from '../types/home';
import axios from './axios/index';
import { paths } from './path';

export class HomeService {
  constructor(baseUrl = '') {
  }

  getHomeDataList(params: string = '') {
    return axios.get<any, FeedResponse>(paths.FEED, {
      params: {
        data: params
      },
    });
  }
}