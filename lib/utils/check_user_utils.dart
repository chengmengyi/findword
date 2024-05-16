import 'dart:io';

import 'package:adjust_sdk/adjust_event_success.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
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
    "bertrand=${kDebugMode?"com.findseek.wordlink.place":await FlutterTbaInfo.instance.getBundleId()}&"
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
        adjustToken: adjustToken,
        distinctId: distinctId,
        unknownFirebaseKey: "",
        referrerConfKey: "",
        adjustConfKey: "find_adjust_on",
        adjustListener: this,
        cloakListener: this,
        firebaseListener: this
    );
  }

  @override
  adjustChangeToBuyUser() {
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.adj_organic_buy);
    if(!FlutterCheckAdjustCloak.instance.getUserType()&&FlutterCheckAdjustCloak.instance.checkType()&&!launchPageShowing&&!buyHomeShowing){
      RoutersUtils.offAllNamed(name: RoutersName.buyHome);
    }
  }

  @override
  adjustEventCall(AdjustEventSuccess eventSuccessData) {

  }

  @override
  adjustResultCall(String network) {
    TbaUtils.instance.uploadAppPoint(
      appPoint: AppPoint.fw_adj_suc,
      params: {
        "adjust_user":FlutterCheckAdjustCloak.instance.localAdjustIsBuyUser()==true?1:0
      });
  }

  @override
  beforeRequestAdjust() {

  }

  @override
  firstRequestCloak() {
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_cloak_req);
  }

  @override
  firstRequestCloakSuccess() {
    TbaUtils.instance.uploadAppPoint(
      appPoint: AppPoint.fw_cloak_suc,
      params: {
        "cloak_user":FlutterCheckAdjustCloak.instance.localCloakIsNormalUser()==true?1:0
      }
    );
  }

  @override
  initFirebaseSuccess() {
    FirebaseDataUtils.instance.getFirebaseData();
  }

  @override
  startRequestAdjust() {
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_adj_req);
  }
}