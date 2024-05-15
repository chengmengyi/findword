import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/notification_utils.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';

class SignUtils{
  factory SignUtils()=>_getInstance();
  static SignUtils get instance => _getInstance();
  static SignUtils? _instance;
  static SignUtils _getInstance(){
    _instance??=SignUtils._internal();
    return _instance!;
  }

  var signDays=0,todaySign=false;
  SignUtils._internal(){
    //2022-02-02_0
    var s = StorageUtils.instance.getValue<String>(StorageKey.sign)??"";
    try{
      if(s.isNotEmpty){
        var split = s.split("_");
        todaySign=split.first==getTodayTimer();
        signDays=split.last.toInt();
      }
    }catch(e){

    }
  }

  sign(int addNum){
    signDays++;
    todaySign=true;
    StorageUtils.instance.writeValue(StorageKey.sign, "${getTodayTimer()}_$signDays");
    UserInfoUtils.instance.updateUserCoinNum(addNum);
    EventBean(eventName: EventName.signSuccess).sendEvent();
    NotificationUtils.instance.cancelNotification(NotificationsId.sign);
  }

  resetSign(){
    if(signDays>=7&&!todaySign){
      signDays=0;
      StorageUtils.instance.writeValue(StorageKey.sign, "${getTodayTimer()}_$signDays");
    }
  }
}