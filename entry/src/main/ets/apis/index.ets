
import { CategoryDetailService } from './categoryDetailService';
import { CategoryService } from './categoryService';
import { FocusService } from './focusService';
import { HomeService } from './homeService';
import { RankService } from './rankService';
import { TopicService } from './topicService';
import { VideoService } from './videoService';

export { paths } from './path';

export const homeService  = new HomeService();
export const focusService = new FocusService();
export const categoryService = new CategoryService();
export const topicService = new TopicService();
export const rankService = new RankService();
export const videoService = new VideoService();
export const categoryDetailService = new CategoryDetailService();