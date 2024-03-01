import window from '@ohos.window';
import router from '@ohos.router';
import {noop} from '../../utils/index';

@Preview
@Component
export struct TopBar {
  @Prop title: string;
  @Prop alpha: number;
  @Prop backButton: boolean;
  // @Prop onBackClick: Function;

  @State statusBarHeight: number = 0;

  setSystemStatusBar() {
    const context = getContext(this);

    window.getLastWindow(context, (err, lastWindow) => {
      const avoidArea = lastWindow.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      this.statusBarHeight = /* avoidArea.topRect.height */ 80;

      lastWindow.setWindowSystemBarProperties({
        statusBarColor: "#ffffff",
        statusBarContentColor: "#ffffff",
        isStatusBarLightIcon: true
      }, (err, result) => {
        if(err.code === 0) {
          console.debug('状态栏设置成功');
        } else {
          console.debug(`状态栏设置失败： ${err.message}`);
        }
      })
    })
  }

  aboutToAppear(){
    this.setSystemStatusBar();
  }

  build() {
    Column() {
      Blank()
        .backgroundColor($r('app.color.color_red'))
        .opacity(this.alpha);
      Stack({alignContent: Alignment.Start}) {
        Row()
          .width('100%')
          .height('50vp')
          .backgroundColor($r("app.color.color_red"))
          .opacity(this.alpha);

        Flex({direction: FlexDirection.Row, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center}) {
          Text(this.title)
            .fontSize('16fp')
            .fontColor($r('app.color.color_white'))
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis});
        }
        .height('50vp')
        .margin({left: '50vp', right: '50vp'});

        if(this.backButton) {
          Row() {
            Image($r('app.media.ic_action_back'))
              .width('16vp')
              .height('16vp')
              .onClick(() => {
                // this.onBackClick();
                router.back();
              })
          }
          .width('50vp')
          .height('50vp')
          .justifyContent(FlexAlign.Center);
        }
      }
    }.height(this.statusBarHeight)
  }
}