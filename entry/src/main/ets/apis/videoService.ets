import { Recommend } from '../types/recommend';
import axios from './axios/index';
import { paths } from './path';

export class VideoService {
  constructor(baseUrl = '') {
  }

  getRecommendDataList(relationId: number) {
    return axios.get<any, Recommend>(paths.VIDEO_RECOMMEND, {
      params: {
        id: relationId
      },
    });
  }
}