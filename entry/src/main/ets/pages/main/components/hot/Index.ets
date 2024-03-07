
import { TopBar } from '../../../../components/Index';
import { HotTabsIndex } from '../../../../constants/provideAlias';
import Rank from './components/Rank';

export interface TabsItem {
  index: number;
  name: string;
  type: 'weekly'|'monthly'|'historical';
}

@Component
export default struct Index {
  @Provide(HotTabsIndex) hotTabsIndex: number = 0;

  private tabsController: TabsController = new TabsController();
  private tabs: TabsItem[] = [
    { name: '周排行', index: 0, type: 'weekly' },
    { name: '月排行', index: 1, type: 'monthly' },
    { name: '总排行', index: 2, type: 'historical' },
  ];

  build() {
    Column() {
      TopBar({title: "热门", alpha: 1, backButton: false })
        .align(Alignment.TopStart);

      Tabs({ barPosition: BarPosition.Start, controller: this.tabsController, index: this.hotTabsIndex }){
        ForEach(this.tabs, (tab) => {
          TabContent() {
            Rank(tab);
          }.tabBar(this.tabsBarItem(tab));
        }, (tab: TabsItem) => tab.type);
      }
      .layoutWeight(1)
      .onChange((index: number) => {
        this.hotTabsIndex = index;
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
        .fontWeight(this.hotTabsIndex === item.index ?  500 : 400)
        .fontColor(this.hotTabsIndex === item.index ? $r('app.color.color_white') : $r('app.color.color_f5f5f5'))
        .width('100%')
        .height('100%')
        .textAlign(TextAlign.Center);

      Divider()
        .vertical(false)
        .width('100%')
        .strokeWidth(5)
        .color($r('app.color.color_white'))
        .opacity(this.hotTabsIndex === item.index ? 1 : 0);
    }
    .width('101%')
    .height('100%')
    .padding({ bottom: 5 })
    .backgroundColor($r('app.color.color_red'));
  }
}