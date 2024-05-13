import 'dart:async';

import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class LoadAdC extends BaseC{
  var count=0;
  Timer? _timer;
  AdType adType=AdType.reward;
  Function()? loadSuccess;
  Function()? loadFail;

  initInfo(AdType adType,Function()? loadSuccess,Function()? loadFail){
    this.adType=adType;
    this.loadSuccess=loadSuccess;
    this.loadFail=loadFail;
  }

  @override
  void onReady() {
    super.onReady();
    _timer=Timer.periodic(const Duration(milliseconds: 50), (timer) {
      count++;
      update(["progress"]);
      if(count>=600){
        _stopTimer();
        RoutersUtils.off();
        loadFail?.call();
        return;
      }
      _checkHasAd();
    });
  }

  _checkHasAd()async{
    if(count>=40){
      var hasCache = FlutterMaxAd.instance.checkHasCache(adType);
      if(hasCache){
        _stopTimer();
        RoutersUtils.off();
        loadSuccess?.call();
      }
    }
  }

  double getPro(){
    var d = count/600;
    if(d>=1.0){
      return 1.0;
    }else if(d<=0.0){
      return 0.0;
    }else {
      return d;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _stopTimer();
  }

  _stopTimer(){
    _timer?.cancel();
    _timer=null;
  }
}