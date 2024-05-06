import 'dart:io';

import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:findword/utils/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_check_adjust_cloak/adjust/adjust_listener.dart';
import 'package:flutter_check_adjust_cloak/cloak/cloak_listener.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';
import 'package:flutter_check_adjust_cloak/util/firebase_listener.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class CheckUserUtils implements AdjustListener,CloakListener,FirebaseListener{
  factory CheckUserUtils()=>_getInstance();
  static CheckUserUtils get instance => _getInstance();
  static CheckUserUtils? _instance;
  static CheckUserUtils _getInstance(){
    _instance??=CheckUserUtils._internal();
    return _instance!;
  }

  CheckUserUtils._internal();

  check()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    var url="$cloakUrl?"
     "nigger=$distinctId&"
    "bela=${DateTime.now().millisecondsSinceEpoch}&"
    "main=${await FlutterTbaInfo.instance.getDeviceModel()}&"
    "bertrand=${kDebugMode?"com.findseek.wordlink.place":await FlutterTbaInfo.instance.getBuild()}&"
    "typhoon=${await FlutterTbaInfo.instance.getOsVersion()}&"
    "bayport=${await FlutterTbaInfo.instance.getIdfv()}&"
    "residue=${await FlutterTbaInfo.instance.getGaid()}&"
    "muzak=${await FlutterTbaInfo.instance.getAndroidId()}&"
    "pressure=${Platform.isAndroid?"upstage":"bater"}&"
    "shall=${await FlutterTbaInfo.instance.getIdfa()}&"
    "jargon=${await FlutterTbaInfo.instance.getAppVersion()}";
    FlutterCheckAdjustCloak.instance.forceBuyUser(true);
    FlutterCheckAdjustCloak.instance.initCheck(
        cloakPath: url,
        normalModeStr: "bestial",
        blackModeStr: "topsoil",
        adjustToken: Platform.isIOS?"inxzqyvgisqo":"",
        distinctId: distinctId,
        unknownFirebaseKey: "",
        referrerConfKey: "",
        adjustConfKey: "go_adjust_on",
        adjustListener: this,
        cloakListener: this,
        firebaseListener: this
    );
  }

  @override
  adjustChangeToBuyUser() {

  }

  @override
  adjustEventCall(AdjustEventSuccess eventSuccessData) {

  }

  @override
  adjustResultCall(String network) {

  }

  @override
  beforeRequestAdjust() {

  }

  @override
  firstRequestCloak() {

  }

  @override
  firstRequestCloakSuccess() {

  }

  @override
  initFirebaseSuccess() {

  }

  @override
  startRequestAdjust() {

  }
}