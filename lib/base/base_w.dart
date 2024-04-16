import 'package:findword/base/base_c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseW<T extends BaseC> extends StatelessWidget{
  late T con;

  @override
  Widget build(BuildContext context){
    con=Get.put(initC());
    return contentWidget();
  }

  Widget contentWidget();

  T initC();
}