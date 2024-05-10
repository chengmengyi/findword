import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/utils/ad_utils.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/guide/old_user_guide_step.dart';
import 'package:findword/utils/guide/sign_guide_overlay.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';

class SignC extends BaseC{
  SignFrom signFrom=SignFrom.other;
  List<int> signList=[2000,2000,3000,5000,7000,8000,10000];
  List<GlobalKey> globalList=[];

  @override
  void onInit() {
    super.onInit();
    SignUtils.instance.resetSign();
    var map = RoutersUtils.getParams();
    signFrom=map["signFrom"]??SignFrom.other;
    for (var value in signList) {
      globalList.add(GlobalKey());
    }
  }

  @override
  void onReady() {
    _checkShowGuideOverlay();
  }

  _checkShowGuideOverlay(){
    if(null==context){
      return;
    }
    if(signFrom!=SignFrom.newUser&&signFrom!=SignFrom.oldUser){
      return;
    }
    var box = globalList[SignUtils.instance.signDays].currentContext!.findRenderObject()! as RenderBox;
    var offset = box.localToGlobal(Offset.zero);
    GuideUtils.instance.showOverlay(
        context: context!,
        widget: SignGuideOverlay(
            offset: offset,
            index: SignUtils.instance.signDays,
            click: (){
              GuideUtils.instance.hideOverlay();
              AdUtils.instance.showAd(
                  adType: AdType.reward,
                  adShowListener: AdShowListener(
                      showAdSuccess: (MaxAd? ad) {  },
                      showAdFail: (MaxAd? ad, MaxError? error) {
                        _updateGuideStep();
                      },
                      onAdHidden: (MaxAd? ad) {
                        SignUtils.instance.sign(signList[SignUtils.instance.signDays]);
                        _updateGuideStep();
                      },
                      onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {  }
                  )
              );
            })
    );
  }

  _updateGuideStep(){
    RoutersUtils.off();
    if(signFrom==SignFrom.newUser){
      GuideUtils.instance.updateNewUserGuide(NewUserGuideStep.wordBubbleGuide);
    }else{
      GuideUtils.instance.updateOldUserGuide(OldUserGuideStep.incentDialog);
    }
  }

  clickSign(int index){
    if(SignUtils.instance.todaySign||index>SignUtils.instance.signDays){
      return;
    }
    SignUtils.instance.sign(signList[index]);
    RoutersUtils.off();
  }
}