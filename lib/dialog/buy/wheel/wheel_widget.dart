import 'dart:async';
import 'dart:math';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WheelWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WheelWidgetState();
}
class _WheelWidgetState extends State<WheelWidget> with TickerProviderStateMixin{
  late StreamSubscription<EventBean>? bus;
  late AnimationController _repeatController;
  late Animation<double> _animation;
  Timer? _timer;
  bool showAnimator=false;

  @override
  void initState() {
    super.initState();
    bus=EventUtils.getInstance()?.on<EventBean>().listen((data) {
      if(data.eventName==EventName.startRotationWheel){
        if(showAnimator){
          return;
        }
        setState(() {
          showAnimator=true;
        });
        _timer=Timer.periodic(const Duration(milliseconds: 3200), (timer) {
          timer.cancel();
          setState(() {
            showAnimator=false;
          });
          EventBean(eventName: EventName.stopRotationWheel).sendEvent();
        });
      }
    });
    _repeatController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_repeatController);
  }
  @override
  Widget build(BuildContext context) =>
      showAnimator?
      RotationTransition(
        turns: _animation,
        child: ImagesWidget(name: "wheel2",height: 398.h,fit: BoxFit.fitHeight,),
      ):
      Transform.rotate(
        angle: (Random().nextInt(180) * (pi / 180.0)).toDouble(),
        child: ImagesWidget(name: "wheel2",height: 398.h,fit: BoxFit.fitHeight,),
      );

  @override
  void dispose() {
    bus?.cancel();
    bus=null;
    _timer?.cancel();
    _timer=null;
    _repeatController.dispose();
    super.dispose();
  }
}