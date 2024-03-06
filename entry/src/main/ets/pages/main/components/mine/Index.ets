import { MineHeader } from './components/MineHeader';
import { InfoList } from './components/InfoList';

@Component
export default struct Index {
  @State message: string = 'Mine Page'

  build() {
    Scroll() {
      Column() {
        MineHeader();
        InfoList();
      }
    };
  }
}