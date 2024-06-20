import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/congratulation/congratulation_dialog.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/sign_guide_overlay.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value2_utils.dart';
import 'package:flutter/material.dart';

class SignC extends BaseC{
  SignFrom signFrom=SignFrom.other;
  List<int> signList=[];
  List<GlobalKey> globalList=[];

  @override
  void onInit() {
    super.onInit();
    SignUtils.instance.resetSign();
    var map = RoutersUtils.getParams();
    signFrom=map["signFrom"]??SignFrom.other;
    signList.addAll(Value2Utils.instance.getSignInList());
    for (var value in signList) {
      globalList.add(GlobalKey());
    }
    TbaUtils.instance.uploadAppPoint(
      appPoint: AppPoint.fw_signin_pop,
      params: {
        "sign_from":signFrom==SignFrom.newUser?"new":"other"
      }
    );
  }

  @override
  void onReady() {
    super.onReady();
    _checkShowGuideOverlay();
  }

  _checkShowGuideOverlay(){
    if(null==context){
      return;
    }
    if(signFrom!=SignFrom.newUser&&signFrom!=SignFrom.oldUser){
      return;
    }

    var buildContext = globalList[SignUtils.instance.signDays].currentContext!;
    var box = buildContext.findRenderObject()! as RenderBox;
    var offset = box.localToGlobal(Offset.zero);
    GuideUtils.instance.showOverlay(
        context: context!,
        widget: SignGuideOverlay(
            offset: offset,
            size: buildContext.size,
            index: SignUtils.instance.signDays,
            addNum: signList[SignUtils.instance.signDays],
            click: (){
              clickSign(SignUtils.instance.signDays);
            })
    );
  }

  clickSign(int index){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_signin_pop_c);
    if(SignUtils.instance.todaySign){
      "Today signed".showToast();
      return;
    }
    if(index>SignUtils.instance.signDays){
      return;
    }
    if(signFrom==SignFrom.newUser){
      GuideUtils.instance.updateNewUserGuideStep(NewUserGuideStep.showBubbleGuide);
    }
    if(signFrom==SignFrom.oldUser){
      GuideUtils.instance.updateOldUserGuideStep(OldUserGuideStep.completed);
    }
    var add = signList[index];
    RoutersUtils.showDialog(
      child: CongratulationDialog(
        dismiss: (){
          SignUtils.instance.sign(add);
          RoutersUtils.off();
          "Sign Success".showToast();
        },
      ),
      arguments: {"addNum":add.toDouble()}
    );
  }
}