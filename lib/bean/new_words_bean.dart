import 'package:findword/bean/words_char_bean.dart';
import 'package:flutter/material.dart';

class NewWordsBean {
  int? level;
  String? word;
  List<NewChooseWordsBean> completeList=[];
  List<NewChooseWordsBean> chooseList=[];

  NewWordsBean.fromJson(dynamic json) {
    level = json['level'];
    word = json['word'];
    var hint = json['hint'].split("");
    for(var value2 in hint){
      completeList.add(NewChooseWordsBean(words: value2, chooseStatus: ChooseStatus.right));
    }

    var letters = json['letters'] != null ? json['letters'].cast<String>() : [];
    for(var value in letters){
      chooseList.add(NewChooseWordsBean(words: value, chooseStatus: ChooseStatus.normal,globalKey: GlobalKey()));
    }
  }


}

class NewChooseWordsBean{
  String words;
  ChooseStatus chooseStatus;
  GlobalKey? globalKey;
  NewChooseWordsBean({
    required this.words,
    required this.chooseStatus,
    this.globalKey
});
}