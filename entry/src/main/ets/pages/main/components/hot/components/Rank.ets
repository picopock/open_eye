
import router from '@ohos.router';
import { rankService } from '../../../../../apis';
import { LoadingStatus, Skeleton, SkeletonItem, WithPlaceholder } from '../../../../../components/Index';
import { HomeTabsIndex, HotTabsIndex } from '../../../../../constants/provideAlias';
import { RoutePath } from '../../../../../route/Path';
import { Rank as IRank, RankItem } from '../../../../../types/rank';
import { IssueItem } from '../../home/components/IssueItem';

@Component
export default struct Rank {
  private type: 'weekly'|'monthly'|'historical';
  private index: number;
  private name: string;

  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State isInit: boolean = false;
  @State dataList: RankItem[] = [];

  @Consume(HomeTabsIndex) @Watch('onHomeTabsIndexChange') homeTabsIndex: number;
  @Consume(HotTabsIndex) @Watch('onHotTabsIndexChange') hotTabsIndex: number;

  onHomeTabsIndexChange() {
    this.initData()
  }

  onHotTabsIndexChange() {
    this.initData()
  }

  initData() {
    if (!this.isInit && this.homeTabsIndex == 2 && this.hotTabsIndex == this.index) {
      this.loadData()
    }
  }

  loadData = () => {
    this.loadingStatus = LoadingStatus.Loading;
    return rankService.getRankDataList(this.type)
      .then((res) => {
        const data = res as any as IRank;
        const items: RankItem[] = data?.itemList || [];
        this.dataList = items;
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
    this.loadData().finally(() => {
      this.isRefreshing = false;
    });
  }

  aboutToAppear(){
    this.initData();
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
          IssueItem({ data: item });
        }.onClick(() => {
          router.pushUrl({ url: RoutePath.Detail, params: { "id": item.data.id, playUrl: item.data.playUrl } });
        });
      });
      if(this.dataList.length) {
        ListItem() {
          this.footer()
        }
      }
    }
    .height('100%')
    .listDirection(Axis.Vertical)
    .padding(10);
  }

  @Builder
  footer() {
    Row() {
      Divider()
        .strokeWidth(2)
        .color('#999')
        .width('50vp');
      Text("我是有底线的")
        .margin({ left: 15, right: 15 })
        .fontSize('15fp')
        .fontColor('#999');
      Divider()
        .strokeWidth(2)
        .color('#999')
        .width('50vp');
    }
    .width("100%")
    .height(50)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center);
  }
}