import router from '@ohos.router';
import { TopBar } from '../components/Index';
import Focus from './main/components/find/components/focus/Index';
import Category from './main/components/find/components/Category';
import Topic from './main/components/find/components/Topic';
import { RoutePath } from '../route/Path';

@Entry
@Component
struct Info {
  @State containerType: string = '';
  @State title: string = '';

  @Provide(/* provideAlias.HomeTabsIndex */'homeTabsIndex') activeIndex: number = 1;
  @Provide(/* provideAlias.FindTabsIndex */ 'findTabsIndex') currentTabsIndex: number = 0;

  getTitle() {
    const titleMap: Record<string, string> = {
      focus: '关注',
      category: '分类',
      topic: '主题'
    };

    return titleMap[this.containerType] || '';
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
    this.containerType = router.getParams()["containerType"];
    this.currentTabsIndex = this.containerType === 'category' ? 1 : 2;
    this.getTitle();
  }

  build() {
    Column() {
      TopBar({ title: this.getTitle(), alpha: 1, backButton: true, onBackClick: this.onBackClick })
        .align(Alignment.TopStart);

      this.content();
    }
  }

  @Builder
  content() {
    if (this.containerType == 'focus') {
      Focus();
    } else if (this.containerType == 'topic') {
      Topic();
    } else if (this.containerType == 'category') {
      Category();
    } else {
      Text("暂未找到页面");
    }
  }
}