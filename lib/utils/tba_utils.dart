import 'dart:io';

import 'package:findword/utils/data.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:flutter_check_adjust_cloak/dio/dio_manager.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';
import 'package:flutter_check_adjust_cloak/util/utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:get/get.dart';

class TbaUtils{
  factory TbaUtils()=>_getInstance();
  static TbaUtils get instance => _getInstance();
  static TbaUtils? _instance;
  static TbaUtils _getInstance(){
    _instance??=TbaUtils._internal();
    return _instance!;
  }

  TbaUtils._internal();

  uploadInstallEvent({int tryNum=3})async{
    var has = StorageUtils.instance.getValue<bool>(StorageKey.installEvent)??false;
    if(has){
      return;
    }
    uploadAppPoint(appPoint: AppPoint.fw_install);
    var logId = await FlutterTbaInfo.instance.getLogId();
    var url = "${await _getTbaUrl()}&bamboo=$logId";
    var header = await _getHeader();
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    var commonMap = await _getCommonMap(logId);
    commonMap["praise"]="festival";
    commonMap["legging"]=referrerMap["build"];
    commonMap["insult"]=referrerMap["referrer_url"];
    commonMap["carnage"]=referrerMap["install_version"];
    commonMap["hades"]=referrerMap["user_agent"];
    commonMap["alacrity"]="brandish";
    commonMap["copperas"]=referrerMap["referrer_click_timestamp_seconds"];
    commonMap["response"]=referrerMap["install_begin_timestamp_seconds"];
    commonMap["jesse"]=referrerMap["referrer_click_timestamp_server_seconds"];
    commonMap["bigot"]=referrerMap["install_begin_timestamp_server_seconds"];
    commonMap["quip"]=referrerMap["install_first_seconds"];
    commonMap["pullover"]=referrerMap["last_update_seconds"];
    printLogByDebug("tba--->install--->data-->$commonMap");
    var result = await DioManager.instance.requestPost(url: url, dataMap: commonMap,headerMap: header);
    printLogByDebug("tba--->install--->result-->success:${result.success}--->callback:${result.result}");
    if(result.success){
      StorageUtils.instance.writeValue(StorageKey.installEvent, true);
    }else{
      if(tryNum>0){
        Future.delayed(const Duration(milliseconds: 2000),(){
          uploadInstallEvent(tryNum: tryNum-1);
        });
      }
    }
  }

  uploadSessionEvent({int tryNum=3})async{
    TbaUtils.instance.uploadAppPoint(
        appPoint: AppPoint.fw_session_front,
        params: {
          "pak_version":FlutterCheckAdjustCloak.instance.getUserType()?1:0
        });

    var logId = await FlutterTbaInfo.instance.getLogId();
    var url = "${await _getTbaUrl()}&bamboo=$logId";
    var header = await _getHeader();
    var commonMap = await _getCommonMap(logId);
    commonMap["arrow"]={};
    printLogByDebug("tba--->session--->data-->$commonMap");
    var result = await DioManager.instance.requestPost(url: url, dataMap: commonMap,headerMap: header);
    printLogByDebug("tba--->session--->result-->success:${result.success}--->callback:${result.result}");
    if(!result.success&&tryNum>0){
      Future.delayed(const Duration(milliseconds: 2000),(){
        uploadSessionEvent(tryNum: tryNum-1);
      });
    }
  }

  uploadAdEvent({
    required MaxAd? ad,
    required MaxAdInfoBean? info,
    required AdPosId adPosId,
    required AdFomat adFormat,
    int tryNum=3,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var url = "${await _getTbaUrl()}&bamboo=$logId";
    var header = await _getHeader();
    var map = await _getCommonMap(logId);
    var fin={
      "pareto":(ad?.revenue??0)*1000000,
      "roentgen": "USD",
      "cohosh": ad?.networkName??"",
      "subvert": info?.plat??"",
      "shuck":info?.id??"",
      "cindy":adPosId.name,
      "grew":adFormat.name,
      "berglund":ad?.revenuePrecision??"",
    };
    map["fin"]=fin;
    printLogByDebug("tba--->adEvent--->data-->$map");
    var result = await DioManager.instance.requestPost(url: url, dataMap: map,headerMap: header);
    printLogByDebug("tba--->adEvent--->result-->success:${result.success}--->callback:${result.result}");
    if(!result.success&&tryNum>0){
      Future.delayed(const Duration(milliseconds: 2000),(){
        uploadAdEvent(ad: ad, info: info, adPosId: adPosId, adFormat: adFormat,tryNum: tryNum-1);
      });
    }
  }

  uploadAdPoint({
    required AdPoint adPoint,
    int tryNum=3,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var url = "${await _getTbaUrl()}&bamboo=$logId";
    var header = await _getHeader();
    var map = await _getCommonMap(logId);
    map["praise"]=adPoint.name;
    printLogByDebug("tba--->adPoint--->data-->$map");
    var result = await DioManager.instance.requestPost(url: url, dataMap: map,headerMap: header);
    printLogByDebug("tba--->adPoint--->result-->success:${result.success}--->callback:${result.result}");
    if(!result.success&&tryNum>0){
      Future.delayed(const Duration(milliseconds: 2000),(){
        uploadAdPoint(adPoint: adPoint,tryNum: tryNum-1);
      });
    }
  }

  uploadAppPoint({
    required AppPoint appPoint,
    Map<String,dynamic>? params,
    int tryNum=3,
  })async{
    if(appPoint==AppPoint.unknown){
      return;
    }
    var logId = await FlutterTbaInfo.instance.getLogId();
    var url = "${await _getTbaUrl()}&bamboo=$logId";
    var header = await _getHeader();
    var map = await _getCommonMap(logId);
    map["praise"]=appPoint.name;
    if(null!=params){
      for (var keys in params.keys) {
        map["$keys^nostrand"]=params[keys];
      }
    }
    printLogByDebug("tba--->appPoint--->data-->$map");
    var result = await DioManager.instance.requestPost(url: url, dataMap: map,headerMap: header);
    printLogByDebug("tba--->appPoint--->result-->success:${result.success}--->callback:${result.result}");
    if(!result.success&&tryNum>0){
      Future.delayed(const Duration(milliseconds: 2000),(){
        uploadAppPoint(appPoint: appPoint,params: params,tryNum: tryNum-1);
      });
    }
  }

  Future<Map<String,dynamic>> _getCommonMap(String logId)async{
    return {
      "nigger":await FlutterTbaInfo.instance.getDistinctId(),
      "main":await FlutterTbaInfo.instance.getDeviceModel(),
      "malady":await FlutterTbaInfo.instance.getManufacturer(),
      "howdy":await FlutterTbaInfo.instance.getBrand(),
      "pressure":Platform.isAndroid?"upstage":"bater",
      "muzak":await FlutterTbaInfo.instance.getAndroidId(),
      "bamboo":logId,
      "crucible":await FlutterTbaInfo.instance.getOperator(),
      "ravine":await FlutterTbaInfo.instance.getOsCountry(),
      "jargon":await FlutterTbaInfo.instance.getAppVersion(),
      "shall":await FlutterTbaInfo.instance.getIdfa(),
      "songbook":await FlutterTbaInfo.instance.getScreenRes(),
      "suave":await FlutterTbaInfo.instance.getNetworkType(),
      "bertrand":await FlutterTbaInfo.instance.getBundleId(),
      "lama":await FlutterTbaInfo.instance.getSystemLanguage(),
      "residue":await FlutterTbaInfo.instance.getGaid(),
      "bayport":await FlutterTbaInfo.instance.getIdfv(),
      "bela":DateTime.now().millisecondsSinceEpoch,
      "typhoon":await FlutterTbaInfo.instance.getOsVersion(),
    };
  }

  Future<Map<String,dynamic>> _getHeader()async{
    return {
      "muzak":await FlutterTbaInfo.instance.getAndroidId(),
      "shall":await FlutterTbaInfo.instance.getIdfa()
    };
  }

  Future<String> _getTbaUrl()async{
    return "$tbaUrl?lama=${await FlutterTbaInfo.instance.getSystemLanguage()}";
  }
}