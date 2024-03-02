export interface FeedResponse {
  dialog?: any
  issueList: Issue[];
  newestIssueType: string;
  nextPageUrl: string;
  nextPublishTime: number;
}

export interface Issue {
  count: number;
  date: number;
  itemList: IssueItem[];
  publishTime: number;
  releaseTime: number;
  type: string;
}

export interface IssueItem {
  type: string;
  adIndex?: number;
  data?: BannerData | VideoData;
  id?: number;
  tag?: any
  trackingData?: any
  bannerList?: IssueItem[];
}

export interface BannerData {
  id: number;
  dataType: string;
  title: string;
  description: string;
  actionUrl: string;
  adTrack?: any;
  autoPlay: boolean;
  header: any
  image: string;
  label: string;
  labelList?: string[];
  shade: boolean;

}

export interface VideoData {
  id: number;
  dataType: string;
  title: string;
  description: string;
  library: string;
  tags: Tag[];
  consumption: {
    collectionCount: number;
    shareCount: number;
    replyCount: number;
    realCollectionCount: number;
  }
  resourceType: string;
  slogan: any;
  provider: {
    name: string;
    alias: string;
    icon: string;
  },
  category: string;
  author: Author;
  cover: Cover;
  playUrl: string;
  thumbPlayUrl?: string;
  duration: number;
  webUrl: {
    raw: string;
    forWeibo: string;
  },
  releaseTime: number;
  playInfo: any[];
  campaign: any;
  waterMarks: any;
  ad: boolean;
  adTrack: any[];
  type: string;
  titlePgc: string;
  descriptionPgc: string;
  remark: any;
  ifLimitVideo: boolean;
  searchWeight: number;
  brandWebsiteInfo: any;
  videoPosterBean: any;
  idx: number;
  shareAdTrack: any;
  favoriteAdTrack: any;
  webAdTrack: any;
  date: number;
  promotion: any;
  label: any;
  labelList: any[];
  descriptionEditor: string;
  collected: boolean;
  reallyCollected: boolean;
  played: boolean;
  subtitles: any[]
  lastViewTime: any;
  playlists: any;
  src: any;
  recallSource: any;
  recall_source: any;
}

export interface Tag {
  id: number;
  name: string;
  actionUrl: string;
  adTrack: any;
  desc: string;
  bgPicture: string;
  headerImage: string;
  tagRecType: string;
  childTagList: any;
  childTagIdList: any;
  haveReward: boolean;
  ifNewest: boolean;
  newestEndTime: any;
  communityIndex: number;
}

export interface Cover {
  feed: string;
  detail: string;
  blurred: string;
  sharing?: any;
  homepage: string;
}

export interface Author {
  id: number;
  icon: string;
  name: string;
  description: string;
  link: string;
  latestReleaseTime: number;
  videoNum: number;
  adTrack?: any;
  follow: RootObjectFollow;
  shield: RootObjectShield;
  approvedNotReadyVideoCount: number;
  ifPgc: boolean;
  recSort: number;
  expert: boolean;
}

export interface RootObjectFollow {
  itemType: string;
  itemId: number;
  followed: boolean;
}

export interface RootObjectShield {
  itemType: string;
  itemId: number;
  shielded: boolean;
}




