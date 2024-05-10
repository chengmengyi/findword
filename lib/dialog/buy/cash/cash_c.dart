import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:flutter/material.dart';

class CashC extends BaseC{
  TextEditingController controller=TextEditingController();

  clickWithdraw(){
    var content = controller.text.toString().trim();
    if(content.isEmpty){
      return;
    }
    RoutersUtils.off();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}