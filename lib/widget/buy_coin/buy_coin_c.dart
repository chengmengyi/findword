import 'package:decimal/decimal.dart';
import 'package:findword/base/base_c.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';

class BuyCoinC extends BaseC{
  bool showCash=true;

  @override
  bool initEvent() => true;

  clickCash(){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_page_withdraw);
    EventBean(eventName: EventName.updateHomeIndex,intValue: 1).sendEvent();
  }

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.updateUserCoin:
        update(["coin"]);
        break;
      case EventName.showOrHideCash:
        showCash=eventBean.boolValue??false;
        update(["cash"]);
        break;
        default:
          break;
    }
  }

  double getCashProgress(){
    var a = Decimal.parse(UserInfoUtils.instance.userMoney.toString());
    var b = Decimal.parse("500");
    return (b-a).toDouble();
  }
}