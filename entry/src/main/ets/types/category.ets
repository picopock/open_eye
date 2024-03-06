import { BasicDataSource } from './basicDataSource';

export interface Category {
  id: number;
  name: string;
  alias?: any;
  description: string;
  bgPicture: string;
  bgColor: string;
  headerImage: string;
  defaultAuthorId: number;
  tagId: number;
}

export class CategoryDataSource extends BasicDataSource<Category> {
}