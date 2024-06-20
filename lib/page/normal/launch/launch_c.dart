import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/notification_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class LaunchC extends BaseC with WidgetsBindingObserver{
  var progress=0.0,_count=0,_totalCount=100,_onResume=true;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    launchPageShowing=true;
    WidgetsBinding.instance.addObserver(this);
    FlutterMaxAd.instance.loadAdByType(AdType.inter);
    TbaUtils.instance.uploadSessionEvent();
    _receiveNotification();
    Future((){
      _startProgressTimer();
    });
  }

  _startProgressTimer(){
    _timer=Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if(_onResume){
        _count++;
        progress=_count/_totalCount;
        update(["progress"]);
        _checkAd(false);
        if(_count>=_totalCount){
          FlutterCheckAdjustCloak.instance.checkType();
          _checkAd(true);
        }
      }
    });
  }

  _checkAd(bool end)async{
    var userType = FlutterCheckAdjustCloak.instance.getUserType();
    if(end){
      _stopTimer();
      if(userType){
        if(FlutterMaxAd.instance.checkHasCache(AdType.inter)){
          AdUtils.instance.showOpenAd();
        }else{
          _timeEnd(userType);
        }
      }else{
        _timeEnd(userType);
      }
      return;
    }
    if(userType&&FlutterMaxAd.instance.checkHasCache(AdType.inter)){
      _stopTimer();
      _timeEnd(userType);
      AdUtils.instance.showOpenAd();
    }
  }

  _timeEnd(bool userType){
    if(userType&&buyHomeShowing){
      RoutersUtils.off();
      return;
    }
    RoutersUtils.offAllNamed(name: userType?RoutersName.buyHome:RoutersName.home);
  }

  _receiveNotification(){
    var notificationId = RoutersUtils.getParams()["NotificationId"];
    if(null==notificationId&&didNotificationLaunchApp!=-1){
      notificationId=didNotificationLaunchApp;
    }
    var from="icon";
    if(null!=notificationId&&notificationId>0){
      from="push";
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
      didNotificationLaunchApp=-1;
    }
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_launch_page,params: {"source_from":from});
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