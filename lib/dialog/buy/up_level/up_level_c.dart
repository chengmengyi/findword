import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class UpLevelC extends BaseC{
  Timer? _timer;
  var countDownTime="";
  var addNum=ValueUtils.instance.getCurrentAddNum();

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
    FlutterMaxAd.instance.loadAdByType(AdType.inter);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_level_pop);
  }

  @override
  void onReady() {
    super.onReady();
    _timer=Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      countDownTime=ValueUtils.instance.getBoxCountDownStr();
      update(["time"]);
    });
  }

  clickDouble(Function() closeDialog){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_level_pop_c);
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: AdPosId.fw_wordlevelup_rv,
        adFormat: AdFomat.REWARD,
        adShowListener: AdShowListener(
            showAdFail: (MaxAd? ad, MaxError? error) {

            },
            onAdHidden: (MaxAd? ad) {
              clickClose(closeDialog,num: addNum*2);
            },
        )
    );
  }

  clickClose(Function() closeDialog,{int? num,bool close=false}){
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserCoinNum(num??addNum);
    closeDialog.call();
    if(close){
      AdUtils.instance.updateUpLevelCloseNum();
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_level_pop_continue);
    }
  }

  double getLevelPro(){
    var pro = (UserInfoUtils.instance.userLevel%5+1)/5;
    if(pro>=1.0){
      return 1.0;
    }else if(pro<=0.0){
      return 0.0;
    }else {
      return pro;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    _timer=null;
    super.onClose();
  }
}