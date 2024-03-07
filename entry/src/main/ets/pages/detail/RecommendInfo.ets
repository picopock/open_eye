import { videoService } from '../../apis';
import { LoadingStatus, WithPlaceholder } from '../../components/Index';
import { Recommend, RecommendItem } from '../../types/recommend';
import { noop } from '../../utils/noop';

@Component
export struct RecommendInfo {
  @Prop @Watch('onRelationIdChange') relationId: number;

  @State isInit: boolean = false;
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State dataList: RecommendItem[] = [];
  @State playIndex: number = -1;

  private onItemClick: Function = noop;

  onRelationIdChange(relationId: number) {
    this.loadData();
  }

  loadData = () => {
    if(this.relationId === -1) {
      return ;
    }

    this.loadingStatus = LoadingStatus.Loading;
    videoService.getRecommendDataList(this.relationId)
      .then(res => {
        const data = res as any as Recommend;
        const filterList: RecommendItem[] = data.itemList.filter((item) => item.type === "videoSmallCard");
        this.dataList = filterList;

        this.loadingStatus = LoadingStatus.SUCCESS;
      })
      .catch(err => {
        this.loadingStatus = LoadingStatus.ERROR;
      })
      .finally(() => {
        if(!this.isInit) {
          this.isInit = true;
        }
      });
  }

  aboutToAppear() {
    this.loadData();
  }

  build() {
    WithPlaceholder({
      loadingStatus: this.loadingStatus,
      enableLoading: true,
      onRetry: this.loadData
    }) {
      this.content();
    };
  }

  @Builder
  content() {
    List({ space: 10, initialIndex: 0 }) {
      ForEach(this.dataList, (item, index) => {
        ListItem() {
          this.recommendItem(item, index);
        }.onClick(() => {
          this.onItemClick?.(item.data.playUrl)
          this.playIndex = index;
        });
      });
    }
    .width("100%")
    .height("100%")
    .padding(10);
  }

  @Builder
  recommendItem(item: RecommendItem, index: number) {
    Row() {
      Image(item.data?.cover.feed)
        .width(100)
        .height(70)
        .alt($r('app.media.back_placeholder'))
        .border({ radius: 5 })
        .backgroundColor($r('app.color.color_f5f5f5'));

      Column() {
        Text(item.data?.title)
          .maxLines(1)
          .fontColor(this.playIndex == index ? $r('app.color.color_red') : '#333')
          .fontSize('15fp')
          .textOverflow({ overflow: TextOverflow.Ellipsis });
        Text(item.data?.description)
          .maxLines(2)
          .fontColor(this.playIndex == index ? $r('app.color.color_red') : '#777')
          .fontSize('12fp')
          .textOverflow({ overflow: TextOverflow.Ellipsis });
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .height(70)
      .margin({ left: 10 })
      .padding({ top: 5, bottom: 5 });
    }
    .width("100%")
    .height(80)
    .alignItems(VerticalAlign.Center)
  }
}