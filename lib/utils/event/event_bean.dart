import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';

class EventBean{
  EventName eventName;
  int? intValue;
  EventBean({required this.eventName,this.intValue});

  sendEvent(){
    EventUtils.getInstance()?.fire(this);
  }
}