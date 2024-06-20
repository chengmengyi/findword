import 'dart:convert';
import 'dart:math';

import 'package:findword/bean/value_bean2.dart';
import 'package:findword/enums/check_show_ad_from.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter/foundation.dart';

class Value2Utils{
  factory Value2Utils()=>_getInstance();
  static Value2Utils get instance => _getInstance();
  static Value2Utils? _instance;
  static Value2Utils _getInstance(){
    _instance??=Value2Utils._internal();
    return _instance!;
  }

  Value2Utils._internal();

  ValueBean2? _valueBean;

  initValue(){
    _valueBean=ValueBean2.fromJson(_getValueStr());
  }

  double getLevelAddNum(){
    var common = _valueBean?.levelReward??[];
    if(common.isEmpty){
      return 7.0;
    }
    var userMoney = UserInfoUtils.instance.userMoney;
    if(userMoney>(common.last.endNumber??500)){
      return _randomMinMax(common.last.step?.first??1, common.last.step?.last??5);
    }
    for (var value in common) {
      if(userMoney>=(value.firstNumber??0)&&userMoney<(value.endNumber??0)){
        return _randomMinMax(value.step?.first??1, value.step?.last??5);
      }
    }
    return 7.0;
  }

  double getWheelAddNum(){
    var common = _valueBean?.wheel??[];
    if(common.isEmpty){
      return 2.0;
    }
    var userMoney = UserInfoUtils.instance.userMoney;
    if(userMoney>(common.last.endNumber??500)){
      return _randomMinMax(common.last.step?.first??2, common.last.step?.last??10);
    }
    for (var value in common) {
      if(userMoney>=(value.firstNumber??0)&&userMoney<(value.endNumber??0)){
        return _randomMinMax(value.step?.first??2, value.step?.last??10);
      }
    }
    return 2.0;
  }

  double getFloatAddNum(){
    var common = _valueBean?.levelReward??[];
    if(common.isEmpty){
      return 7.0;
    }
    var userMoney = UserInfoUtils.instance.userMoney;
    if(userMoney>(common.last.endNumber??500)){
      return _randomMinMax(common.last.step?.first??5, common.last.step?.last??15);
    }
    for (var value in common) {
      if(userMoney>=(value.firstNumber??0)&&userMoney<(value.endNumber??0)){
        return _randomMinMax(value.step?.first??5, value.step?.last??15);
      }
    }
    return 7.0;
  }

  List<int> getSignInList()=>_valueBean?.signIn??[20,30,40,80,160,80,200];

  bool checkShowAd(CheckShowAdFrom checkShowAdFrom){
    // if(kDebugMode){
    //   return true;
    // }
    List<LevelReward> list=[];
    switch(checkShowAdFrom){
      case CheckShowAdFrom.level:
        list=_valueBean?.levelReward??[];
        break;
      case CheckShowAdFrom.wheel:
        list=_valueBean?.wheel??[];
        break;
      case CheckShowAdFrom.float:
        list=_valueBean?.floatReward??[];
        break;
    }
    if(list.isEmpty){
      return false;
    }
    var userMoney = UserInfoUtils.instance.userMoney;
    if(userMoney>(list.last.endNumber??500)){
      return _randomShowAd(list.last.intAd??0);
    }
    for (var value in list) {
      if(userMoney>=(value.firstNumber??0)&&userMoney<(value.endNumber??0)){
        return _randomShowAd(value.intAd??0);
      }
    }
    return false;
  }

  List<int> getCashList()=>_valueBean?.range??[500,1000,1500,2000];

  double getCashProgress(){
    var maxMoney = getCashList().first;
    var pro = UserInfoUtils.instance.userMoney/maxMoney;
    if(pro>=1.0){
      return 1.0;
    }else if(pro<=0){
      return 0.0;
    }else{
      return pro;
    }
  }

  double _randomMinMax(int min,int max) {
    var num = Random().nextDouble() * (max - min) + min;
    return num.toStringAsFixed(2).toDouble();
  }

  bool _randomShowAd(int intAd)=> Random().nextInt(100)<intAd;

  _getValueStr(){
    try{
      var s = StorageUtils.instance.getValue<String>(StorageKey.valueStr2)??"";
      if(s.isEmpty){
        return jsonDecode(localValueStr.base64());
      }
      return jsonDecode(s);
    }catch(e){
      return jsonDecode(localValueStr.base64());
    }
  }
}