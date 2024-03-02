@Component
export struct SkeletonItem {
  build() {
    Column() {
      Image($r('app.media.back_placeholder'))
        .width('100%')
        .height('200vp')
        .borderRadius('5vp').backgroundColor('#f00');

      Row()
        .width('90%')
        .height('25vp')
        .margin({top: '10vp'})
        .backgroundColor($r('app.color.color_f5f5f5'));

      Row()
        .width('70%')
        .height('25vp')
        .margin({top: '10vp'})
        .backgroundColor($r('app.color.color_f5f5f5'));
    }.alignItems(HorizontalAlign.Start);
  }
}

@Component
export struct Skeleton {
  @Prop count: number
  @State dataList: string[] = [];

  aboutToAppear() {
    this.dataList.push(...Array.from({length: this.count}, () => ''));
  }

  build() {
    List({space: 12}) {
      ForEach(this.dataList, () => {
        ListItem() {
          SkeletonItem();
        }
      })
    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor($r('app.color.color_white'));
  }
}