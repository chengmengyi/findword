import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter/material.dart';

class CashC extends BaseC{
  TextEditingController controller=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.cash_success_pop);
  }

  clickWithdraw(){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.cash_success_pop_c);
    var content = controller.text.toString().trim();
    if(content.isEmpty){
      return;
    }
    RoutersUtils.off();
    "Congratulations on your successful withdrawal. Your money has arrived.".showToast();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}