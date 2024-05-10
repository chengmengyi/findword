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

  var bubbleTime=5,wordInt=3;

  getFirebaseData(){
    _getBubbleTime();
    _getWordInt();
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
}