import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/dialog/buy/no_wheel/no_wheel_d.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class WheelC extends BaseC{

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.inter);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_wheel_pop);
  }

  @override
  bool initEvent() => true;

  @override
  void onReady() {
    super.onReady();
    startWheel();
  }

  startWheel(){
    if(UserInfoUtils.instance.wheelNum<=0){
      RoutersUtils.showDialog(
          child: NoWheelD(
            addChanceCall: (){
              startWheel();
            },
          )
      );
      return;
    }
    EventBean(eventName: EventName.startRotationWheel).sendEvent();
  }

  clickClose(Function() dismissDialog){
    RoutersUtils.off();
    AdUtils.instance.updateWheelCloseNum();
    dismissDialog.call();
  }

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.stopRotationWheel:
        _showAd();
        break;
      case EventName.updateWheelChance:
        update(["wheel_chance"]);
      default:
        break;
    }
  }

  _showAd(){
    UserInfoUtils.instance.updateWheelNum(-1);
    AdUtils.instance.showAd(
        adType: AdType.inter,
        adPosId: AdPosId.fw_wheel_int,
        adFormat: AdFomat.INT,
        adShowListener: AdShowListener(
            showAdFail: (MaxAd? ad, MaxError? error) {  },
            onAdHidden: (MaxAd? ad) {
              showIncentDialog(incentFrom: IncentFrom.wheel, closeDialog: (){});
            },
        )
    );
  }
}