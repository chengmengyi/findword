import 'package:findword/base/base_c.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';

class BuyCoinC extends BaseC{
  @override
  bool initEvent() => true;

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.updateUserCoin:
        update(["coin"]);
        break;
        default:
          break;
    }
  }
}