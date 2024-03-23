export const paths = {
  FEED: '/v2/feed',
  FOLLOW: '/v4/tabs/follow',
  CATEGORY: '/v4/categories',
  TOPIC: '/v3/specialTopics',
  RANK: '/v4/rankList/videos',
  VIDEO_RECOMMEND: '/v4/video/related',
  CATEGORY_VIDEO_LIST: '/v4/categories/videoList',
  TOPIC_DETAIL_LIST: (id: number) => `/v3/lightTopics/internal/${id}`
}