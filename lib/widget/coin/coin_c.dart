import 'package:findword/base/base_c.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';

class CoinC extends BaseC{
  @override
  bool initEvent() => true;

  @override
  receiveEventMsg(EventBean eventBean) {
    if(eventBean.eventName==EventName.updateUserCoin){
      update(["coin"]);
    }
  }
}