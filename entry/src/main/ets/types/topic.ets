export interface Topic {
  itemList: TopicItem[];
  count: number;
  total: number;
  nextPageUrl: string;
  adExist: boolean;
}

export interface TopicItem {
  type: string;
  data: TopicItemData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}

export interface TopicItemData {
  dataType: string;
  id: number;
  title: string;
  description: string;
  image: string;
  actionUrl: string;
  adTrack: any[];
  shade: boolean;
  label: TopicItemDataLabel;
  labelList: any[];
  header?: any;
  autoPlay: boolean;
}

export interface TopicItemDataLabel {
  text: string;
  card: string;
  detail?: any;
}

