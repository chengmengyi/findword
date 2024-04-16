import 'package:findword/base/base_c.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class SetC extends BaseC{

  clickItem(index){
    if(index==2){
      FlutterTbaInfo.instance.jumpToEmail(email);
    }else{
      RoutersUtils.toPage(name: RoutersName.web,map: {"url":index==0?privacy:term});
    }
  }
}