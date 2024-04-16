import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';

class WordsRightC extends BaseC{
  clickSure(Function() click){
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserCoinNum(100);
    click.call();
  }
}