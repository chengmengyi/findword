import 'dart:async';

import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GetMoneyLottieWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _GetMoneyLottieWidgetState();
}

class _GetMoneyLottieWidgetState extends State<GetMoneyLottieWidget> with TickerProviderStateMixin{
  bool showLottie=false;
  late AnimationController _controller;
  late StreamSubscription<EventBean>? bus;

  @override
  void initState() {
    super.initState();
    _controller=AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 3000)
    )..addListener(() {
      if(_controller.value>=0.5){
        _controller.stop();
        setState(() {
          showLottie=false;
        });
        EventBean(eventName: EventName.updateUserCoin).sendEvent();
      }
    });
    //   ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     setState(() {
    //       showLottie=false;
    //     });
    //     EventBean(eventName: EventName.updateUserCoin).sendEvent();
    //   }
    // });
    bus=EventUtils.getInstance()?.on<EventBean>().listen((data) {
      if(data.eventName==EventName.playMoneyLottie){
        setState(() {
          showLottie=true;
        });
        _controller..reset()..forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Offstage(
    offstage: !showLottie,
    child: Lottie.asset(
      'asset/get.zip',
      repeat: false,
      controller: _controller,
    ),
  );

  @override
  void dispose() {
    bus?.cancel();
    bus=null;
    _controller.dispose();
    super.dispose();

  }
}