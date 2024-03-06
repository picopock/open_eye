
import { TopBar } from '../../../../components/Index';

@Component
export default struct Index {
  @State message: string = 'Mine Page'

  build() {
    Column() {
      TopBar({title: "我的", alpha: 1, backButton: true })
        .align(Alignment.TopStart)
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%');
  }
}