import { base } from '../constants/base';
import { Topic } from '../types/topic';
import axios from './axios/index';
import { paths } from './path';

export class CategoryDetailService {
  constructor(baseUrl = '') {
  }

  getCategoryDetailList(id: number, start: number) {
    return axios.get<Topic[]>(paths.CATEGORY_VIDEO_LIST, {
      params: {
        id,
        start,
        udid: base.UUID,
        deviceModel: base.DEVICE_NUM
      },
    });
  }
}