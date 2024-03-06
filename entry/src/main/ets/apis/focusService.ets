import { FocusResponse } from '../types/focus';
import axios from './axios/index';
import { paths } from './path';

export class FocusService {
  constructor(baseUrl = '') {
  }

  getFocusDataList(pageIndex: number) {
    return axios.get<FocusResponse>(paths.FOLLOW, {
      params: {
        start: pageIndex
      },
    });
  }
}