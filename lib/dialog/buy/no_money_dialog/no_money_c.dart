import 'package:findword/base/base_c.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';

class NoMoneyC extends BaseC{
  @override
  void onInit() {
    super.onInit();
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.cash_no_pop);
  }

  click(){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.cash_no_pop_c);
    RoutersUtils.off();
    EventBean(eventName: EventName.updateHomeIndex,intValue: 0).sendEvent();
  }
}