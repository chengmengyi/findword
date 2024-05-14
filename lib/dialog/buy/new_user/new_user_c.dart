import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class NewUserC extends BaseC{
  var payIndex=0;
  int addNum=ValueUtils.instance.getMoneyToCoin(60);
  List<String> payList=["pay_p","pay_g","pay_a","pay_w","pay_m","pay_c"];

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_newuser_pop);
  }

  clickPay(index){
    if(payIndex==index){
      return;
    }
    payIndex=index;
    update(["pay_list"]);
    UserInfoUtils.instance.updatePayType(index);
  }

  clickClaim(){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_newuser_pop_c);
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: AdPosId.fw_new_rv,
        adFormat: AdFomat.REWARD,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {  },
            showAdFail: (MaxAd? ad, MaxError? error) {  },
            onAdHidden: (MaxAd? ad) {
              _closeDialog(addNum*2);
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {  }
        )
    );
  }

  clickClose(){
    _closeDialog(addNum);
  }

  _closeDialog(int addNum){
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserCoinNum(addNum);
    GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.checkInGuide);
  }
}