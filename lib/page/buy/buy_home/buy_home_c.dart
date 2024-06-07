import 'dart:async';
import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
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
import 'package:flutter/material.dart';

class BuyHomeC extends BaseC{
  var showIndex=0;
  List<Widget> pageList=[WordChildP(),CashChildP()];
  List<String> iconList=["tab_word","tab_cash"];

  @override
  bool initEvent() => true;

  @override
  void onInit() {
    super.onInit();
    buyHomeShowing=true;
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_word_page);
    NotificationUtils.instance.registerNotifications();

    Future.delayed(const Duration(milliseconds: 1000),(){
      GuideUtils.instance.newUserGuide();
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
  void onClose() {
    super.onClose();
    buyHomeShowing=false;
  }
}