import 'package:findword/base/base_c.dart';
import 'package:findword/page/buy/cash_child/cash_child_p.dart';
import 'package:findword/page/buy/word_child/word_child_p.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/words/words_enum.dart';
import 'package:flutter/material.dart';

class BuyHomeC extends BaseC{
  var showIndex=0;
  List<Widget> pageList=[WordChildP(),CashChildP()];
  List<String> iconList=["tab_word","tab_cash"];

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 500),(){
      GuideUtils.instance.newUserGuide();
    });
  }

  clickTab(index){
    if(index==showIndex){
      return;
    }
    showIndex=index;
    update(["home"]);
  }

  clickSet()async{
    // RoutersUtils.toPage(name: RoutersName.set);
  }

  @override
  bool initEvent() => true;

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.showCheckInGuide:
        if(showIndex!=1){
          showIndex=1;
          update(["home"]);
        }
        break;
      case EventName.showWordBubbleGuide:
      case EventName.showOldUserAnswerTips:
      case EventName.showAnswerTips:
        if(showIndex!=0){
          showIndex=0;
          update(["home"]);
        }
        break;
      case EventName.updateHomeIndex:
        var intValue = eventBean.intValue;
        if(null!=intValue&&intValue!=showIndex){
          showIndex=intValue;
          update(["home"]);
        }
        break;
      default:

        break;
    }
  }
}