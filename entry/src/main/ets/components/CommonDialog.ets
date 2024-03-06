@Component
struct DialogHeader {
  @Link title: Resource;

  build() {
    Row() {
      Text(this.title)
        .fontSize('16fp')
        .fontColor($r('app.color.color_red'))
        .fontWeight(FontWeight.Bold)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .textOverflow({ overflow: TextOverflow.Ellipsis });
    }
    .width('100%')
    .height('50fp')
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .border({ width: { bottom: 1 }, color: $r('app.color.color_f5f5f5') });
  }
}

@Component
struct DialogFooter {
  @Link leftBtnText: Resource;
  @Link rightBtnText: Resource;

  private onLeftBtnClick: Function;
  private onRightBtnClick: Function;

  build() {
    Row() {
      Text(this.leftBtnText)
        .flexShrink(1)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .visibility(this.leftBtnText ? Visibility.Visible : Visibility.None)
        .onClick(() => {
          this.onLeftBtnClick();
        });

      Divider()
        .color($r('app.color.color_f5f5f5'))
        .vertical(true)
        .visibility((this.rightBtnText && this.leftBtnText) ? Visibility.Visible : Visibility.None);

      Text(this.rightBtnText)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .fontColor($r('app.color.color_red'))
        .visibility(this.rightBtnText ? Visibility.Visible : Visibility.None)
        .onClick(() => {
          this.onRightBtnClick();
        })
    }
    .width("100%")
    .height(50)
    .border({ width: { top: 1 }, color: $r('app.color.color_f5f5f5') });
  }
}

@CustomDialog
export struct CommonDialog {
  //标题
  @Link title: Resource;
  //自定义加载的内容
  @BuilderParam content?: () => void;

  @Link leftBtnText: Resource;
  @Link rightBtnText: Resource;

  //确认按钮回调
  private onLeftClick: () => void
  //取消按钮回调
  private onRightClick: () => void

  //弹窗控制器
  controller: CustomDialogController;

  onLeftBtnClick = () => {
    this.onLeftClick?.();
    this.controller.close();
  }

  onRightBtnClick = () => {
    this.onRightClick?.();
    this.controller.close();
  }

  build() {
    Stack() {
      Column() {
        DialogHeader({ title: $title });

        this.content();

        DialogFooter({ leftBtnText: $leftBtnText, rightBtnText: $rightBtnText, onLeftBtnClick: this.onLeftBtnClick, onRightBtnClick: this.onRightBtnClick });
      }
      .alignItems(HorizontalAlign.Center)
      .backgroundColor($r('app.color.color_white'))
      .border({ radius: 6 });
    }
    .width("100%");
  }
}