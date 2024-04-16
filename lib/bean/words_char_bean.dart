import 'package:flutter/material.dart';

enum ChooseStatus{
  normal,error,right
}

class WordsBean{
  List<WordsCharBean> charList;
  bool isRight;
  WordsBean({required this.charList,this.isRight=false});

  @override
  String toString() {
    return 'WordsBean{charList: $charList, isRight: $isRight}';
  }
}

class WordsCharBean{
  String chars;
  ChooseStatus chooseStatus;
  GlobalKey? globalKey;
  WordsCharBean({
    required this.chars,
    this.chooseStatus=ChooseStatus.normal,
    this.globalKey,
  });

  @override
  String toString() {
    return 'WordsCharBean{chars: $chars, chooseStatus: $chooseStatus}';
  }
}