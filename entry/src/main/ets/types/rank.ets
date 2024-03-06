import { VideoData } from './home';
export interface Rank {
  itemList: RankItem[];
  count: number;
  total: number;
  nextPageUrl: string;
  adExist: boolean;
}

export interface RankItem {
  type: string;
  data: VideoData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}
