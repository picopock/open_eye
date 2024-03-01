import Home from './components/home/Index';
import Find from './components/find/Index';
import Hot from './components/hot/Index';
import Mine from './components/mine/Index';
import { LoadingDialog } from '../../components/Index';

import emitter from '@ohos.events.emitter';

import EventIds from '../../events/ids';
import {loadingEvent} from '../../events/loading';

export type ImageResource = string | PixelMap | Resource;
export class TabItem {
  index: number;
  title: string;
  originImage: ImageResource;
  activeImage: ImageResource;
}

@Entry
@Component
struct Main {
  @State activeIndex: number = 0;
  @State tabs: TabItem[] = [
    {index: 0, title: '首页', originImage: $r('app.media.icon_tab_home'), activeImage: $r('app.media.icon_tab_home_active')},
    {index: 1, title: '发现', originImage: $r('app.media.icon_tab_find'), activeImage: $r('app.media.icon_tab_find_active')},
    {index: 2, title: '热门', originImage: $r('app.media.icon_tab_hot'), activeImage: $r('app.media.icon_tab_hot_active')},
    {index: 3, title: '我的', originImage: $r('app.media.icon_tab_mine'), activeImage: $r('app.media.icon_tab_mine_active')},
  ];
  @State loadingTips: string = '加载中...';
  @State showLoading: boolean = false;

  // 全局loading
  private loadingDialogController: CustomDialogController = new CustomDialogController({
    builder: LoadingDialog({ loadingTips: this.loadingTips }),
    autoCancel: false,
    gridCount: 2,
    cancel: () => {
      this.showLoading = false;
    }
  });

  aboutToAppear() {
    emitter.on(loadingEvent, (evt) => {
      const {showLoading, loadingTips} = evt.data
      if(showLoading && !this.showLoading) {
        this.showLoading = true;
        this.loadingTips =loadingTips;
        this.loadingDialogController.open();
      } else if(!showLoading) {
        this.loadingDialogController.close();
        this.showLoading = false;
      }
    })
  }

  aboutToDisappear() {
    this.loadingDialogController = null;
    emitter.off(EventIds.LOADING_DIALOG_EVENT);
  }

  build() {
    Tabs({
      barPosition: BarPosition.End,
      index: this.activeIndex
    }) {
      TabContent() {
        Home()
      }.tabBar(this.TabsBarItem(this.tabs[0]))

      TabContent() {
        Find()
      }.tabBar(this.TabsBarItem(this.tabs[1]))

      TabContent() {
        Hot()
      }.tabBar(this.TabsBarItem(this.tabs[2]))

      TabContent() {
        Mine()
      }.tabBar(this.TabsBarItem(this.tabs[3]))
    }
    .width('100%')
    .height('100%')
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barWidth('100%')
    .barHeight($r('app.float.tabs_bar_height'))
    .animationDuration(200)
    .scrollable(false)
    .onChange((index: number) => {
      this.activeIndex = index;
    });
  }

  @Builder TabsBarItem(item: TabItem) {
    Column() {
      Image(this.activeIndex === item.index ? item.activeImage : item.originImage)
        .width($r('app.float.tabs_bar_item_image_size'))
        .height($r('app.float.tabs_bar_item_image_size'));
      Text(item.title)
        .width('100%')
        .fontSize($r('app.float.tabs_bar_item_text_font_size'))
        .fontWeight(500)
        .fontColor(this.activeIndex === item.index  ? $r('app.color.color_red') : Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({top: '6vp', bottom: '8vp'});
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r("app.color.color_f5f5f5"));
  }
}