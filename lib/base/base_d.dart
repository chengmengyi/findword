import 'package:findword/base/base_c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseD<T extends BaseC> extends StatelessWidget{
  late T con;

  @override
  Widget build(BuildContext context){
    con=Get.put(initC());
    return WillPopScope(
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: contentWidget(),
          ),
        ),
        onWillPop: ()async{
          return false;
        }
    );
  }

  Widget contentWidget();

  T initC();
}