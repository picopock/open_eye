import router from '@ohos.router';
import RoutePath from '../route/Path';

@Entry
@Component
struct Splash {
  @State message: string = 'Hello World'

  aboutToAppear() {
    setTimeout(()=> {
    router.replaceUrl({url: RoutePath.Main});
    }, 3000);
  }

  build() {
    Stack() {
      Image($r("app.media.landing_image"))
        .objectFit(ImageFit.Contain)
    }
      .width('100%')
      .height('100%')
      .backgroundColor("#FFFFFF")
      .alignContent(Alignment.Center)
  }
}