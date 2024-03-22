import { Category } from '../types/category';
import { BaseService } from './axios';
import { paths } from './path';

export class CategoryService extends BaseService {
  getCategoryDataList() {
    return this.get<Category[]>(paths.CATEGORY, {
      params: {
        showLoading: true,
        checkLoginState: true,
        needJumpToLogin: true
      },
    });
  }
}