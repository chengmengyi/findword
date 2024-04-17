import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';

class TimeOutC extends BaseC{
  clickBtn(Function() click){
    RoutersUtils.off();
    if(UserInfoUtils.instance.userTipsNum<=0){
      "today‘s hint chance has been used up".showToast();
    }else{
      click.call();
    }
  }
}