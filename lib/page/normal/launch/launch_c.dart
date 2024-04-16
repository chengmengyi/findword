import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';

class LaunchC extends BaseC{
  var progress=0.0,_count=0,_totalCount=60;
  late Timer _timer;

  @override
  void onReady() {
    super.onReady();
    _startProgressTimer();
  }

  _startProgressTimer(){
    _timer=Timer.periodic(const Duration(milliseconds: 50), (timer) {
      _count++;
      progress=_count/_totalCount;
      update(["progress"]);
      if(_count>=_totalCount){
        timer.cancel();
        RoutersUtils.offAllNamed(name: RoutersName.home);
      }
    });
  }
}