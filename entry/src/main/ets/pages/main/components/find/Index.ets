
import { TopBar } from '../../../../components/Index';
import { provideAlias } from '../../../../constants/provideAlias';
import Category from './components/Category';
import Focus from './components/focus/Index';
import Topic from './components/Topic';

export interface TabsItem {
  index: number;
  name: string;
}

@Component
export default struct Index {
  @Provide(/* provideAlias.FindTabsIndex */ 'findTabsIndex') currentTabsIndex: number = 0;

  private tabsController: TabsController = new TabsController();
  private tabs: TabsItem[] = [
    { name: '关注', index: 0 },
    { name: '分类', index: 1 },
    { name: '主题', index: 2 },
  ];

  build() {
    Column() {
      TopBar({title: "发现", alpha: 1, backButton: false })
        .align(Alignment.TopStart);

      Tabs({ barPosition: BarPosition.Start, controller: this.tabsController, index: this.currentTabsIndex }){
        TabContent() {
          Focus();
        }.tabBar(this.tabsBarItem(this.tabs[0]));

        TabContent() {
          Category();
        }.tabBar(this.tabsBarItem(this.tabs[1]));

        TabContent() {
          Topic();
        }.tabBar(this.tabsBarItem(this.tabs[2]));
      }
      .layoutWeight(1)
      .onChange((index: number) => {
        this.currentTabsIndex = index;
      });
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  tabsBarItem(item) {
    Column() {
      Text(item.name)
        .fontSize('15fp')
        .fontWeight(this.currentTabsIndex === item.index ?  500 : 400)
        .fontColor(this.currentTabsIndex === item.index ? $r('app.color.color_white') : $r('app.color.color_f5f5f5'))
        .width('100%')
        .height('100%')
        .textAlign(TextAlign.Center);

      Divider()
        .vertical(false)
        .width('100%')
        .strokeWidth(5)
        .color($r('app.color.color_white'))
        .opacity(this.currentTabsIndex === item.index ? 1 : 0);
    }
    .width('101%')
    .height('100%')
    .padding({ bottom: 5 })
    .backgroundColor($r('app.color.color_red'));
  }
}