import router from '@ohos.router';
import { topicService } from '../apis';
import { LoadingStatus, Skeleton, TopBar, VideoPlayer, WithPlaceholder } from '../components/Index';
import { RoutePath } from '../route/Path';
import { TopicDetail as ITopicDetail, TopicDetailItem } from '../types/topicDetail';

@Entry
@Component
struct TopicDetail {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State isInit: boolean = false;
  @State @Watch('onTopicIdChange') topicId: number = -1;
  @State topicDetail: ITopicDetail = {};
  @State title: string = "";
  @State alpha: number = 1;
  @State playIndex: number = -1;
  @State isAutoPlay: boolean = true;
  @State showControls: boolean = true;
  @State playUrl: string = "";

  onTopicIdChange(id: number) {
    this.loadData();
  }

  loadData = () => {
    if(this.topicId === -1) {
      return Promise.resolve();
    }

    this.loadingStatus = LoadingStatus.Loading;
    return topicService.getTopicDetailList(this.topicId)
      .then(res => {
        this.topicDetail = res as any as ITopicDetail;
        this.title = this.topicDetail.brief;
        this.loadingStatus = LoadingStatus.SUCCESS;
      })
      .catch(() => {
        this.loadingStatus = LoadingStatus.ERROR;
      })
      .finally(() => {
        if(!this.isInit) {
          this.isInit = true;
        }
      });
  }

  onRefresh = () => {
    this.loadData().finally(() => {
      this.isRefreshing = false;
    });
  }

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

  aboutToAppear() {
    const params = router.getParams();
    this.topicId = params['id'];

    this.onRefresh();
  }

  build() {
    Column() {
      TopBar({ title: this.title, alpha: this.alpha, titleAlign: FlexAlign.Start, backButton: true, onBackClick: this.onBackClick });
      Stack() {
        WithPlaceholder({
          loadingStatus: this.loadingStatus,
          onRetry: this.onRefresh
        }) {
          Refresh({
            refreshing: $$this.isRefreshing,
            offset: 60,
            friction: 80
          }) {
            this.content();
          }
          .height('100%')
          .onRefreshing(this.onRefresh);
        };

        if(!this.isInit || this.isRefreshing) {
          Skeleton({ count: 5 });
        }
      }
      .layoutWeight(1)
      .alignContent(Alignment.TopStart);
    }
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ListItem() {
        this.topicHeader();
      }

      ForEach(this.topicDetail.itemList, (item, index) => {
        ListItem() {
          this.itemContent(item, index)
        };
      });

      ListItem().width('100%').height(10);
    }
    .height('100%')
    .listDirection(Axis.Vertical)
    .onScrollIndex((firstIndex: number, lastIndex: number) => {
      if (this.playIndex > lastIndex || this.playIndex < firstIndex) {
        this.playIndex = -1;
      }
    });
  }

  @Builder
  topicHeader() {
    Column() {
      Image(this.topicDetail.headerImage)
        .width("100%")
        .height(280)
        .alt($r('app.media.back_placeholder'));

      Text(this.topicDetail.brief)
        .width("80%")
        .height(46)
        .fontSize('14fp')
        .fontColor('#333')
        .textAlign(TextAlign.Center)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .margin({ top: -23 })
        .border({ radius: 5, width: 1, color: '#333' })
        .backgroundColor($r('app.color.color_white'));

      Text(this.topicDetail.text)
        .fontColor('#555')
        .fontSize('13fp')
        .margin(10);
    }
  }

  @Builder
  itemContent(item: TopicDetailItem, index: number) {
    Column() {
      if (this.playIndex == index) {
        VideoPlayer({
          url: this.playUrl,
          showControls: this.showControls,
          isAutoPlay: this.isAutoPlay
        })
          .width('100%')
          .height(248);
      } else {
        Stack() {
          Image(item.data.content.data.cover.feed)
            .width("100%")
            .height(248)
            .alt($r('app.media.back_placeholder'))

          Image($r('app.media.icon_play'))
            .width(45)
            .height(45)
            .alt($r('app.media.back_placeholder'))
            .onClick(() => {
              this.playIndex = index;
              this.playUrl = item.data.content.data.playUrl;
            })
        }
      }

      Text(this.topicDetail.brief)
        .width("80%")
        .fontSize('14fp')
        .fontColor('#333')
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 10 })
        .backgroundColor($r('app.color.color_white'));

      Text(this.topicDetail.text)
        .fontSize('13fp')
        .fontColor('#555')
        .margin(10);
    }
  }
}