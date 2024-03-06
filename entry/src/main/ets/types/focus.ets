export interface FocusResponse {
  itemList: FocusItem[];
  count: number;
  total: number;
  nextPageUrl: string;
  adExist: boolean;
  updateTime?: any;
  refreshCount: number;
  lastStartId: number;
}

export interface FocusItem {
  type: string;
  data: FocusItemData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}

export interface FocusItemData {
  dataType: string;
  header: FocusItemDataHeader;
  itemList: FocusItemDataItem[];
  count: number;
  adTrack?: any;
  footer?: any;
}

export interface FocusItemDataHeader {
  id: number;
  icon: string;
  iconType: string;
  title: string;
  subTitle?: any;
  description: string;
  actionUrl: string;
  adTrack?: any;
  follow: FocusItemDataHeaderFollow;
  ifPgc: boolean;
  uid: number;
  ifShowNotificationIcon: boolean;
  expert: boolean;
}

export interface FocusItemDataHeaderFollow {
  itemType: string;
  itemId: number;
  followed: boolean;
}

export interface FocusItemDataItem {
  type: string;
  data: FocusItemDataItemData;
  trackingData?: any;
  tag?: any;
  id: number;
  adIndex: number;
}

export interface FocusItemDataItemData {
  dataType: string;
  id: number;
  title: string;
  description: string;
  library: string;
  tags: FocusItemDataItemDataTags[];
  consumption: FocusItemDataItemDataConsumption;
  resourceType: string;
  slogan?: any;
  provider: FocusItemDataItemDataProvider;
  category: string;
  author: FocusItemDataItemDataAuthor;
  cover: FocusItemDataItemDataCover;
  playUrl: string;
  thumbPlayUrl?: any;
  duration: number;
  webUrl: FocusItemDataItemDataWebUrl;
  releaseTime: number;
  playInfo: FocusItemDataItemDataPlayInfo[];
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
  videoPosterBean: FocusItemDataItemDataVideoPosterBean;
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

export interface FocusItemDataItemDataTags {
  id: number;
  name: string;
  actionUrl: string;
  adTrack?: any;
  desc: string;
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

export interface FocusItemDataItemDataConsumption {
  collectionCount: number;
  shareCount: number;
  replyCount: number;
  realCollectionCount: number;
}

export interface FocusItemDataItemDataProvider {
  name: string;
  alias: string;
  icon: string;
}

export interface FocusItemDataItemDataAuthor {
  id: number;
  icon: string;
  name: string;
  description: string;
  link: string;
  latestReleaseTime: number;
  videoNum: number;
  adTrack?: any;
  follow: FocusItemDataItemDataAuthorFollow;
  shield: FocusItemDataItemDataAuthorShield;
  approvedNotReadyVideoCount: number;
  ifPgc: boolean;
  recSort: number;
  expert: boolean;
}

export interface FocusItemDataItemDataAuthorFollow {
  itemType: string;
  itemId: number;
  followed: boolean;
}

export interface FocusItemDataItemDataAuthorShield {
  itemType: string;
  itemId: number;
  shielded: boolean;
}

export interface FocusItemDataItemDataCover {
  feed: string;
  detail: string;
  blurred: string;
  sharing?: any;
  homepage?: any;
}

export interface FocusItemDataItemDataWebUrl {
  raw: string;
  forWeibo: string;
}

export interface FocusItemDataItemDataPlayInfo {
  height: number;
  width: number;
  urlList: FocusItemDataItemDataPlayInfoUrl[];
  name: string;
  type: string;
  url: string;
}

export interface FocusItemDataItemDataPlayInfoUrl {
  name: string;
  url: string;
  size: number;
}

export interface FocusItemDataItemDataVideoPosterBean {
  scale: number;
  url: string;
  fileSizeStr: string;
}



