import router from '@ohos.router';
import { TopBar } from '../components/Index';
import Focus from './main/components/find/components/focus/Index';
import Category from './main/components/find/components/Category';
import Topic from './main/components/find/components/Topic';

@Entry
@Component
struct Info {
  @State containerType: string = '';
  @State title: string = '';

  getTitle() {
    const titleMap: Record<string, string> = {
      focus: '关注',
      category: '分类',
      topic: '主题'
    };

    return titleMap[this.containerType] || '';
  }

  aboutToAppear() {
    this.containerType = router.getParams()["containerType"];
    this.getTitle();
  }

  build() {
    Column() {
      TopBar({ title: this.getTitle(), alpha: 1, backButton: false })
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