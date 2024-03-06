
import { TopBar } from '../../../../components/Index';

@Component
export default struct Index {
  @State message: string = 'Hot Page'

  build() {
    Column() {
      TopBar({title: "热门", alpha: 1, backButton: false, isSubBar: false })
        .align(Alignment.TopStart)
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .height('100%');
  }
}