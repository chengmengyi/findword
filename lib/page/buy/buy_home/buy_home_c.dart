import 'dart:async';
import 'package:adjust_sdk/adjust.dart';
import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/page/buy/cash_child/cash_child_p.dart';
import 'package:findword/page/buy/word_child/word_child_p.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/notification_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class BuyHomeC extends BaseC with WidgetsBindingObserver{
  var showIndex=0,_openLaunchPage=false;
  List<Widget> pageList=[WordChildP(),CashChildP()];
  List<String> iconList=["tab_word","tab_cash"];
  Timer? _bgTimer;

  @override
  bool initEvent() => true;

  @override
  void onInit() {
    super.onInit();
    buyHomeShowing=true;
    WidgetsBinding.instance.addObserver(this);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_word_page);
    NotificationUtils.instance.registerNotifications();

    Future.delayed(const Duration(milliseconds: 1000),(){
      GuideUtils.instance.newUserGuide();
      // _receiveNotification();
    });
  }

  clickTab(index){
    if(index==showIndex){
      return;
    }
    showIndex=index;
    update(["home"]);
    EventBean(eventName: EventName.showOrHideCash,boolValue: showIndex==0).sendEvent();
  }

  clickSet()async{
    RoutersUtils.toPage(name: RoutersName.set);
  }

  _receiveNotification(){
    if(!GuideUtils.instance.getGuideStepComplete()){
      return;
    }
    var notificationId = RoutersUtils.getParams()["NotificationId"];
    if(notificationId==NotificationsId.sign){
      RoutersUtils.showDialog(child: SignD());
    }
  }

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.showCheckInGuide:
        clickTab(1);
        break;
      case EventName.showWordBubbleGuide:
      case EventName.showOldUserAnswerTips:
      case EventName.showAnswerTips:
        clickTab(0);
        break;
      case EventName.updateHomeIndex:
        var intValue = eventBean.intValue;
        if(null!=intValue){
          clickTab(intValue);
        }
        break;
      default:

        break;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch(state){
      case AppLifecycleState.resumed:
        Adjust.onResume();
        TbaUtils.instance.uploadSessionEvent();
        _checkOpenLaunchPage();
        break;
      case AppLifecycleState.paused:
        Adjust.onPause();
        TbaUtils.instance.uploadAppPoint(
            appPoint: AppPoint.fw_session_back,
            params: {
              "pak_version":FlutterCheckAdjustCloak.instance.getUserType()?1:0
            });
        _checkBgTimer();
        break;
      default:

        break;
    }
  }

  _checkBgTimer(){
    _bgTimer=Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      timer.cancel();
      _openLaunchPage=true;
    });
  }

  _checkOpenLaunchPage(){
    _bgTimer?.cancel();
    Future.delayed(const Duration(milliseconds: 200),(){
      if(FlutterMaxAd.instance.fullAdShowing()||clickNotification||GuideUtils.instance.overlayShowing()){
        _openLaunchPage=false;
        return;
      }
      if(_openLaunchPage){
        RoutersUtils.toPage(name: RoutersName.launch,map: {"fromHome":true});
        _openLaunchPage=false;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    buyHomeShowing=false;
    WidgetsBinding.instance.removeObserver(this);
  }
}