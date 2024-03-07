import router from '@ohos.router';
import { categoryService } from '../../../../../apis';
import { LoadingStatus, Skeleton, WithPlaceholder } from '../../../../../components/Index';
import { provideAlias } from '../../../../../constants/provideAlias';
import { RoutePath } from '../../../../../route/Path';
import { Category as ICategory, CategoryDataSource } from '../../../../../types/category';
import { imageUrlFormat } from '../../../../../utils/url';

@Component
export default struct Category {
  @State loadingStatus: LoadingStatus = LoadingStatus.Loading;
  @State isRefreshing: boolean = false;
  @State isInit: boolean = false;
  @State dataList: ICategory[] = [];
  @State dataSource: CategoryDataSource = new CategoryDataSource();
  @State showLoadMore: boolean = true;

  @Consume(provideAlias.HomeTabsIndex) @Watch('onHomeTabsIndexChange') homeTabsIndex: number;
  @Consume(provideAlias.FindTabsIndex) @Watch('onFindTabsIndexChange') findTabsIndex: number;


  onHomeTabsIndexChange() {
    this.initData();
  }

  onFindTabsIndexChange() {
    this.initData();
  }

  initData() {
    if (!this.isInit && this.homeTabsIndex == 1 && this.findTabsIndex == 1) {
      this.loadData();
    }
  }

  loadData() {
    this.loadingStatus = LoadingStatus.Loading;
    categoryService.getCategoryDataList().then((result: any) => {
      this.dataList = result;
      this.dataSource.reloadData(result);
      this.loadingStatus = LoadingStatus.SUCCESS;
    }).catch(() => {
      this.loadingStatus = LoadingStatus.ERROR;
    }).finally(() => {
      if(!this.isInit) {
        this.isInit = true;
      }
    });
  }

  aboutToAppear() {
    if(!this.isInit) {
      this.loadData();
    }
  }

  build() {
    Stack() {
      WithPlaceholder({
        loadingStatus: this.loadingStatus,
        onRetry: this.loadData
      }) {
        Grid() {
          LazyForEach(this.dataSource, (item: ICategory, index: number) => {
            GridItem() {
              Stack() {
                Image(imageUrlFormat(item.bgPicture))
                  .alt($r("app.media.back_placeholder"));
                Text(item.name)
                  .fontColor($r('app.color.color_white'))
                  .fontSize('20fp')
                  .fontWeight(FontWeight.Bold);
              }.border({ radius: 5 });
            }
            .onClick(() => {
              router.pushUrl({ url: RoutePath.CategoryDetail,
                params: {
                  "headerImage": item.headerImage,
                  "title": item.name,
                  "id": item.id
                }
              })
            });
          }, (item: ICategory, index: number) => String(item.id));
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(10)
        .columnsGap(10)
        .width('100%')
        .height("100%")
        .padding(10);
      };

      if(!this.isInit || this.loadingStatus === LoadingStatus.Loading) {
        Skeleton({ count: 5 });
      }
    }.width('100%')
    .layoutWeight(1);
  }
}