import router from '@ohos.router';
import { CommonDialog } from '../../../../../components/CommonDialog';
import { RoutePath } from '../../../../../route/Path';

export interface Info {
  name: string;
  icon: Resource;
  onClick: Function
}

@Component
export struct InfoList {
  @State dialogTitle: Resource = $r('app.string.dialog_about_me');
  @State leftBtnText: string = '确认';
  @State rightBtnText: string = '';

  private dialogController: CustomDialogController = new CustomDialogController({
    builder: CommonDialog({ title: $dialogTitle, content: this.dialogContent, leftBtnText: $leftBtnText, rightBtnText: $rightBtnText })
  });

  private infos: Info[] = [
    { name: '关注', icon: $r('app.media.icon_focus'), onClick: () => { router.pushUrl({ url: RoutePath.Info, params: {"containerType": "focus"} }, router.RouterMode.Standard) } },
    { name: '分类', icon: $r('app.media.icon_type'), onClick: () => { router.pushUrl({ url: RoutePath.Info, params: {"containerType": "category"} }, router.RouterMode.Standard ) } },
    { name: '热门', icon: $r('app.media.icon_topic'), onClick: () => { router.pushUrl({ url: RoutePath.Info, params: {"containerType": "topic"} }, router.RouterMode.Standard) } },
    { name: '关于', icon: $r('app.media.icon_about'), onClick: () => { this.dialogController.open(); } },
  ];

  build() {
    List() {
      ForEach(this.infos, (info, index) => {
        ListItem() {
          this.infoItem(info);
        }
      }, (info) => info.name );
    }
    .width('100%');
  }

  @Builder
  infoItem(info: Info) {
    Row() {
      Image(info.icon)
        .width('25vp')
        .height(25);
      Text(info.name)
        .fontSize('15fp')
        .fontColor('#333')
        .margin({ left: 10 });
    }
    .width('100%')
    .height(50)
    .alignItems(VerticalAlign.Center)
    .padding({ left: 10 })
    .border({ width:  { bottom: 1 }, color: '#f5f5f5' })
    .onClick(() => {
      info.onClick();
    });
  }

  @Builder
  dialogContent() {
    Text($r('app.string.project_desc'))
      .fontSize('15fp')
      .fontColor('#555')
      .textAlign(TextAlign.Start)
      .padding('20vp');
  }
}