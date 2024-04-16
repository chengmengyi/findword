import 'dart:io';

import 'package:dio/dio.dart';
import 'package:findword/utils/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class CloakUtils{
  factory CloakUtils()=>_getInstance();
  static CloakUtils get instance => _getInstance();
  static CloakUtils? _instance;
  static CloakUtils _getInstance(){
    _instance??=CloakUtils._internal();
    return _instance!;
  }

  CloakUtils._internal(){
    _dio ??= Dio(BaseOptions(
        responseType: ResponseType.json,
        receiveDataWhenStatusError: false,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
      ));
  }

  var _requestNum=0;
  Dio? _dio;

  requestCloak()async{
    if(_requestNum>20){
      return;
    }
    var url="$cloakUrl?"
        "nigger=${await FlutterTbaInfo.instance.getDistinctId()}&"
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
    _requestGet(
        url: url,
        call: (success,result){
          print("cloak  result:$result");
          if(!success||result.isEmpty){
            _requestNum++;
            requestCloak();
          }
        });
  }

  _requestGet({required String url,required Function(bool,String) call})async{
    try{
      var response = await _dio?.request(url,options: Options(method: "get"));
      if(response?.statusCode==200){
        call.call(true,response?.data?.toString()??"");
      }else{
        call.call(false,"");
      }
    }catch(e){
      call.call(false,"");
    }
  }
}