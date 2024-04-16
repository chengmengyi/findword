
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:findword/utils/data.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/words/words_enum.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension String2Color on String{
  Color toColor(){
    if(startsWith("#")&&length==7){
      var hexStr = replaceAll("#", "");
      return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
    }
    return Colors.white;
  }
}

extension StringBase64 on String{
  String base64()=>String.fromCharCodes(base64Decode(this));
}

extension String2Int on String{
  int toInt({int defaultNum=0}){
    try{
      return int.parse(this);
    }catch(e){
      return defaultNum;
    }
  }
}

String getTodayTimer(){
  var time = DateTime.now();
  return "${time.month}/${time.day}/${time.year}";
}


int getTodayNum({required String key,int defaultNum=0}){
  try{
    var list = (StorageUtils.instance.getValue<String>(key)??"").split("_");
    if(list.first==getTodayTimer()){
      return list.last.toInt();
    }
    return defaultNum;
  }catch(e){
    return defaultNum;
  }
}

extension RandomStringList on List<String>{
  String random() => this[Random().nextInt(length)];
}

List<String> getRandomChar(WordsEnum wordsEnum){
  List<String> list=[];
  if(wordsEnum==WordsEnum.middle){
    for(int i=0;i<4;i++){
      list.add(chara2z.random());
    }
  }
  if(wordsEnum==WordsEnum.high){
    for(int i=0;i<10;i++){
      list.add(chara2z.random());
    }
  }
  return list;
}

extension StringShowToast on String{
  showToast(){
    if(length<=0){
      return;
    }
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16
    );
  }
}
