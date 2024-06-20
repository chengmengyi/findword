import 'package:decimal/decimal.dart';
import 'package:findword/base/base_c.dart';
import 'package:findword/enums/get_money_from.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value2_utils.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';

class GetMoneyC extends BaseC{
  GetMoneyFrom getMoneyFrom=GetMoneyFrom.other;
  var addNum=Value2Utils.instance.getLevelAddNum();

  @override
  void onInit() {
    super.onInit();
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop);
    getMoneyFrom=RoutersUtils.getParams()["getMoneyFrom"];
  }

  getDouble()=>(Decimal.parse("$addNum")*Decimal.parse("2")).toDouble();

  double getMoreToMoney(){
    var a = Decimal.parse(UserInfoUtils.instance.userMoney.toString());
    var b = Decimal.parse("${Value2Utils.instance.getCashList().first}");
    var d = (b-a).toDouble();
    if(d<=0){
      return 0.0;
    }
    return d;
  }

  clickDouble(Function() dismissDialog){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop_c);
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: getMoneyFrom==GetMoneyFrom.words?AdPosId.fw_word_rv:AdPosId.fw_wheel_rv,
        adFormat: AdFomat.REWARD,
        adShowListener: AdShowListener(
          onAdHidden: (ad){
            RoutersUtils.off();
            UserInfoUtils.instance.updateUserMoney(getDouble());
            dismissDialog.call();
          },
        )
    );
  }

  clickSingle(Function() dismissDialog){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop_continue);
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserMoney(addNum);
    dismissDialog.call();
    AdUtils.instance.updateGetMoneyCloseNum();
  }
}