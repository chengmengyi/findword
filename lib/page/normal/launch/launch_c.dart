import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/notification_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class LaunchC extends BaseC with WidgetsBindingObserver{
  var progress=0.0,_count=0,_totalCount=200,_onResume=true;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    launchPageShowing=true;
    WidgetsBinding.instance.addObserver(this);
    if(FlutterCheckAdjustCloak.instance.getUserType()){
      FlutterMaxAd.instance.loadAdByType(AdType.open);
    }
    _receiveNotification();
  }

  @override
  void onReady() {
    super.onReady();
    _startProgressTimer();
  }

  _startProgressTimer(){
    _timer=Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if(_onResume){
        _count++;
        progress=_count/_totalCount;
        update(["progress"]);
        _checkAd();
        if(_count>=_totalCount){
          timer.cancel();
          _timeEnd();
        }
      }
    });
  }

  _checkAd()async{
    if(!FlutterCheckAdjustCloak.instance.getUserType()||!FlutterMaxAd.instance.checkHasCache(AdType.open)||_count<60){
      return;
    }
    _stopTimer();
    TbaUtils.instance.uploadAdPoint(adPoint: AdPoint.ad_chance);
    FlutterMaxAd.instance.showAd(
        adType: AdType.open,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {
            },
            showAdFail: (MaxAd? ad, MaxError? error) {
              _timeEnd();
            },
            onAdHidden: (MaxAd? ad) {
              _timeEnd();
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {
              TbaUtils.instance.uploadAdEvent(ad: ad, info: maxAdInfoBean, adPosId: AdPosId.fw_open, adFormat: AdFomat.INT);
            })
    );
  }

  _timeEnd(){
    if(RoutersUtils.getParams()["fromHome"]==true){
      RoutersUtils.off();
      return;
    }
    var type = FlutterCheckAdjustCloak.instance.checkType();
    RoutersUtils.offAllNamed(name: type?RoutersName.buyHome:RoutersName.home);
  }

  _receiveNotification(){
    Future.delayed(const Duration(milliseconds: 1000),(){
      var notificationId = RoutersUtils.getParams()["NotificationId"];
      if(null==notificationId&&didNotificationLaunchApp!=-1){
        notificationId=didNotificationLaunchApp;
      }
      if(null!=notificationId&&notificationId>0){
        switch(notificationId){
          case NotificationsId.regular:
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_fix_inform_c);
            break;
          case NotificationsId.sign:
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_sign_inform_c);
            break;
          case NotificationsId.upgrade:
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_task_inform_c);
            break;
          case NotificationsId.paypal:
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_paypel_inform_c);
            break;
        }
        if(buyHomeShowing){
          RoutersUtils.off();
        }else{
          RoutersUtils.offAllNamed(name: RoutersName.buyHome,map: {"NotificationId":notificationId});
        }
        didNotificationLaunchApp=-1;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        _onResume=true;
        break;
      case AppLifecycleState.paused:
        _onResume=false;
        break;
      default:

        break;
    }
  }

  @override
  void onClose() {
    launchPageShowing=false;
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
    super.onClose();
  }

  _stopTimer(){
    _timer?.cancel();
    _timer=null;
  }
}