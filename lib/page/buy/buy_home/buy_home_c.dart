import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/incent/incent_d.dart';
import 'package:findword/dialog/buy/new_user/new_user_d.dart';
import 'package:findword/dialog/buy/sign/sign_d.dart';
import 'package:findword/dialog/buy/up_level/up_level_d.dart';
import 'package:findword/page/buy/cash_child/cash_child_p.dart';
import 'package:findword/page/buy/word_child/word_child_p.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:flutter/material.dart';

class BuyHomeC extends BaseC{
  var showIndex=0;
  List<Widget> pageList=[WordChildP(),CashChildP()];
  List<String> iconList=["tab_word","tab_cash"];

  clickTab(index){
    if(index==showIndex){
      return;
    }
    showIndex=index;
    update(["home"]);
  }

  clickSet(){
    // RoutersUtils.toPage(name: RoutersName.set);
    RoutersUtils.showDialog(child: UpLevelD());
  }
}