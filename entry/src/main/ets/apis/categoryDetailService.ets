import { base } from '../constants/base';
import { Recommend } from '../types/recommend';
import axios from './axios/index';
import { paths } from './path';

export class CategoryDetailService {
  constructor(baseUrl = '') {
  }

  getCategoryDetailList(id: number, start: number) {
    return axios.get<any, Recommend>(paths.CATEGORY_VIDEO_LIST, {
      params: {
        id,
        start,
        udid: base.UUID,
        deviceModel: base.DEVICE_NUM
      },
    });
  }
}