import { base } from '../constants/base';
import { Recommend } from '../types/recommend';
import { BaseService } from './axios';
import { paths } from './path';

export class CategoryDetailService extends BaseService {
  getCategoryDetailList(id: number, start: number) {
    return this.get<Recommend>(paths.CATEGORY_VIDEO_LIST, {
      params: {
        id,
        start,
        udid: base.UUID,
        deviceModel: base.DEVICE_NUM
      },
    });
  }
}