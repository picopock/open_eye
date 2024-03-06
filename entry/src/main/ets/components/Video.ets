@Component
export struct VideoPlayer {
  @Prop @Watch('onPlayUrlChange') url: string;
  @Prop showControls: boolean;
  @Prop isAutoPlay: boolean;

  @State showLoading: boolean = true;

  private controller: VideoController;

  onPlayUrlChange(url: string) {
    this.showLoading = true;
  }

  build() {
    Stack() {
      Video({
        src: this.url,
        controller: this.controller,
      })
      .width('100%')
      .height('100%')
      .autoPlay(this.isAutoPlay)
      .controls(this.showControls)
      .onStart(() => {
        this.showLoading = false;
      })
      .onError(() => {
        this.showLoading = false;
      })
      .onSeeking((e) => {
        this.showLoading = true;
      })
      .onSeeked((e) => {
        this.showLoading = false;
      });

      Image($r('app.media.loading'))
        .width(50)
        .height(50)
        .visibility(this.showLoading ? Visibility.Visible : Visibility.None)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Center);
  }
}