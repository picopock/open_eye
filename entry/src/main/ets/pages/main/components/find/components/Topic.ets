
import router from '@ohos.router';
import { topicService } from '../../../../../apis';
import { LoadingStatus, Skeleton, SkeletonItem, WithPlaceholder } from '../../../../../components/Index';
import { HomeTabsIndex, FindTabsIndex } from '../../../../../constants/provideAlias';
import { RoutePath } from '../../../../../route/Path';
import { Topic as ITopic, TopicItem } from '../../../../../types/topic';
import { imageUrlFormat } from '../../../../../utils/url';

@Component
export default struct Topic {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State isInit: boolean = false;
  @State dataList: TopicItem[] = [];
  @State showLoadMore: boolean = true;
  @State start: number = 0;

  @Consume(HomeTabsIndex) @Watch('onHomeTabsIndexChange') homeTabsIndex: number;
  @Consume(FindTabsIndex) @Watch('onFindTabsIndexChange') findTabsIndex: number;

  onHomeTabsIndexChange() {
    this.initData()
  }

  onFindTabsIndexChange() {
    this.initData()
  }

  initData() {
    if (!this.isInit && this.homeTabsIndex == 1 && this.findTabsIndex == 2) {
      this.loadData()
    }
  }

  loadData = () => {
    this.loadingStatus = LoadingStatus.Loading;
    return topicService.getTopicDataList(this.start)
      .then((res: ITopic) => {
        const items: TopicItem[] = res?.itemList || [];
        if(items.length === 0 && this.showLoadMore) {
          this.showLoadMore = false;
        }
        this.dataList = this.start === 0 ? items : [...this.dataList, ...items];
        this.start = this.start + items.length;
        this.loadingStatus = LoadingStatus.SUCCESS;
      }).catch(() => {
        this.loadingStatus = LoadingStatus.ERROR;
      }).finally(() => {
        if(!this.isInit) {
          this.isInit = true;
        }
      });
  }

  onRefresh = () => {
    this.start = 0;
    this.loadData().finally(() => {
      this.isRefreshing = false;
    });
  }

  aboutToAppear() {
    if(!this.isInit) {
      this.onRefresh();
    }
  }

  build() {
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
          this.content()
        }
        .onRefreshing(this.onRefresh);
      };

      if(!this.isInit || this.isRefreshing) {
        Skeleton({ count: 5 });
      }
    }
    .width('100%')
    .layoutWeight(1);
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ForEach(this.dataList, (item) => {
        ListItem() {
          Image(imageUrlFormat(item.data.image))
            .alt($r('app.media.back_placeholder'))
            .width("100%")
            .height(200)
            .border({ radius: 5 });
        }.onClick(() => {
          router.pushUrl({ url: RoutePath.TopicDetail, params: { "id": item.data.id } });
        })
      });

      if (this.showLoadMore){
        ListItem() {
          SkeletonItem();
        }
      }
    }
    .height('100%')
    .listDirection(Axis.Vertical)
    .padding(10)
    .onReachEnd(() => {
      if(this.showLoadMore) {
        this.loadData();
      }
    });
  }
}