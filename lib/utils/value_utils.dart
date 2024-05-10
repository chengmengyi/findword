import 'dart:convert';

import 'package:findword/bean/value_bean.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';

class ValueUtils {
  factory ValueUtils()=>_getInstance();
  static ValueUtils get instance => _getInstance();
  static ValueUtils? _instance;
  static ValueUtils _getInstance(){
    _instance??=ValueUtils._internal();
    return _instance!;
  }

  ValueUtils._internal();

  ValueBean? _valueBean;
  int _hour24=24*60*60;

  initValue(){
    _valueBean=ValueBean.fromJson(_getValueStr());
  }

  int getCurrentAddNum(){
    var common = _valueBean?.rewardLucky??[];
    if(common.isEmpty){
      return 3000;
    }
    var coinNum = UserInfoUtils.instance.userCoinNum;
    if(coinNum>(common.last.endNumber??3000000)){
      return (common.last.step??[3000]).random();
    }
    for (var value in common) {
      if(coinNum>=(value.firstNumber??0)&&coinNum<(value.endNumber??0)){
        return (value.step??[3000]).random();
      }
    }
    return 3000;
  }

  double getCoinToMoney(int coin){
    var fixed = (coin/(_valueBean?.conversion??10000)).toStringAsFixed(2);
    return fixed.toDouble();
  }

  int getMoneyToCoin(int money) => money*(_valueBean?.conversion??10000);

  List<int> getCashList()=>_valueBean?.range??[300,500,600,800];

  double getCashProgress(){
    var maxCoin = getMoneyToCoin(getCashList().first);
    var pro = UserInfoUtils.instance.userCoinNum/maxCoin;
    if(pro>=1.0){
      return 1.0;
    }else if(pro<=0){
      return 0.0;
    }else{
      return pro;
    }
  }

  _getValueStr(){
    try{
      var s = StorageUtils.instance.getValue<String>(StorageKey.valueStr)??"";
      if(s.isEmpty){
        return jsonDecode(localValueStr.base64());
      }
      return jsonDecode(s);
    }catch(e){
      return jsonDecode(localValueStr.base64());
    }
  }

  String getBoxCountDownStr(){
    try{
      _hour24--;
      return second2HMS(_hour24);
    }catch(e){
      return "00:00:00";
    }
  }
}