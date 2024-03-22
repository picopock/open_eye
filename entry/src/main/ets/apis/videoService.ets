import { Recommend } from '../types/recommend';
import { BaseService } from './axios';
import { paths } from './path';

export class VideoService extends BaseService {
  getRecommendDataList(relationId: number) {
    return this.get<Recommend>(paths.VIDEO_RECOMMEND, {
      params: {
        id: relationId
      },
    });
  }
}