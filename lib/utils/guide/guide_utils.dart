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

  var showBox=false,showBubble=false;

  initInfo(){
    if(_getLocalNewUserStep()==NewUserGuideStep.completed.name){
      showBox=true;
      showBubble=true;
    }
  }

  newUserGuide(){
    var step = _getLocalNewUserStep();
    if(step==NewUserGuideStep.showFingerGuide.name){
      EventBean(eventName: EventName.showNewUserFingerGuide).sendEvent();
    }else if(step==NewUserGuideStep.showBox.name){
      showBox=true;
      EventBean(eventName: EventName.showBox,boolValue: true).sendEvent();
    }else if(step==NewUserGuideStep.showBubbleGuide.name){
      EventBean(eventName: EventName.showBubbleGuide).sendEvent();
    }else{
      var newUserGuideTime=StorageUtils.instance.getValue<String>(StorageKey.newUserGuideTime)??"";
      if(newUserGuideTime!=getTodayTimer()){
        var oldUserGuideStep = _getTodayOldUserGuideStep();
        if(oldUserGuideStep==OldUserGuideStep.showBoxGuide.name){
          EventBean(eventName: EventName.showBox,boolValue: false).sendEvent();
        }
      }
    }
  }

  updateNewUserGuideStep(NewUserGuideStep step){
    StorageUtils.instance.writeValue(StorageKey.newUserGuideStep, step.name);
    if(step==NewUserGuideStep.completed){
      StorageUtils.instance.writeValue(StorageKey.newUserGuideTime, getTodayTimer());
    }
    newUserGuide();
  }

  updateOldUserGuideStep(OldUserGuideStep step){
    StorageUtils.instance.writeValue(StorageKey.oldUserGuideStep, "${getTodayTimer()}_${step.name}");
  }

  bool checkNewUserCompleteStepOne()=>_getLocalNewUserStep()!=NewUserGuideStep.showFingerGuide.name;

  String _getLocalNewUserStep()=>StorageUtils.instance.getValue<String>(StorageKey.newUserGuideStep)??NewUserGuideStep.showFingerGuide.name;

  String _getTodayOldUserGuideStep(){
    //2022-02-02_showBoxGuide
    var oldUserGuideStr = StorageUtils.instance.getValue<String>(StorageKey.oldUserGuideStep)??"";
    var oldUserStep=OldUserGuideStep.showBoxGuide.name;
    if(oldUserGuideStr.isNotEmpty){
      var split = oldUserGuideStr.split("_");
      if(getTodayTimer()==split.first){
        oldUserStep=split.last;
      }
    }
    return oldUserStep;
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