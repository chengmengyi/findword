import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value2_utils.dart';

class CongratulationC extends BaseC{
  Function()? dismiss;
  var addNum=Value2Utils.instance.getLevelAddNum();

  @override
  void onInit() {
    super.onInit();
    var add = RoutersUtils.getParams()["addNum"];
    if(null!=add){
      addNum=add;
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 3000),(){
      RoutersUtils.off();
      UserInfoUtils.instance.updateUserMoney(addNum);
      dismiss?.call();
    });
  }
}