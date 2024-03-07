
import { focusService } from '../../../../../../apis';
import { LoadingStatus, Skeleton, SkeletonItem, WithPlaceholder } from '../../../../../../components/Index';
import { FocusItem as IFocusItem, FocusResponse } from '../../../../../../types/focus';
import FocusItem from './FocusItem';

@Component
export default struct Index {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State isInit: boolean = false;
  @State dataList: IFocusItem[] = [];
  @State showLoadMore: boolean = true;
  @State start: number = 0;

  loadData = () => {
    this.loadingStatus = LoadingStatus.Loading;
    return focusService.getFocusDataList(this.start)
      .then((res: FocusResponse) => {
        const items: IFocusItem[] = res?.itemList || [];
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
        .height('100%')
        .onRefreshing(this.onRefresh);
      };

      if(!this.isInit || this.isRefreshing) {
        Skeleton({ count: 5 });
      }
    }
    .height('100%')
    .alignContent(Alignment.TopStart);
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ForEach(this.dataList, (item) => {
        ListItem() {
          FocusItem({ data: item });
        }
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