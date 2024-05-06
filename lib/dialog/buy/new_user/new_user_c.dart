import 'package:findword/base/base_c.dart';

class NewUserC extends BaseC{
  var payIndex=0;
  List<String> payList=["pay_p","pay_g","pay_a","pay_w","pay_m","pay_c"];

  clickPay(index){
    if(payIndex==index){
      return;
    }
    payIndex=index;
    update(["pay_list"]);
  }
}