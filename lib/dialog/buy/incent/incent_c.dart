import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/utils/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';

class IncentC extends BaseC{
  IncentFrom incentFrom=IncentFrom.other;
  var addNum=ValueUtils.instance.getCurrentAddNum();

  @override
  void onInit() {
    super.onInit();
    incentFrom=RoutersUtils.getParams()["incentFrom"]??IncentFrom.other;
  }

  clickDouble(Function() closeDialog){
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {

            },
            showAdFail: (MaxAd? ad, MaxError? error) {
              if(incentFrom==IncentFrom.oldUserGuide){
                clickClose(closeDialog: closeDialog);
              }
            },
            onAdHidden: (MaxAd? ad) {
              clickClose(num: addNum*2,closeDialog: closeDialog);
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {

            })
    );
  }

  clickClose({int? num,Function()? closeDialog,bool clickClaim=false}){
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserCoinNum(num??addNum);
    if(incentFrom==IncentFrom.oldUserGuide){
      GuideUtils.instance.updateOldUserGuide(OldUserGuideStep.answerTips);
    }
    closeDialog?.call();
    if(clickClaim){
      if(incentFrom==IncentFrom.wheel){
        AdUtils.instance.updateWheelCloseNum();
      }
    }
  }
}