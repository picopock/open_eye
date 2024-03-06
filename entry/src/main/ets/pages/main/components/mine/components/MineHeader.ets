@Component
export struct MineHeader {
  build() {
    Column() {
      Image($r('app.media.default_avatar'))
        .alt('avatar')
        .width(70)
        .height(70)
        .borderRadius(35);

      Text("Harmony-开眼App")
        .fontSize('16fp')
        .fontColor($r('app.color.color_white'))
        .margin({ top: 10 });
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height(248)
    .backgroundImage($r('app.media.back_mine'));
  }
}