
import router from '@ohos.router';
import { RoutePath } from '../../../../../../route/Path';
import type { FocusItem as IFocusItem, FocusItemDataItem } from '../../../../../../types/focus';

@Component
export default struct FocusItem {
  private data: IFocusItem;

  build() {
    Column() {
      Row() {
        Image(this.data.data.header.icon)
          .width(50)
          .height(50)
          .borderRadius(25);

        Column(){
          Text(this.data.data.header.title)
            .fontSize('15fp')
            .fontColor('#333')
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis});

          Text(this.data.data.header.description)
            .fontSize('13fp')
            .fontColor('#999')
            .margin({ top: 5 })
            .maxLines(1)
            .textOverflow({overflow: TextOverflow.Ellipsis});
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .flexGrow(1)
        .margin({ left: 5 });
      }
      .width('100%')
      .height(60)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 5, right: 5 });

      List({ space: 10 }){
        ForEach(this.data.data.itemList, (item: FocusItemDataItem, index: number) => {
          ListItem() {
            Stack() {
              Image(item.data?.cover.feed)
                .width("100%")
                .height("100%")
                .borderRadius(10)
                .alt($r('app.media.back_placeholder'));
              Text(item.data?.category)
                .width(45)
                .height(20)
                .fontColor($r('app.color.color_white'))
                .fontSize('12fp')
                .backgroundColor($r('app.color.color_red'))
                .borderRadius({ topLeft: 10, bottomRight: 10 })
                .textAlign(TextAlign.Center)
                .position({ x: 0, y: 0 });
            }
            .width(220)
            .height(130);
          }
          .onClick(() => {
            router.pushUrl({ url: RoutePath.Detail, params: { id: item.data.id, playUrl: item.data.playUrl } });
          })
        });
      }
      .listDirection(Axis.Horizontal)
      .width('100%')
      .height(130);
    };
  }
}