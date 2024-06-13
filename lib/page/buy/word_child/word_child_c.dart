import 'dart:io';

import 'package:findword/base/base_c.dart';
import 'dart:async';
import 'package:findword/bean/words_char_bean.dart';
import 'package:findword/dialog/buy/box/box_d.dart';
import 'package:findword/dialog/buy/buy_heart/buy_heart_d.dart';
import 'package:findword/dialog/buy/comment/comment_d.dart';
import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/dialog/buy/no_tips/no_tips_d.dart';
import 'package:findword/dialog/buy/up_level/up_level_d.dart';
import 'package:findword/dialog/buy/wheel/wheel_d.dart';
import 'package:findword/dialog/normal/heart/heart_d.dart';
import 'package:findword/dialog/normal/words_right/words_right_d.dart';
import 'package:findword/enums/click_words_tips_from.dart';
import 'package:findword/enums/show_answer_tips_from.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/guide/bubble_guide_overlay.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/utils/words/words_enum.dart';
import 'package:findword/utils/words/words_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';
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
  List<bool> bubbleShowList=[true,true,true];
  ClickWordsTipsFrom _clickWordsTipsFrom=ClickWordsTipsFrom.other;

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
    FlutterMaxAd.instance.loadAdByType(AdType.inter);
  }

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
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_flase_c);
      if(_checkChooseLastChar()){
        UserInfoUtils.instance.updateHeartNum(-1);
      }
      charBean.chooseStatus=ChooseStatus.error;
      Future.delayed(const Duration(milliseconds: 1000),(){
        charBean.chooseStatus=ChooseStatus.normal;
        update(["choose_list"]);
      });
    }else{
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_true_c);
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
        if(_checkWordsAllComplete()){
          if(UserInfoUtils.instance.userLevel%3==0){
            UserInfoUtils.instance.updateWheelNum(1);
            RoutersUtils.showDialog(
              child: WheelD(
                dismissDialog: (){
                  _showNextWords();
                },
              )
            );
          }else if(UserInfoUtils.instance.userLevel%5==0){
            RoutersUtils.showDialog(
                child: BoxD(
                  dismissDialog: (){
                    _showNextWords();
                  },
                )
            );
          }else{
            RoutersUtils.showDialog(
                child: UpLevelD(
                  closeDialog: () {
                    _showNextWords();
                    if(Platform.isIOS&&UserInfoUtils.instance.todayShowedReviewDialogNum<2&&!UserInfoUtils.instance.hasCommentApp){
                      RoutersUtils.showDialog(child: CommentD());
                    }
                  },
                )
            );
          }
        }else{
          showIncentDialog(
              incentFrom: IncentFrom.answerRightOneWord,
              closeDialog: (){
                _startTimerCount();
              });
        }
      }else{
        if(!GuideUtils.instance.getGuideStepComplete()){
          checkShowFinger(ClickWordsTipsFrom.guide);
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
    // if(!GuideUtils.instance.getGuideStepComplete()){
    //   return;
    // }
    _timerCount?.cancel();
    answerTimeCount=20;
    update(["timer"]);
    _timerCount=Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      answerTimeCount--;
      update(["timer"]);
      if(answerTimeCount<=0){
        timer.cancel();
        checkShowFinger(ClickWordsTipsFrom.hint);
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

  checkShowFinger(ClickWordsTipsFrom clickWordsTipsFrom){
    if(showFinger){
      return;
    }
    var tipsWords = _checkTipsWords();
    var indexWhere = tipsWords.charList.indexWhere((element) => element.chooseStatus!=ChooseStatus.right);
    if(indexWhere>=0){
      var index = wordsChooseList.indexWhere((element) => element.chooseStatus==ChooseStatus.normal&&element.chars==tipsWords.charList[indexWhere].chars);
      if(index>=0){
        var key = wordsChooseList[index].globalKey;
        if(null!=key){
          _clickWordsTipsFrom=clickWordsTipsFrom;
          tipsWordsCharBean=wordsChooseList[index];
          var renderBox = key.currentContext!.findRenderObject() as RenderBox;
          var offset = renderBox.localToGlobal(Offset.zero);
          fingerTop=offset.dy;
          fingerLeft=offset.dx;
          showFinger=true;
          update(["finger"]);
          UserInfoUtils.instance.updateTipsNum(-1);
          if(clickWordsTipsFrom==ClickWordsTipsFrom.hint){
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_hint_c);
          }
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
      TbaUtils.instance.uploadAppPoint(
        appPoint: AppPoint.fw_word_c,
        params: {"word_from":_clickWordsTipsFrom.name}
      );
      clickWordsChar(tipsWordsCharBean!);
    }
  }

  double getLevelProgress(){
    var d = (UserInfoUtils.instance.userLevel-1)%3/3;
    if(d>=1.0){
      return 1.0;
    }else if (d<=0){
      return 0.0;
    }else{
      return d;
    }
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
        _showWordBubbleGuide(true);
        break;
      case EventName.showAnswerTips:
        _showAnswerTipsFrom=ShowAnswerTipsFrom.newUserGuide;
        checkShowFinger(ClickWordsTipsFrom.guide);
        break;
      case EventName.showOldUserAnswerTips:
        _showAnswerTipsFrom=ShowAnswerTipsFrom.oldUserGuide;
        checkShowFinger(ClickWordsTipsFrom.guide);
        break;
      // case EventName.updateHomeIndex:
      //   if(eventBean.intValue==0&&eventBean.boolValue==true){
      //     _showWordBubbleGuide(false);
      //   }
      //   break;
      default:

        break;
    }
  }

  _showWordBubbleGuide(bool fromUserGuide){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_float_pop_guide);
    GuideUtils.instance.showOverlay(
      context: context!,
      widget: BubbleGuideOverlay(
          click: (){
            GuideUtils.instance.hideOverlay();
            TbaUtils.instance.uploadAppPoint(
                appPoint: AppPoint.word_float_pop,
                params: {"pop_from":fromUserGuide?"guide":"other"}
            );
            AdUtils.instance.showAd(
                adType: AdType.reward,
                adPosId: AdPosId.fw_new_bubble_rv,
                adFormat: AdFomat.REWARD,
                cancelShow: (){
                  _updateNewUserGuideStep(fromUserGuide);
                },
                adShowListener: AdShowListener(
                  showAdFail: (MaxAd? ad, MaxError? error) {
                    _updateNewUserGuideStep(fromUserGuide);
                  },
                  onAdHidden: (MaxAd? ad) {
                    UserInfoUtils.instance.updateUserCoinNum(ValueUtils.instance.getFloatAddNum());
                    _updateNewUserGuideStep(fromUserGuide);
                  },
                )
            );
          }
      ),
    );
  }

  _updateNewUserGuideStep(bool fromUserGuide){
    if(fromUserGuide){
      GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.answerTips);
    }else{
      showIncentDialog(
          incentFrom: IncentFrom.bubble,
          closeDialog: (){}
      );
    }
  }


  @override
  void onClose() {
    _timerCount?.cancel();
    super.onClose();
  }
}