import 'dart:async';
import 'package:adjust_sdk/adjust.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class AppStateUtils{
  factory AppStateUtils()=>_getInstance();
  static AppStateUtils get instance => _getInstance();
  static AppStateUtils? _instance;
  static AppStateUtils _getInstance(){
    _instance??=AppStateUtils._internal();
    return _instance!;
  }

  AppStateUtils._internal();

  var _openLaunchPage=false;
  Timer? _bgTimer;

  setListener(){
    FlutterAppLifecycle.instance.setCallObserver(AppStateObserver(call: (back){
      if(back){
        Adjust.onPause();
        _checkBgTimer();
      }else{
        Adjust.onResume();
        _checkOpenLaunchPage();
      }
    }));
  }

  _checkBgTimer(){
    _bgTimer=Timer(const Duration(milliseconds: 3000), () {
      if(clickNotification||FlutterMaxAd.instance.fullAdShowing()){
        _openLaunchPage=false;
        return;
      }
      _openLaunchPage=true;
    });
  }

  _checkOpenLaunchPage(){
    _bgTimer?.cancel();
    Future.delayed(const Duration(milliseconds: 100),(){
      if(clickNotification||FlutterMaxAd.instance.fullAdShowing()){
        _openLaunchPage=false;
        return;
      }
      if(_openLaunchPage){
        TbaUtils.instance.uploadSessionEvent();
        AdUtils.instance.showOpenAd();
        _openLaunchPage=false;
      }
    });
  }
}