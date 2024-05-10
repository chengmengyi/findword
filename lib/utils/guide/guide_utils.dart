import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/dialog/buy/new_user/new_user_d.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GuideUtils {
  factory GuideUtils()=>_getInstance();
  static GuideUtils get instance => _getInstance();
  static GuideUtils? _instance;
  static GuideUtils _getInstance(){
    _instance??=GuideUtils._internal();
    return _instance!;
  }

  GuideUtils._internal();

  OverlayEntry? _overlayEntry;

  newUserGuide(){
    var step = StorageUtils.instance.getValue<String>(StorageKey.newUserGuide)??NewUserGuideStep.newUserDialog.name;
    if(step==NewUserGuideStep.newUserDialog.name){
      RoutersUtils.showDialog(child: NewUserD());
    }else if(step==NewUserGuideStep.checkInGuide.name){
      EventBean(eventName: EventName.showCheckInGuide).sendEvent();
    }else if(step==NewUserGuideStep.signDialog.name){
      RoutersUtils.showDialog(child: SignD(),arguments: {"signFrom":SignFrom.newUser});
    }else if(step==NewUserGuideStep.wordBubbleGuide.name){
      EventBean(eventName: EventName.showWordBubbleGuide).sendEvent();
    }else if(step==NewUserGuideStep.answerTips.name){
      EventBean(eventName: EventName.showAnswerTips).sendEvent();
    }else{
      _checkOldUserGuideStep();
    }
  }

  _checkOldUserGuideStep(){
    var oldUserStep=_getTodayOldUserGuideStep();
    if(oldUserStep==OldUserGuideStep.completeOldUserGuide.name){
      return;
    }
    var isOldUser = StorageUtils.instance.getValue<String>(StorageKey.newUserGuideTimeStr)!=getTodayTimer();
    if(!isOldUser){
      return;
    }
    if(oldUserStep==OldUserGuideStep.signDialog.name){
      RoutersUtils.showDialog(child: SignD(),arguments: {"signFrom":SignFrom.oldUser});
    }else if(oldUserStep==OldUserGuideStep.incentDialog.name){
      RoutersUtils.showDialog(child: IncentD(closeDialog: () {  },),arguments: {"incentFrom":IncentFrom.oldUserGuide});
    }else if(oldUserStep==OldUserGuideStep.answerTips.name){
      EventBean(eventName: EventName.showOldUserAnswerTips).sendEvent();
    }
  }

  bool getGuideStepComplete(){
    var newUserGuideComplete = StorageUtils.instance.getValue<String>(StorageKey.newUserGuide)==NewUserGuideStep.completeNewUserStep.name;
    var oldUserGuideComplete = _getTodayOldUserGuideStep()==OldUserGuideStep.completeOldUserGuide.name;
    var todayCompleteNewUserGuide = StorageUtils.instance.getValue<String>(StorageKey.newUserGuideTimeStr)==getTodayTimer();
    return (newUserGuideComplete&&todayCompleteNewUserGuide)||oldUserGuideComplete;
  }

  String _getTodayOldUserGuideStep(){
    //2022-02-02_signDialog
    var oldUserGuideStr = StorageUtils.instance.getValue<String>(StorageKey.oldUserGuide)??"";
    var oldUserStep=OldUserGuideStep.signDialog.name;
    if(oldUserGuideStr.isNotEmpty){
      var split = oldUserGuideStr.split("_");
      if(getTodayTimer()==split.first){
        oldUserStep=split.last;
      }
    }
    return oldUserStep;
  }

  updateNewUserGuide(NewUserGuideStep step){
    StorageUtils.instance.writeValue(StorageKey.newUserGuide, step.name);
    if(step==NewUserGuideStep.completeNewUserStep){
      StorageUtils.instance.writeValue(StorageKey.newUserGuideTimeStr, getTodayTimer());
    }
    newUserGuide();
  }

  updateOldUserGuide(OldUserGuideStep step){
    StorageUtils.instance.writeValue(StorageKey.oldUserGuide, "${getTodayTimer()}_${step.name}");
    _checkOldUserGuideStep();
  }

  showOverlay({required BuildContext context,required Widget widget}){
    _overlayEntry=OverlayEntry(builder: (c)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }

  overlayShowing()=>null!=_overlayEntry;
}