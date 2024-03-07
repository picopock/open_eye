import router from '@ohos.router';
import { categoryDetailService } from '../apis';
import { LoadingStatus, Skeleton, SkeletonItem, TopBar, WithPlaceholder } from '../components/Index';
import { RoutePath } from '../route/Path';
import { Recommend, RecommendItem } from '../types/recommend';
import { imageUrlFormat } from '../utils/url';
import { IssueItem } from './main/components/home/components/IssueItem';

@Entry
@Component
struct CategoryDetail {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State showLoadMore: boolean = true;
  @State isInit: boolean = false;
  @State start: number = 0;
  @State @Watch('onRelationIdChange') relationId: number = -1;
  @State dataList: RecommendItem[] = [];
  @State headerImage: string = "";
  @State title: string = "";
  @State alpha: number = 0;

  private scrollOffset: number = 0

  onRelationIdChange(id: number) {
    this.loadData();
  }

  dispatchScrollOffset() {
    const alpha = this.scrollOffset / 300;
    this.alpha = alpha > 1 ? 1 : alpha < 0 ? 0 : alpha;
  }

  loadData = () => {
    if(this.relationId === -1) {
      return Promise.resolve();
    }

    this.loadingStatus = LoadingStatus.Loading;
    return categoryDetailService.getCategoryDetailList(this.relationId, this.start)
      .then((data: Recommend) => {
        const items: RecommendItem[] = data.itemList;
        if(items.length === 0 && this.showLoadMore) {
          this.showLoadMore = false;
        }
        this.dataList = this.start === 0 ? items : [...this.dataList, ...items];
        this.start += items.length;
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
    this.start = 0;
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
    this.relationId = params['id'];
    this.headerImage = params["headerImage"];
    this.title = params["title"];

    this.onRefresh();
  }

  build() {
    Stack() {
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

      TopBar({ title: this.title, alpha: this.alpha, titleAlign: FlexAlign.Start, backButton: true, onBackClick: this.onBackClick });
    }
    .height('100%')
    .alignContent(Alignment.TopStart);
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ListItem() {
        Image(imageUrlFormat(this.headerImage))
          .width("100%")
          .height(300)
          .alt($r('app.media.back_placeholder'));
      }

      ForEach(this.dataList, (item) => {
        ListItem() {
          IssueItem({ data: item });
        }
        .padding({ left: 10, right: 10 })
        .onClick(() => {
          router.pushUrl({ url: RoutePath.Detail, params: { "id": item.data.id, playUrl: item.data.playUrl } });
        });
      });

      ListItem().width(10).height(10);

      if (this.showLoadMore){
        ListItem() {
          SkeletonItem();
        }
      }
    }
    .height('100%')
    .listDirection(Axis.Vertical)
    .divider({
      strokeWidth: 1,
      color: $r('app.color.color_f5f5f5'),
      startMargin: 10,
      endMargin: 10
    })
    .onScroll((scrollOffset: number, scrollState: ScrollState) => {
      this.scrollOffset += scrollOffset
      this.dispatchScrollOffset()
    })
    .onScrollStop(() => {
      this.dispatchScrollOffset()
    })
    .onReachEnd(() => {
      if(this.showLoadMore) {
        this.loadData();
      }
    });
  }
}