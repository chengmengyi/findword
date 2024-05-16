import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/cash/cash_d.dart';
import 'package:findword/dialog/buy/no_money_dialog/no_money_d.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/dialog/buy/task_incomplete/task_incomplete_d.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/checkin_guide_overlay.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter/material.dart';

class CashChildC extends BaseC{
  var payTypeIndex=0,cashNumIndex=0;
  GlobalKey checkInGlobalKey=GlobalKey();
  List<int> cashNumList=ValueUtils.instance.getCashList();
  List<String> payTypeList=["pay_type1","pay_type2","pay_type3","pay_type4","pay_type5","pay_type6"];

  @override
  bool initEvent() => true;

  clickPayType(index){
    if(payTypeIndex==index){
      return;
    }
    payTypeIndex=index;
    update(["page"]);
  }

  clickCashNum(index){
    if(cashNumIndex!=index){
      cashNumIndex=index;
      update(["page"]);
    }
  }

  clickTaskItem(int index){
    if(index==0){
      if(SignUtils.instance.todaySign){
        return;
      }
      RoutersUtils.showDialog(child: SignD());
    }else{
      EventBean(eventName: EventName.updateHomeIndex,intValue: 0).sendEvent();
    }
  }

  clickWithdraw(){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.cash_withdraw_c);
    var chooseMoney = cashNumList[cashNumIndex];
    var chooseCoin = ValueUtils.instance.getMoneyToCoin(chooseMoney);
    var userCoinNum = UserInfoUtils.instance.userCoinNum;
    if(userCoinNum<chooseCoin){
      RoutersUtils.showDialog(child: NoMoneyD());
    }else{
      if(SignUtils.instance.signDays<7){
        if(SignUtils.instance.todaySign){
          RoutersUtils.showDialog(child: NoMoneyD());
        }else{
          RoutersUtils.showDialog(
              child: TaskIncompleteD(
                money: chooseMoney,
                signTask: true,
              )
          );
        }
        return;
      }
      if(UserInfoUtils.instance.bubbleNum<10){
        RoutersUtils.showDialog(
            child: TaskIncompleteD(
              money: chooseMoney,
              signTask: false,
            )
        );
        return;
      }
      RoutersUtils.showDialog(child: CashD(money: chooseMoney,));
    }
  }

  double getCashPro(int num){
    var pro = UserInfoUtils.instance.userCoinNum/ValueUtils.instance.getMoneyToCoin(num);
    if(pro>=1.0){
      return 1.0;
    }else if(pro<=0){
      return 0.0;
    }else{
      return pro;
    }
  }

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.showCheckInGuide:
        _showCheckInGuide();
        break;
      case EventName.updatePayType:
      case EventName.updateBubbleNum:
      case EventName.signSuccess:
        payTypeIndex=UserInfoUtils.instance.payType;
        update(["page"]);
        break;
      case EventName.updateUserCoin:
        update(["money"]);
        break;
      default:

        break;
    }
  }

  _showCheckInGuide(){
    if(null!=context){
      var box = checkInGlobalKey.currentContext!.findRenderObject()! as RenderBox;
      var offset = box.localToGlobal(Offset.zero);
      GuideUtils.instance.showOverlay(
          context: context!,
          widget: CheckInGuideOverlay(
              offset: offset,
              click: (){
                GuideUtils.instance.hideOverlay();
                GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.signDialog);
              })
      );
    }
  }
}