import 'package:decimal/decimal.dart';
import 'package:findword/enums/pay_type.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/utils.dart';

class UserInfoUtils{
  factory UserInfoUtils()=>_getInstance();
  static UserInfoUtils get instance => _getInstance();
  static UserInfoUtils? _instance;
  static UserInfoUtils _getInstance(){
    _instance??=UserInfoUtils._internal();
    return _instance!;
  }

  var userCoinNum=0,userHeartNum=10,userTipsNum=3,userLevel=1,
      payType=PayType.paypal,bubbleNum=0,wheelNum=0,todayShowedReviewDialogNum=0,
      hasCommentApp=false,userMoney=0.0,wheelChanceProgress=1;

  UserInfoUtils._internal(){
    userCoinNum=StorageUtils.instance.getValue<int>(StorageKey.userCoinNum)??0;
    userHeartNum=getTodayNum(key: StorageKey.userHeartNum,defaultNum: 10);
    userTipsNum=getTodayNum(key: StorageKey.userTipsNum,defaultNum: 3);
    userLevel=StorageUtils.instance.getValue<int>(StorageKey.userLevel)??1;
    bubbleNum=StorageUtils.instance.getValue<int>(StorageKey.bubbleNum)??0;
    payType=StorageUtils.instance.getValue<int>(StorageKey.payType)??PayType.paypal;
    todayShowedReviewDialogNum=getTodayNum(key: StorageKey.lastShowReviewDialogTimer,defaultNum: 0);
    hasCommentApp=StorageUtils.instance.getValue<bool>(StorageKey.hasCommentApp)??false;
    userMoney=StorageUtils.instance.getValue<double>(StorageKey.userMoney)??0.0;
    wheelChanceProgress=StorageUtils.instance.getValue<int>(StorageKey.wheelChanceProgress)??1;
  }

  updateUserCoinNum(int addNum){
    userCoinNum+=addNum;
    StorageUtils.instance.writeValue(StorageKey.userCoinNum, userCoinNum);
    if(addNum>0){
      EventBean(eventName: EventName.playMoneyLottie).sendEvent();
      return;
    }
    EventBean(eventName: EventName.updateUserCoin).sendEvent();
  }

  updateUserMoney(double num){
    var a = Decimal.parse(userMoney.toString());
    var b = Decimal.parse(num.toString());
    userMoney=(a+b).toDouble();
    StorageUtils.instance.writeValue(StorageKey.userMoney, userMoney);
    EventBean(eventName: EventName.playMoneyLottie).sendEvent();
  }

  updateTipsNum(int addNum){
    // if(!GuideUtils.instance.getGuideStepComplete()){
    //   return;
    // }
    // userTipsNum+=addNum;
    // StorageUtils.instance.writeValue(StorageKey.userTipsNum, "${getTodayTimer()}_$userTipsNum");
    // EventBean(eventName: EventName.updateTipsNum).sendEvent();
  }
  updateHeartNum(int addNum){
    userHeartNum+=addNum;
    StorageUtils.instance.writeValue(StorageKey.userHeartNum, "${getTodayTimer()}_$userHeartNum");
    EventBean(eventName: EventName.updateUserHeartNum).sendEvent();
  }
  updateUserLevel(){
    userLevel++;
    StorageUtils.instance.writeValue(StorageKey.userLevel, userLevel);
    if(wheelChanceProgress<5){
      wheelChanceProgress++;
      StorageUtils.instance.writeValue(StorageKey.wheelChanceProgress, wheelChanceProgress);
    }
    EventBean(eventName: EventName.updateUserLevel).sendEvent();
  }
  resetWheelProgress(){
    wheelChanceProgress=1;
    StorageUtils.instance.writeValue(StorageKey.wheelChanceProgress, wheelChanceProgress);
    EventBean(eventName: EventName.updateUserLevel).sendEvent();
  }
  updatePayType(int payType){
    this.payType=payType;
    StorageUtils.instance.writeValue(StorageKey.payType, payType);
    EventBean(eventName: EventName.updatePayType).sendEvent();
  }

  updateBubbleNum(int num){
    bubbleNum+=num;
    StorageUtils.instance.writeValue(StorageKey.bubbleNum, bubbleNum);
    EventBean(eventName: EventName.updateBubbleNum).sendEvent();
  }

  updateWheelNum(int num){
    wheelNum+=num;
    EventBean(eventName: EventName.updateWheelChance).sendEvent();
  }

  updateShowReviewDialogNum(){
    todayShowedReviewDialogNum++;
    StorageUtils.instance.writeValue(StorageKey.lastShowReviewDialogTimer, "${getTodayTimer()}_$todayShowedReviewDialogNum");
  }
  updateHasCommentApp(){
    hasCommentApp=true;
    StorageUtils.instance.writeValue(StorageKey.hasCommentApp, true);
  }
}