import { Category } from '../types/category';
import axios from './axios/index';
import { paths } from './path';

export class CategoryService {
  constructor(baseUrl = '') {
  }

  getCategoryDataList() {
    return axios.get<Category[]>(paths.CATEGORY, {
      params: {
        showLoading: true,
        checkLoginState: true,
        needJumpToLogin: true
      },
    });
  }
}