import { noop } from '../../utils/noop';

export enum LoadingStatus {
  Loading = 'loading',
  SUCCESS = 'success',
  ERROR = 'error',
  NETWORK_ERROR = 'network_error'
}

@Component
export struct WithPlaceholder {
  @Prop loadingStatus: string;

  @BuilderParam children: () => void;

  enableLoading: boolean = false;
  onRetry: Function = noop;

  errorImage = () => {
    const imageMap: Record<LoadingStatus, string | PixelMap | Resource> = {
      [LoadingStatus.Loading]: $r('app.media.loading'),
      [LoadingStatus.ERROR]: $r('app.media.common_empty_content'),
      [LoadingStatus.NETWORK_ERROR]: $r('app.media.timeout'),
      [LoadingStatus.SUCCESS]: $r('app.media.common_empty_content')
    }

    return imageMap[this.loadingStatus] || $r('app.media.loading');
  }

  errorText = (): string => {
    const textMap: Record<LoadingStatus, Resource> = {
      [LoadingStatus.Loading]: $r('app.string.loading'),
      [LoadingStatus.ERROR]: $r('app.string.load_error'),
      [LoadingStatus.NETWORK_ERROR]: $r('app.string.load_network_error'),
      [LoadingStatus.SUCCESS]: $r('app.string.loading'),
    }

    return textMap[this.loadingStatus] || '';
  }

  build() {
    if(this.loadingStatus === LoadingStatus.SUCCESS || (!this.enableLoading && this.loadingStatus === LoadingStatus.Loading)) {
      this.children();
    } else if ([LoadingStatus.ERROR, LoadingStatus.NETWORK_ERROR].includes(this.loadingStatus as LoadingStatus)) {
      this.ErrorContent();
    } else if(this.enableLoading && this.loadingStatus === LoadingStatus.Loading) {
      this.ErrorContent();
    }
  }

  @Builder
  ErrorContent() {
    Column() {
      Image(this.errorImage())
        .width('100vp')
        .height('100vp');
      Text(this.errorText())
        .fontSize('15fp')
        .fontColor($r('app.color.color_666'))
        .margin({top: '10vp', bottom: '10vp'});

      if([LoadingStatus.ERROR, LoadingStatus.NETWORK_ERROR].includes(this.loadingStatus as LoadingStatus)) {
        Button($r('app.string.press_retry'))
          .width('120vp')
          .height('35vp')
          .fontColor($r('app.color.color_white'))
          .backgroundColor($r('app.color.color_red'))
          .onClick(() => {
            this.onRetry();
          })
      }
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }
}