import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/ad_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';

class UpLevelC extends BaseC{
  Timer? _timer;
  var countDownTime="";
  var addNum=ValueUtils.instance.getCurrentAddNum();

  @override
  void onReady() {
    super.onReady();
    _timer=Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      countDownTime=ValueUtils.instance.getBoxCountDownStr();
      update(["time"]);
    });
  }

  clickDouble(Function() closeDialog){
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {

            },
            showAdFail: (MaxAd? ad, MaxError? error) {

            },
            onAdHidden: (MaxAd? ad) {
              clickClose(closeDialog,num: addNum*2);
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {

            })
    );
  }

  clickClose(Function() closeDialog,{int? num,bool close=false}){
    RoutersUtils.off();
    UserInfoUtils.instance.updateUserCoinNum(num??addNum);
    closeDialog.call();
    if(close){
      AdUtils.instance.updateUpLevelCloseNum();
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