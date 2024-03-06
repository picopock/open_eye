import { VideoData } from './home';

export interface Recommend {
  itemList: RecommendItem[];
  count: number;
  total: number;
  nextPageUrl: string;
  adExist: boolean;
}

export interface RecommendItem {
  type: string;
  data: VideoData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}
