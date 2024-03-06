export interface TopicDetail {
  id?: number;
  headerImage?: string;
  brief?: string;
  text?: string;
  shareLink?: string;
  itemList?: TopicDetailItem[];
  count?: number;
  adTrack?: any;
}

export interface TopicDetailItemDataHeader {
  id: number;
  actionUrl: string;
  labelList?: any;
  icon: string;
  iconType: string;
  time: number;
  showHateVideo: boolean;
  followType: string;
  tagId: number;
  tagName?: any;
  issuerName: string;
  topShow: boolean;
}

export interface TopicDetailItemDataContentDataTag {
  id: number;
  name: string;
  actionUrl: string;
  adTrack?: any;
  desc?: any;
  bgPicture: string;
  headerImage: string;
  tagRecType: string;
  childTagList?: any;
  childTagIdList?: any;
  haveReward: boolean;
  ifNewest: boolean;
  newestEndTime?: any;
  communityIndex: number;
}

export interface TopicDetailItemDataContentDataConsumption {
  collectionCount: number;
  shareCount: number;
  replyCount: number;
  realCollectionCount: number;
}

export interface TopicDetailItemDataContentDataProvider {
  name: string;
  alias: string;
  icon: string;
}

export interface TopicDetailItemDataContentDataAuthorFollow {
  itemType: string;
  itemId: number;
  followed: boolean;
}

export interface TopicDetailItemDataContentDataAuthorShield {
  itemType: string;
  itemId: number;
  shielded: boolean;
}

export interface TopicDetailItemDataContentDataAuthor {
  id: number;
  icon: string;
  name: string;
  description: string;
  link: string;
  latestReleaseTime: number;
  videoNum: number;
  adTrack?: any;
  follow: TopicDetailItemDataContentDataAuthorFollow;
  shield: TopicDetailItemDataContentDataAuthorShield;
  approvedNotReadyVideoCount: number;
  ifPgc: boolean;
  recSort: number;
  expert: boolean;
}

export interface TopicDetailItemDataContentDataCover {
  feed: string;
  detail: string;
  blurred: string;
  sharing?: any;
  homepage?: any;
}

export interface TopicDetailItemDataContentDataWebUrl {
  raw: string;
  forWeibo: string;
}

export interface TopicDetailItemDataContentDataPlayInfoUrl {
  name: string;
  url: string;
  size: number;
}

export interface TopicDetailItemDataContentDataPlayInfo {
  height: number;
  width: number;
  urlList: TopicDetailItemDataContentDataPlayInfoUrl[];
  name: string;
  type: string;
  url: string;
}

export interface TopicDetailItemDataContentData {
  dataType: string;
  id: number;
  title: string;
  description: string;
  library: string;
  tags: TopicDetailItemDataContentDataTag[];
  consumption: TopicDetailItemDataContentDataConsumption;
  resourceType: string;
  slogan?: any;
  provider: TopicDetailItemDataContentDataProvider;
  category: string;
  author: TopicDetailItemDataContentDataAuthor;
  cover: TopicDetailItemDataContentDataCover;
  playUrl: string;
  thumbPlayUrl?: any;
  duration: number;
  webUrl: TopicDetailItemDataContentDataWebUrl;
  releaseTime: number;
  playInfo: TopicDetailItemDataContentDataPlayInfo[];
  campaign?: any;
  waterMarks?: any;
  ad: boolean;
  adTrack: any[];
  type: string;
  titlePgc: string;
  descriptionPgc: string;
  remark: string;
  ifLimitVideo: boolean;
  searchWeight: number;
  brandWebsiteInfo?: any;
  videoPosterBean?: any;
  idx: number;
  shareAdTrack?: any;
  favoriteAdTrack?: any;
  webAdTrack?: any;
  date: number;
  promotion?: any;
  label?: any;
  labelList: any[];
  descriptionEditor: string;
  collected: boolean;
  reallyCollected: boolean;
  played: boolean;
  subtitles: any[];
  lastViewTime?: any;
  playlists?: any;
  src?: any;
  recallSource?: any;
  recall_source?: any;
}

export interface TopicDetailItemDataContent {
  type: string;
  data: TopicDetailItemDataContentData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}

export interface TopicDetailItemData {
  dataType: string;
  header: TopicDetailItemDataHeader;
  content: TopicDetailItemDataContent;
  adTrack: any[];
}

export interface TopicDetailItem {
  type: string;
  data: TopicDetailItemData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}
