import { Topic } from '../types/topic';
import { TopicDetail } from '../types/topicDetail';
import { BaseService } from './axios';
import { paths } from './path';

export class TopicService extends BaseService {

  getTopicDataList(start = 0) {
    return this.get<Topic>(paths.TOPIC, {
      params: {
        start
      },
    });
  }

  getTopicDetailList(id: number) {
    return this.get<TopicDetail>(paths.TOPIC_DETAIL_LIST(id));
  }
}