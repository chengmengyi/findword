import 'dart:convert';

import 'package:findword/utils/data.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/words/words_enum.dart';

class WordsUtils {
  factory WordsUtils()=>_getInstance();
  static WordsUtils get instance => _getInstance();
  static WordsUtils? _instance;
  static WordsUtils _getInstance(){
    _instance??=WordsUtils._internal();
    return _instance!;
  }

  final List<String> _easyWordsList=[];
  final List<String> _middleWordsList=[];
  final List<String> _highWordsList=[];
  var _easyIndex=0,_middleIndex=0,_highIndex=0;

  WordsUtils._internal(){
    _initList();
    initIndex();
  }

  List<String> getWordsList(WordsEnum wordsEnum){
    List<String> list=[];
    if(wordsEnum==WordsEnum.easy){
      _getWordsByIndex(list, _easyWordsList, _easyIndex, wordsEnum);
    }
    if(wordsEnum==WordsEnum.easy){
      _getWordsByIndex(list, _easyWordsList, _easyIndex, wordsEnum);
    }
    if(wordsEnum==WordsEnum.middle){
      _getWordsByIndex(list, _middleWordsList, _middleIndex, wordsEnum);
    }
    if(wordsEnum==WordsEnum.high){
      _getWordsByIndex(list, _highWordsList, _highIndex, wordsEnum);
    }
    return list;
  }

  _initList(){
    var decode = jsonDecode(words64.base64());
    _easyWordsList.clear();
    _middleWordsList.clear();
    _highWordsList.clear();
    for(var value in decode){
      if(value is String){
        if(value.length==3){
          _easyWordsList.add(value);
        }
        if(value.length==4){
          _middleWordsList.add(value);
        }
        if(value.length==5){
          _highWordsList.add(value);
        }
      }
    }
    // [Cat, Dog, Car,
    // Bus, Pen, Cup,
    // Hat, Sun, Run,
    // Fly, Toy, Key,
    // Egg, Leg, Arm,
    // Bed, Box, Day,
    // Gum, Joy, Oak,
    // Pan, Pet, Pie,
    // Run, Sad, Sea,
    // Sky, Sun, Bug,
    // Bat, Bee, Cow,
    // Dry, Fox, Ice,
    // Tap, Tea, Wet,
    // Zap, Arm, Zip,
    // Sun, Air, Log,
    // Map, Boy]
  }

  _getWordsByIndex(List<String> list,List<String> wordList,int index,WordsEnum wordsEnum){
    if(list.length>=3){
      if(wordsEnum==WordsEnum.easy){
        _easyIndex=index;
      }
      if(wordsEnum==WordsEnum.middle){
        _middleIndex=index;
      }
      if(wordsEnum==WordsEnum.high){
        _highIndex=index;
      }
      // _updateWordsIndex(wordsEnum, index);
      return;
    }
    if(index>=wordList.length){
      index=0;
      // _updateWordsIndex(wordsEnum, index);
    }
    list.add(wordList[index]);
    _getWordsByIndex(list,wordList,index+1,wordsEnum);
  }

  updateWordsIndex(WordsEnum wordsEnum){
    if(wordsEnum==WordsEnum.easy){
      StorageUtils.instance.writeValue(StorageKey.easyIndex, _easyIndex);
    }
    if(wordsEnum==WordsEnum.middle){
      StorageUtils.instance.writeValue(StorageKey.middleIndex, _middleIndex);
    }
    if(wordsEnum==WordsEnum.high){
      StorageUtils.instance.writeValue(StorageKey.highIndex, _highIndex);
    }
  }

  initIndex(){
    _easyIndex=StorageUtils.instance.getValue<int>(StorageKey.easyIndex)??0;
    _middleIndex=StorageUtils.instance.getValue<int>(StorageKey.middleIndex)??0;
    _highIndex=StorageUtils.instance.getValue<int>(StorageKey.highIndex)??0;
  }
}