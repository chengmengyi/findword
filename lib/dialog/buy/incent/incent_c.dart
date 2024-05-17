import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class IncentC extends BaseC{
  IncentFrom incentFrom=IncentFrom.other;
  var addNum=ValueUtils.instance.getCurrentAddNum();

  @override
  void onInit() {
    super.onInit();
    incentFrom=RoutersUtils.getParams()["incentFrom"]??IncentFrom.other;
    if(incentFrom==IncentFrom.wheel){
      addNum=ValueUtils.instance.getWheelAddNum();
    }
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop,params: _getAppPointParams());
  }

  clickDouble(Function() closeDialog){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop_c,params: _getAppPointParams());
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: _getAdPosIdByFrom(),
        adFormat: AdFomat.REWARD,
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
    if(clickClaim){
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_double_pop_continue,params: _getAppPointParams());
      if(incentFrom==IncentFrom.wheel){
        AdUtils.instance.updateWheelCloseNum();
      }else if(incentFrom==IncentFrom.answerRightOneWord){
        AdUtils.instance.updateAnswerRightCloseNum();
      }
    }
    closeDialog?.call();
  }

  AdPosId _getAdPosIdByFrom(){
    switch(incentFrom){
      case IncentFrom.answerRightOneWord:return AdPosId.fw_wordright_rv;
      case IncentFrom.wheel:return AdPosId.fw_wheel_rv;
      case IncentFrom.oldUserGuide:return AdPosId.fw_old_checkinx2_rv;
      default: return AdPosId.unknownId;
    }
  }

  Map<String,dynamic>? _getAppPointParams(){
    var type="";
    switch(incentFrom){
      case IncentFrom.oldUserGuide:
        type="old";
        break;
      case IncentFrom.wheel:
        type="wheel";
        break;
      case IncentFrom.answerRightOneWord:
        type="word";
        break;
      case IncentFrom.bubble:
        type="bubble";
        break;
      default:
        type="";
        break;
    }
    if(type.isEmpty){
      return null;
    }
    return {"word_from":type};
  }
}