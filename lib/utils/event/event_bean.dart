import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';

class EventBean{
  EventName eventName;
  EventBean({required this.eventName});

  sendEvent(){
    EventUtils.getInstance()?.fire(this);
  }
}