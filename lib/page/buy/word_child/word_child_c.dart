import 'dart:io';
import 'dart:ui';

import 'package:findword/base/base_c.dart';
import 'package:findword/bean/new_words_bean.dart';
import 'dart:async';
import 'package:findword/bean/words_char_bean.dart';
import 'package:findword/dialog/buy/box/box_d.dart';
import 'package:findword/dialog/buy/buy_heart/buy_heart_d.dart';
import 'package:findword/dialog/buy/comment/comment_d.dart';
import 'package:findword/dialog/buy/congratulation/congratulation_dialog.dart';
import 'package:findword/dialog/buy/get_money/get_money_d.dart';
import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/dialog/buy/no_tips/no_tips_d.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/dialog/buy/up_level/up_level_d.dart';
import 'package:findword/dialog/buy/wheel/wheel_d.dart';
import 'package:findword/dialog/normal/heart/heart_d.dart';
import 'package:findword/dialog/normal/words_right/words_right_d.dart';
import 'package:findword/enums/check_show_ad_from.dart';
import 'package:findword/enums/click_words_tips_from.dart';
import 'package:findword/enums/get_money_from.dart';
import 'package:findword/enums/show_answer_tips_from.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/guide/box_guide_overlay.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/guide/bubble_guide_overlay.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/new_play/new_words_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value2_utils.dart';
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
import 'package:get_storage/get_storage.dart';


class WordChildC extends BaseC{
  WordsEnum wordsEnum=WordsEnum.easy;
  // ShowAnswerTipsFrom _showAnswerTipsFrom=ShowAnswerTipsFrom.other;
  int rowsNum=3,answerTimeCount=5;
  List<WordsBean> wordsList=[];
  List<WordsCharBean> wordsChooseList=[];
  Timer? _timerCount;
  double fingerTop=0.0,fingerLeft=0.0;

  List<bool> bubbleShowList=[true,true,true];
  ClickWordsTipsFrom _clickWordsTipsFrom=ClickWordsTipsFrom.other;

  var canClick=true,tipsIndex=-1;
  Offset? wheelGuideOffset;
  NewWordsBean ? currentWordsBean;
  GlobalKey boxGlobalKey=GlobalKey();
  GlobalKey wheelGlobalKey=GlobalKey();



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
    GuideUtils.instance.newUserGuide();
  }

  clickWordsChar(NewChooseWordsBean? charBean){
    if(tipsIndex!=-1&&_clickWordsTipsFrom==ClickWordsTipsFrom.guide){
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_1_c,);
    }

    if(tipsIndex!=-1&&GuideUtils.instance.checkNewUserCompleteStepOne()){
      tipsIndex=-1;
      update(["finger"]);
    }
    if(!canClick){
      return;
    }
    canClick=false;
    var result=_checkChooseResult(charBean);
    if(!result){
      currentWordsBean?.completeList.add(NewChooseWordsBean(words: charBean?.words??"", chooseStatus: ChooseStatus.error));
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_flase_c);
      UserInfoUtils.instance.updateHeartNum(-1);
      charBean?.chooseStatus=ChooseStatus.error;
      Future.delayed(const Duration(milliseconds: 1000),(){
        canClick=true;
        charBean?.chooseStatus=ChooseStatus.normal;
        currentWordsBean?.completeList.removeLast();
        update(["words_list","choose_list"]);
      });
    }else{
      canClick=true;
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_true_c);
      currentWordsBean?.completeList.add(NewChooseWordsBean(words: charBean?.words??"", chooseStatus: ChooseStatus.right));
      _startTimerCount();
      if(currentWordsBean?.completeList.length==currentWordsBean?.word?.length){
        _timerCount?.cancel();
        // if(_showAnswerTipsFrom==ShowAnswerTipsFrom.newUserGuide){
        //   // GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.completeNewUserStep);
        // }else if(_showAnswerTipsFrom==ShowAnswerTipsFrom.oldUserGuide){
        //   GuideUtils.instance.updateOldUserGuide(OldUserGuideStep.completeOldUserGuide);
        // }
        // _showAnswerTipsFrom=ShowAnswerTipsFrom.other;
        if(_clickWordsTipsFrom==ClickWordsTipsFrom.guide){
          _clickWordsTipsFrom=ClickWordsTipsFrom.other;
          RoutersUtils.showDialog(
            child: CongratulationDialog(
              dismiss: (){
                _showNextWords();
                GuideUtils.instance.updateNewUserGuideStep(NewUserGuideStep.showBox);
              },
            ),
          );
          return;
        }
        var checkShowAd = Value2Utils.instance.checkShowAd(CheckShowAdFrom.level);
        if(checkShowAd){
          AdUtils.instance.showAd(
            adType: AdType.inter,
            adPosId: AdPosId.fw_word_int,
            adFormat: AdFomat.INT,
            adShowListener: AdShowListener(
              onAdHidden: (ad){
                _showGetMoneyDialog();
              },
              showAdFail: (ad,error){
                _showGetMoneyDialog();
              }
            ),
            cancelShow: (){
              _showGetMoneyDialog();
            }
          );
        }else{
          _showGetMoneyDialog();
        }
      }
    }
    update(["words_list","choose_list"]);
  }

  _showGetMoneyDialog(){
    RoutersUtils.showGetMoneyDialog(
      getMoneyFrom: GetMoneyFrom.words,
      dismissDialog: (){
        _showNextWords();
      },
    );
  }

  _showNextWords(){
    UserInfoUtils.instance.updateUserLevel();
    _updateWordsList();
    if(UserInfoUtils.instance.userLevel==3){
      _showBubbleGuideOverlay();
    }
    if(tipsIndex!=-1){
      tipsIndex=-1;
      update(["finger"]);
    }
  }

  bool _checkChooseResult(NewChooseWordsBean? charBean){
    var result="";
    currentWordsBean?.completeList.forEach((element) {
      result+=element.words;
    });
    result+=charBean?.words??"";
    return currentWordsBean?.word?.startsWith(result)??false;
  }

  _updateWordsList(){
    currentWordsBean=NewWordsUtils.instance.getCurrentWordsBean();
    currentWordsBean?.chooseList.shuffle();
    update(["words_list","choose_list"]);
    _startTimerCount();
  }

  NewChooseWordsBean? getHintWordsByIndex(int index){
    try{
      return currentWordsBean?.completeList[index];
    }catch(e){
      return null;
    }
  }

  NewChooseWordsBean? getChooseWordsBeanByIndex(int index){
    try{
      return currentWordsBean?.chooseList[index];
    }catch(e){
      return null;
    }
  }

  _startTimerCount(){
    _timerCount?.cancel();
    answerTimeCount=5;
    _timerCount=Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      answerTimeCount--;
      if(answerTimeCount<=0){
        timer.cancel();
        if(GuideUtils.instance.checkNewUserCompleteStepOne()){
          checkShowFinger(ClickWordsTipsFrom.hint);
        }
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
    if(tipsIndex!=-1){
      return;
    }
    var completeStr="";
    currentWordsBean?.completeList.forEach((element) {
      completeStr+=element.words;
    });
    var s = currentWordsBean?.word?.replaceFirst(completeStr, "")??"";
    if(s.isNotEmpty){
      var t = s.substring(0,1);
      var indexWhere = currentWordsBean?.chooseList.indexWhere((element) => element.chooseStatus==ChooseStatus.normal&&element.words==t)??-1;
      if(indexWhere>=0){
        tipsIndex=indexWhere;
        update(["finger"]);
        _clickWordsTipsFrom=clickWordsTipsFrom;
      }
    }
  }

  clickTipsFinger(){
    if(tipsIndex!=-1){
      clickWordsChar(currentWordsBean?.chooseList[tipsIndex]);
    }
  }

  double? getFingerTop(){
    switch(tipsIndex){
      case 0: return 100.h;
      case 1: return null;
      case 2: return 33.h;
      default: return null;
    }
  }

  double? getFingerLeft(){
    switch(tipsIndex){
      case 0: return 60.w;
      case 1: return 180.w;
      case 2: return null;
      default: return null;
    }
  }

  double? getFingerRight(){
    switch(tipsIndex){
      case 0: return null;
      case 1: return null;
      case 2: return 30.w;
      default: return null;
    }
  }

  double? getFingerBottom(){
    switch(tipsIndex){
      case 0: return null;
      case 1: return 0;
      case 2: return null;
      default: return null;
    }
  }

  double getLevelProgress(){
    var d = UserInfoUtils.instance.wheelChanceProgress/5;
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
        _checkShowWheelGuide();
        break;
      // case EventName.showWordBubbleGuide:
      //   _showWordBubbleGuide(true);
      //   break;
      // case EventName.showAnswerTips:
      //   _showAnswerTipsFrom=ShowAnswerTipsFrom.newUserGuide;
      //   checkShowFinger(ClickWordsTipsFrom.guide);
      //   break;
      // case EventName.showOldUserAnswerTips:
      //   _showAnswerTipsFrom=ShowAnswerTipsFrom.oldUserGuide;
      //   checkShowFinger(ClickWordsTipsFrom.guide);
        break;
      case EventName.showNewUserFingerGuide:
        TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_1);
        checkShowFinger(ClickWordsTipsFrom.guide);
        break;
      case EventName.showBox:
        update(["box"]);
        _showBoxGuideOverlay(eventBean.boolValue??false);
        break;
      case EventName.showBubbleGuide:
        _showBubbleGuideOverlay();
        break;
      default:

        break;
    }
  }

  _checkShowWheelGuide(){
    if(null!=wheelGuideOffset||UserInfoUtils.instance.wheelChanceProgress<5){
      return;
    }
    var renderBox = wheelGlobalKey.currentContext!.findRenderObject() as RenderBox;
    wheelGuideOffset = renderBox.localToGlobal(Offset.zero);
    update(["wheel_guide"]);
  }

  clickWheel(){
    if(UserInfoUtils.instance.wheelChanceProgress<5){
      return;
    }
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_word_page_wheel);
    if(null!=wheelGuideOffset){
      wheelGuideOffset=null;
      update(["wheel_guide"]);
      UserInfoUtils.instance.resetWheelProgress();
    }
    UserInfoUtils.instance.updateWheelNum(1);
    RoutersUtils.showDialog(
        child: WheelD(
            dismissDialog: (){

            })
    );
  }

  _showBubbleGuideOverlay(){
    if(UserInfoUtils.instance.userLevel>=3){
      TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_3);
      GuideUtils.instance.showOverlay(
        context: context!,
        widget: BubbleGuideOverlay(
          click: (){
            TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_3_c);
            RoutersUtils.showDialog(
                child: CongratulationDialog(
                    dismiss: (){
                      GuideUtils.instance.showBubble=true;
                      GuideUtils.instance.updateNewUserGuideStep(NewUserGuideStep.completed);
                      update(["bubble"]);
                    })
            );
          },
        ),
      );
    }
  }

  _showBoxGuideOverlay(bool fromNewUser){
    var renderBox = boxGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    if(null!=context){
      if(fromNewUser){
        TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_2);
      }
      GuideUtils.instance.showOverlay(
        context: context!,
        widget: BoxGuideOverlay(
          offset: offset,
          call: (){
            if(fromNewUser){
              TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.guide_level_2_c);
            }
            RoutersUtils.showSignDialog(fromNewUser?SignFrom.newUser:SignFrom.oldUser);
          },
        ),
      );
    }
  }

  // _showWordBubbleGuide(bool fromUserGuide){
  //   TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.word_float_pop_guide);
  //   GuideUtils.instance.showOverlay(
  //     context: context!,
  //     widget: BubbleGuideOverlay(
  //         click: (){
  //           GuideUtils.instance.hideOverlay();
  //           TbaUtils.instance.uploadAppPoint(
  //               appPoint: AppPoint.word_float_pop,
  //               params: {"pop_from":fromUserGuide?"guide":"other"}
  //           );
  //           AdUtils.instance.showAd(
  //               adType: AdType.reward,
  //               adPosId: AdPosId.fw_new_bubble_rv,
  //               adFormat: AdFomat.REWARD,
  //               cancelShow: (){
  //                 _updateNewUserGuideStep(fromUserGuide);
  //               },
  //               adShowListener: AdShowListener(
  //                 showAdFail: (MaxAd? ad, MaxError? error) {
  //                   _updateNewUserGuideStep(fromUserGuide);
  //                 },
  //                 onAdHidden: (MaxAd? ad) {
  //                   UserInfoUtils.instance.updateUserCoinNum(ValueUtils.instance.getFloatAddNum());
  //                   _updateNewUserGuideStep(fromUserGuide);
  //                 },
  //               )
  //           );
  //         }
  //     ),
  //   );
  // }

  _updateNewUserGuideStep(bool fromUserGuide){
    if(fromUserGuide){
      // GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.answerTips);
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