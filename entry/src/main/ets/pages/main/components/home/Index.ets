import { homeService } from '../../../../apis';
import {  LoadingStatus, Skeleton, SkeletonItem, TopBar, WithPlaceholder } from '../../../../components/Index';
import { FeedResponse, IssueItem as IIssueItem } from '../../../../types/home';
import { IssueItem } from './components/IssueItem';

@Preview
@Component
export default struct Index {
  @State isInit: boolean = false;
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State dataList: IIssueItem[] = [];
  @State showLoadMore: boolean = true;

  private data: string = '';

  loadData = () => {
    this.loadingStatus = LoadingStatus.Loading;
    return homeService.getHomeDataList(this.data)
      .then((res) => {
        const data = res as any as FeedResponse;
        const items: IIssueItem[] = data?.issueList?.[0]?.itemList || [];
        let list: IIssueItem[]  = items.filter((item) => item.type == "video");
        if (this.data === "") {
          let bannerList: IIssueItem[] = items.filter((item) => item.type == "banner2");
          if (bannerList.length > 0) {
            if(bannerList.length === 1) {
              bannerList = Array.from({length: 3}, () => bannerList[0]);
            }
            list = [{ type: "banner",  bannerList: bannerList}, ...list];
          }
        }
        if(this.data && list.length === 0 && this.showLoadMore) {
          this.showLoadMore = false;
        }
        this.dataList = this.data === '' ? list : [...this.dataList, ...list];
        this.data = data.nextPageUrl?.split("?")?.[1]?.split('&')?.[0]?.split('=')?.[1];

        this.loadingStatus = LoadingStatus.SUCCESS;
        if(!this.isInit) {
          this.isInit = true;
        }
      }).catch(() => {
        this.loadingStatus = LoadingStatus.ERROR;
      });
  }

  onRefresh = () => {
    this.data = '';
    this.loadData().finally(() => {
      this.isRefreshing = false;
    });
  }

  aboutToAppear() {
    this.onRefresh();
  }

  build() {
    Column() {
      TopBar({title: "首页", alpha: 1, backButton: false, isSubBar: false })
        .align(Alignment.TopStart);

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
          .padding({ left: 10, right: 10 })
          .onRefreshing(this.onRefresh);
        };

        if(!this.isInit || this.isRefreshing) {
          Skeleton({ count: 5 });
        }
      }
      .width('100%')
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ForEach(this.dataList, (item) => {
        ListItem() {
          IssueItem({ data: item });
        }
      });

      if (this.showLoadMore){
        ListItem() {
          SkeletonItem();
        }
      }
    }
    .listDirection(Axis.Vertical)
    .margin({top: 10})
    .divider({
      strokeWidth: 1,
      color: $r('app.color.color_f5f5f5'),
      startMargin: 10,
      endMargin: 10
    })
    .onReachEnd(() => {
      if(this.showLoadMore) {
        this.loadData();
      }
    });
  }
}