import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';

class TaskIncompleteC extends BaseC{
  clickBtn(bool signTask){
    RoutersUtils.off();
    if(signTask){
      RoutersUtils.showDialog(child: SignD());
    }else{
      EventBean(eventName: EventName.updateHomeIndex,intValue: 0).sendEvent();
    }
  }
}