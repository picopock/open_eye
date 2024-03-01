
@CustomDialog
export struct LoadingDialog {
  @Prop loadingTips: string;

  @State rotateAngle: number = 0;

  private controller: CustomDialogController;

  aboutToAppear() {
    this.rotateAngle = 360;
  }

  build() {
    Column() {
      Image($r('app.media.chrysanthemum_loading'))
        .width('50fp')
        .height('50fp')
        .rotate({angle: this.rotateAngle})
        .animation({
          duration: 500,
          iterations: -1,
          curve: Curve.Friction
        });
      Text(this.loadingTips)
        .fontSize('15fp')
        .margin({
          top: '10vp'
        });
    }
    .justifyContent(FlexAlign.Center)
    .width('150fp')
    .height('150fp')
    .backgroundColor($r('app.color.color_white'))
    .borderRadius('5fp');
  }
}