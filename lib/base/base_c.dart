import 'dart:async';

import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_utils.dart';
import 'package:get/get.dart';

abstract class BaseC extends GetxController{
  late StreamSubscription<EventBean>? _bus;

  @override
  void onInit() {
    super.onInit();
    if(initEvent()){
      _bus=EventUtils.getInstance()?.on<EventBean>().listen((event) {
        receiveEventMsg(event);
      });
    }
  }

  bool initEvent()=>false;

  receiveEventMsg(EventBean eventBean){}

  @override
  void onClose() {
    if(initEvent()){
      _bus?.cancel();
    }
    super.onClose();
  }
}