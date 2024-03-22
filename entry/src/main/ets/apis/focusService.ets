import { FocusResponse } from '../types/focus';
import { BaseService } from './axios';
import { paths } from './path';

export class FocusService extends BaseService {
  getFocusDataList(pageIndex: number) {
    return this.get<FocusResponse>(paths.FOLLOW, {
      params: {
        start: pageIndex
      },
    });
  }
}