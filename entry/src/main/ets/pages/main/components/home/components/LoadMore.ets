@Component
export struct LoadMore {
  private loadText = "数据加载中，请稍后...";

  build() {
    Row() {
      Text(this.loadText)
        .fontSize('15fp')
        .fontColor('#333');
    }
    .width("100%")
    .height('50vp')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#f8f8f8');
  }
}