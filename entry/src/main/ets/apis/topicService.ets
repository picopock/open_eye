import { Topic } from '../types/topic';
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
}