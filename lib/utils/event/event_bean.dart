import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';

class EventBean{
  EventName eventName;
  int? intValue;
  bool? boolValue;
  EventBean({required this.eventName,this.intValue,this.boolValue});

  sendEvent(){
    EventUtils.getInstance()?.fire(this);
  }
}