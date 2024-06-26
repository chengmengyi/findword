import 'package:findword/base/base_c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseP<T extends BaseC> extends StatelessWidget{
  late T con;

  @override
  Widget build(BuildContext context){
    con=Get.put(initC());
    return Scaffold(
      body: WillPopScope(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: customWidget()?
            contentWidget()
            :Stack(
              children: [
                bgWidget(),
                SafeArea(
                  top: true,
                  bottom: true,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: contentWidget(),
                  ),
                ),
              ],
            ),
          ),
          onWillPop: ()async{
            return false;
          }
      ),
    );
  }

  Widget contentWidget();

  Widget bgWidget();

  T initC();

  bool customWidget()=>false;
}