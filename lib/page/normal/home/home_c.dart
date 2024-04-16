import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/words/words_enum.dart';

class HomeC extends BaseC{

  toPlay(WordsEnum wordsEnum){
    RoutersUtils.toPage(
      name: RoutersName.play,
      map: {"wordsEnum":wordsEnum}
    );
  }

  toSet(){
    RoutersUtils.toPage(name: RoutersName.set);
  }
}