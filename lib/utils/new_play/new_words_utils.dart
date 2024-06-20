import 'dart:convert';

import 'package:findword/bean/new_words_bean.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';

class NewWordsUtils{
  factory NewWordsUtils()=>_getInstance();
  static NewWordsUtils get instance => _getInstance();
  static NewWordsUtils? _instance;
  static NewWordsUtils _getInstance(){
    _instance??=NewWordsUtils._internal();
    return _instance!;
  }

  final List<NewWordsBean> _newWordsList=[];

  NewWordsUtils._internal(){
    var json = jsonDecode(newWordsStr.base64());
    for(var value in json){
      _newWordsList.add(NewWordsBean.fromJson(value));
    }
  }

  NewWordsBean? getCurrentWordsBean(){
    try{
      return _newWordsList[UserInfoUtils.instance.userLevel-1];
    }catch(e){
      return null;
    }
  }

  test(){
    _newWordsList.clear();
    var json = jsonDecode(newWordsStr.base64());
    for(var value in json){
      _newWordsList.add(NewWordsBean.fromJson(value));
    }
  }
}