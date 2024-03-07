import router from '@ohos.router';
import { TopBar, VideoPlayer } from '../../components/Index';
import { RoutePath } from '../../route/Path';
import { RecommendInfo } from './RecommendInfo';

@Entry
@Component
struct Detail {
  @State playUrl: string = '';
  @State relationId: number = -1;
  @State isAutoPlay: boolean = true;
  @State showControls: boolean = true;

  onBackClick = () => {
    const length = router.getLength();
    if(Number(length) > 1) {
      router.back();
    } else {
      router.replaceUrl(({
        url: RoutePath.Main
      }));
    }
  }

  onRecommendItemClick = (playUrl: string) => {
    this.playUrl = playUrl;
  }

  aboutToAppear() {
    const params = router.getParams();
    this.relationId = params['id'];
    this.playUrl = params['playUrl'];
  }

  build() {
    Column() {
      TopBar({ title: '视频详情', alpha: 1, backButton: true, onBackClick: this.onBackClick });
      VideoPlayer({ url: this.playUrl, showControls: this.showControls, isAutoPlay: this.isAutoPlay })
        .width('100%')
        .height(248);
      Row() {
        RecommendInfo({ relationId: this.relationId, onItemClick: this.onRecommendItemClick });
      }
      .width('100%')
      .layoutWeight(1);
    }
  }
}