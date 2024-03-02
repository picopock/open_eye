import { BannerData, IssueItem as IIssueItem, VideoData } from '../../../../../types/home';
import { imageUrlFormat } from '../../../../../utils/url';

@Component
export struct IssueItem {
  private data: IIssueItem;
  private swiperController: SwiperController = new SwiperController();

  build() {
    if(this.data.type === 'banner') {
      this.renderBanner(this.data);
    } else {
      this.renderIssue(this.data);
    }
  }

  @Builder
  renderBanner(data: IIssueItem) {
    Swiper(this.swiperController) {
      ForEach(data.bannerList, (item: IIssueItem) => {
        Image(imageUrlFormat((item.data as BannerData)?.image))
          .width('100%')
          .height('200vp')
          .alt($r('app.media.back_placeholder'))
          .borderRadius('5vp');
      }, (item, index) => String(index));
    }
    .cachedCount(3)
    .index(0)
    .autoPlay(true)
    .interval(3000)
    .indicator(true)
    .loop(true)
    .duration(2000)
    .itemSpace(5)
    .curve(Curve.Linear)
    .indicatorStyle({ color: $r('app.color.color_red'), selectedColor: $r('app.color.color_red') });
  }

  @Builder
  renderIssue(data: IIssueItem) {
    Column() {
      Stack() {
        Image((data?.data as VideoData)?.cover?.feed)
          .alt($r('app.media.back_placeholder'))
          .width("100%")
          .height("100%");
        Text((data?.data as VideoData)?.category)
          .width('45vp')
          .height('20vp')
          .fontSize('12fp')
          .fontColor($r('app.color.color_white'))
          .textAlign(TextAlign.Center)
          .backgroundColor($r('app.color.color_red'))
          .borderRadius({ bottomRight: '10vp' });
      }
      .width("100%")
      .height('210vp')
      .alignContent(Alignment.TopStart)

      Row() {
        Image((data?.data as VideoData)?.author?.icon)
          .width('50vp')
          .height('50vp')
          .borderRadius('25vp');
        Column() {
          Text((data?.data as VideoData)?.author?.name)
            .fontSize('15fp')
            .fontColor('#333');
          Text((data?.data as VideoData)?.author?.name)
            .fontSize('13fp')
            .fontColor('#999')
            .margin({ top: '5vp' });
        }
        .alignItems(HorizontalAlign.Start)
        .flexGrow(1)
        .margin({ left: '5vp' })
        .justifyContent(FlexAlign.Center);
      }
      .width("100%")
      .height('60vp')
      .alignItems(VerticalAlign.Center)
      .padding({ left: '5vp', right: '5vp' })
      .backgroundColor($r('app.color.color_f5f5f5'));
    }.borderRadius('10vp')
    .clip(true);
  }
}