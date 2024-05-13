import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter_check_adjust_cloak/flutter_check_adjust_cloak.dart';

class FirebaseDataUtils{
  factory FirebaseDataUtils()=>_getInstance();
  static FirebaseDataUtils get instance => _getInstance();
  static FirebaseDataUtils? _instance;
  static FirebaseDataUtils _getInstance(){
    _instance??=FirebaseDataUtils._internal();
    return _instance!;
  }

  FirebaseDataUtils._internal();

  var bubbleTime=5,wordInt=3,closeWord=3;

  getFirebaseData(){
    // _getBubbleTime();
    // _getWordInt();

    _getFirebaseIntValue(bubbleTime, "getpop_dis");
    _getFirebaseIntValue(wordInt, "word_int");
    _getFirebaseIntValue(closeWord, "close_word");
    _getValueStr();
    _getAdStr();
  }

  _getBubbleTime()async{
    var s = (await FlutterCheckAdjustCloak.instance.getFirebaseStrValue("getpop_dis")).toInt();
    if(s>0){
      bubbleTime=s;
    }
  }

  _getWordInt()async{
    var s = (await FlutterCheckAdjustCloak.instance.getFirebaseStrValue("word_int")).toInt();
    if(s>0){
      wordInt=s;
    }
  }

  _getFirebaseIntValue(int type,String key)async{
    var s = (await FlutterCheckAdjustCloak.instance.getFirebaseStrValue(key)).toInt();
    if(s>0){
      type=s;
    }
  }
  
  _getValueStr()async{
    var str = await FlutterCheckAdjustCloak.instance.getFirebaseStrValue("find_number");
    if(str.isNotEmpty){
      StorageUtils.instance.writeValue(StorageKey.valueStr, str);
    }
  }

  _getAdStr()async{
    var str = await FlutterCheckAdjustCloak.instance.getFirebaseStrValue("fw_ad");
    if(str.isNotEmpty){
      StorageUtils.instance.writeValue(StorageKey.adStr, str);
    }
  }
}