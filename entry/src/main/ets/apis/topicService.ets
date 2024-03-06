import { Topic } from '../types/topic';
import { TopicDetail } from '../types/topicDetail';
import axios from './axios/index';
import { paths } from './path';

export class TopicService {
  constructor(baseUrl = '') {
  }

  getTopicDataList(start = 0) {
    return axios.get<Topic[]>(paths.TOPIC, {
      params: {
        start
      },
    });
  }

  getTopicDetailList(id: number) {
    return axios.get<TopicDetail>(paths.TOPIC_DETAIL_LIST(id));
  }
}