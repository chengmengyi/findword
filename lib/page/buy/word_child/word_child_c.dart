import 'package:findword/base/base_c.dart';
import 'dart:async';
import 'package:findword/bean/words_char_bean.dart';
import 'package:findword/dialog/buy/buy_heart/buy_heart_d.dart';
import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/no_tips/no_tips_d.dart';
import 'package:findword/dialog/buy/up_level/up_level_d.dart';
import 'package:findword/dialog/buy/wheel/wheel_d.dart';
import 'package:findword/dialog/normal/heart/heart_d.dart';
import 'package:findword/dialog/normal/words_right/words_right_d.dart';
import 'package:findword/enums/show_answer_tips_from.dart';
import 'package:findword/utils/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/guide/bubble_guide_overlay.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/words/words_enum.dart';
import 'package:findword/utils/words/words_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WordChildC extends BaseC{
  WordsEnum wordsEnum=WordsEnum.easy;
  ShowAnswerTipsFrom _showAnswerTipsFrom=ShowAnswerTipsFrom.other;
  int rowsNum=3,answerTimeCount=20;
  List<WordsBean> wordsList=[];
  List<WordsCharBean> wordsChooseList=[];
  Timer? _timerCount;
  bool showFinger=false;
  double fingerTop=0.0,fingerLeft=0.0;
  WordsCharBean? tipsWordsCharBean;
  GlobalKey bubbleGlobal=GlobalKey();
  List<bool> bubbleShowList=[true,true,true];

  @override
  void onReady() {
    super.onReady();
    _updateWordsList();
  }

  clickWordsChar(WordsCharBean charBean){
    if(showFinger){
      showFinger=false;
      update(["finger"]);
    }
    if(charBean.chooseStatus!=ChooseStatus.normal){
      return;
    }
    if(UserInfoUtils.instance.userHeartNum<=0){
      RoutersUtils.showDialog(child: BuyHeartD());
      return;
    }
    var result = _checkChooseCharResult(charBean);
    if(null==result){
      if(_checkChooseLastChar()){
        UserInfoUtils.instance.updateHeartNum(-1);
      }
      charBean.chooseStatus=ChooseStatus.error;
      Future.delayed(const Duration(milliseconds: 1000),(){
        charBean.chooseStatus=ChooseStatus.normal;
        update(["choose_list"]);
      });
    }else{
      charBean.chooseStatus=ChooseStatus.right;
      _startTimerCount();
      if(_checkCompleteWord(result.charList)){
        result.isRight=true;
        _timerCount?.cancel();
        if(_showAnswerTipsFrom==ShowAnswerTipsFrom.newUserGuide){
          GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.completeNewUserStep);
        }else if(_showAnswerTipsFrom==ShowAnswerTipsFrom.oldUserGuide){
          GuideUtils.instance.updateOldUserGuide(OldUserGuideStep.completeOldUserGuide);
        }
        _showAnswerTipsFrom=ShowAnswerTipsFrom.other;
        // RoutersUtils.showDialog(child: WordsRightD(
        //   click: (){
        //     _startTimerCount();
        //     if(_checkWordsAllComplete()){
        //       WordsUtils.instance.updateBuyWordsIndex();
        //       UserInfoUtils.instance.updateUserLevel();
        //       _updateWordsList();
        //     }
        //   },
        // ));
        if(_checkWordsAllComplete()){
          if((UserInfoUtils.instance.userLevel+1)%3==0){
            UserInfoUtils.instance.updateWheelNum(1);
            RoutersUtils.showDialog(
              child: WheelD()
            );
          }else if((UserInfoUtils.instance.userLevel+1)%5==0){
            _showNextWords();
          }else{
            RoutersUtils.showDialog(
                child: UpLevelD(
                  closeDialog: () {
                    _showNextWords();
                  },
                )
            );
          }
        }else{
          RoutersUtils.showDialog(
            child: IncentD(
              closeDialog: (){
                _startTimerCount();
              },
            ),
          );
        }
      }else{
        if(!GuideUtils.instance.getGuideStepComplete()){
          checkShowFinger();
        }
      }
    }
    update(["words_list","choose_list"]);
  }

  _showNextWords(){
    WordsUtils.instance.updateBuyWordsIndex();
    UserInfoUtils.instance.updateUserLevel();
    _updateWordsList();
  }

  bool _checkWordsAllComplete(){
    for (var value in wordsList) {
      if(!value.isRight){
        return false;
      }
    }
    return true;
  }

  bool _checkChooseLastChar(){
    for (var value in wordsList) {
      if(!value.isRight){
        var indexWhere = value.charList.indexWhere((element) => element.chooseStatus!=ChooseStatus.right);
        if(indexWhere==rowsNum-1){
          return true;
        }
      }
    }
    return false;
  }

  bool _checkCompleteWord(List<WordsCharBean> list){
    for (var value in list) {
      if(value.chooseStatus!=ChooseStatus.right){
        return false;
      }
    }
    return true;
  }

  WordsBean? _checkChooseCharResult(WordsCharBean charBean){
    WordsBean? wordsBean;
    for (var value in wordsList) {
      if(!value.isRight){
        var indexWhere = value.charList.indexWhere((element) => element.chooseStatus!=ChooseStatus.right);
        if(indexWhere>0){
          if(value.charList[indexWhere].chars==charBean.chars){
            value.charList[indexWhere].chooseStatus=ChooseStatus.right;
            wordsBean = value;
            break;
          }else{
            break;
          }
        }else if(indexWhere==0){
          if(charBean.chars==value.charList.first.chars){
            value.charList[indexWhere].chooseStatus=ChooseStatus.right;
            wordsBean = value;
            break;
          }else{
            break;
          }
        }
      }
    }
    return wordsBean;
  }

  _updateWordsList(){
    wordsList.clear();
    wordsChooseList.clear();
    for (var word in WordsUtils.instance.getBuyUserWordsList()) {
      List<WordsCharBean> charList=[];
      for (var value in word.split("")) {
        if(value.isNotEmpty){
          charList.add(WordsCharBean(chars: value.toUpperCase()));
          wordsChooseList.add(WordsCharBean(chars: value.toUpperCase(),globalKey: GlobalKey()));
        }
      }
      wordsList.add(WordsBean(charList: charList));
    }
    var length = wordsList.first.charList.length;
    wordsEnum=length==3?WordsEnum.easy:length==4?WordsEnum.middle:WordsEnum.high;
    rowsNum=wordsEnum==WordsEnum.easy?3:wordsEnum==WordsEnum.middle?4:5;
    for (var value1 in getRandomChar(wordsEnum)) {
      wordsChooseList.add(WordsCharBean(chars: value1.toUpperCase()));
    }

    wordsChooseList.shuffle();
    update(["words_list","choose_list"]);
    _startTimerCount();
  }

  _startTimerCount(){
    if(!GuideUtils.instance.getGuideStepComplete()){
      return;
    }
    _timerCount?.cancel();
    answerTimeCount=20;
    update(["timer"]);
    _timerCount=Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      answerTimeCount--;
      update(["timer"]);
      if(answerTimeCount<=0){
        timer.cancel();
        checkShowFinger();
      }
    });
  }

  double getChooseCharMargin(){
    if(wordsEnum==WordsEnum.easy){
      return 66.w;
    }else if(wordsEnum==WordsEnum.middle){
      return 36.w;
    }else{
      return 16.w;
    }
  }

  checkShowFinger(){
    if(UserInfoUtils.instance.userTipsNum<=0&&GuideUtils.instance.getGuideStepComplete()){
      RoutersUtils.showDialog(
          child: NoTipsD(
            addTipsCall: (){
              checkShowFinger();
            },
          )
      );
      return;
    }
    var tipsWords = _checkTipsWords();
    var indexWhere = tipsWords.charList.indexWhere((element) => element.chooseStatus!=ChooseStatus.right);
    if(indexWhere>=0){
      var index = wordsChooseList.indexWhere((element) => element.chooseStatus==ChooseStatus.normal&&element.chars==tipsWords.charList[indexWhere].chars);
      if(index>=0){
        var key = wordsChooseList[index].globalKey;
        if(null!=key){
          tipsWordsCharBean=wordsChooseList[index];
          var renderBox = key.currentContext!.findRenderObject() as RenderBox;
          var offset = renderBox.localToGlobal(Offset.zero);
          fingerTop=offset.dy;
          fingerLeft=offset.dx;
          showFinger=true;
          update(["finger"]);
          UserInfoUtils.instance.updateTipsNum(-1);
        }
      }
    }
  }

  WordsBean _checkTipsWords(){
    WordsBean wordsBean=wordsList.first;
    for (var value in wordsList) {
      if(!value.isRight){
        var indexWhere = value.charList.indexWhere((element) => element.chooseStatus!=ChooseStatus.right);
        if(indexWhere>=0){
          wordsBean=value;
          break;
        }
      }
    }
    return wordsBean;
  }

  clickTipsFinger(){
    if(null!=tipsWordsCharBean){
      clickWordsChar(tipsWordsCharBean!);
    }
  }

  double getLevelProgress(){
    var d = UserInfoUtils.instance.userLevel%3/3;
    if(d>=1.0){
      return 1.0;
    }else if (d<=0){
      return 0.0;
    }else{
      return d;
    }
  }

  clickBubble(index){
    bubbleShowList[index]=false;
    update(["bubble"]);
    AdUtils.instance.showAd(
        adType: AdType.reward,
        cancelShow: (){
          _showBubble(index);
        },
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {

            },
            showAdFail: (MaxAd? ad, MaxError? error) {

            },
            onAdHidden: (MaxAd? ad) {
              UserInfoUtils.instance.updateBubbleNum(1);
              _showBubble(index);
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {

            })
    );
  }

  _showBubble(index){
    Future.delayed(Duration(seconds: FirebaseDataUtils.instance.bubbleTime),(){
      bubbleShowList[index]=true;
      update(["bubble"]);
    });
  }

  @override
  bool initEvent() => true;

  @override
  receiveEventMsg(EventBean eventBean) {
    switch(eventBean.eventName){
      case EventName.updateTipsNum:
        update(["tips"]);
        break;
      case EventName.updateUserLevel:
        update(["level","progress"]);
        break;
      case EventName.showWordBubbleGuide:
        _showWordBubbleGuide();
        break;
      case EventName.showAnswerTips:
        _showAnswerTipsFrom=ShowAnswerTipsFrom.newUserGuide;
        checkShowFinger();
        break;
      case EventName.showOldUserAnswerTips:
        _showAnswerTipsFrom=ShowAnswerTipsFrom.oldUserGuide;
        checkShowFinger();
        break;
      default:

        break;
    }
  }

  _showWordBubbleGuide(){
    var box = bubbleGlobal.currentContext!.findRenderObject()! as RenderBox;
    var offset = box.localToGlobal(Offset.zero);
    if(null!=context){
      GuideUtils.instance.showOverlay(
          context: context!,
          widget: BubbleGuideOverlay(
              offset: offset,
              click: (){
                GuideUtils.instance.hideOverlay();
                AdUtils.instance.showAd(
                    adType: AdType.reward,
                    adShowListener: AdShowListener(
                        showAdSuccess: (MaxAd? ad) {  },
                        showAdFail: (MaxAd? ad, MaxError? error) {
                          _updateNewUserGuideStep();
                        },
                        onAdHidden: (MaxAd? ad) {
                          _updateNewUserGuideStep();
                        },
                        onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {  }
                    )
                );
              }
          ),
      );
    }
  }

  _updateNewUserGuideStep(){
    GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.answerTips);
  }


  @override
  void onClose() {
    _timerCount?.cancel();
    super.onClose();
  }
}