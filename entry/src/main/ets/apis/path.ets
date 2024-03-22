export const paths = {
  FEED: '/api/v2/feed',
  FOLLOW: '/api/v4/tabs/follow',
  CATEGORY: '/api/v4/categories',
  TOPIC: '/api/v3/specialTopics',
  RANK: '/api/v4/rankList/videos',
  VIDEO_RECOMMEND: '/api/v4/video/related',
  CATEGORY_VIDEO_LIST: '/api/v4/categories/videoList',
  TOPIC_DETAIL_LIST: (id: number) => `/api/v3/lightTopics/internal/${id}`
}