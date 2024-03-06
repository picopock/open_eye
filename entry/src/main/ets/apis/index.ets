
import { CategoryService } from './categoryService';
import { FocusService } from './focusService';
import { HomeService } from './homeService';
import { TopicService } from './topicService';

export { paths } from './path';

export const homeService  = new HomeService();
export const focusService = new FocusService();
export const categoryService = new CategoryService();
export const topicService = new TopicService();