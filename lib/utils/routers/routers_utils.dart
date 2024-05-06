import 'package:findword/page/buy/buy_home/buy_home_p.dart';
import 'package:findword/page/normal/home/home_p.dart';
import 'package:findword/page/normal/launch/launch_p.dart';
import 'package:findword/page/normal/play/play_p.dart';
import 'package:findword/page/normal/set/set_p.dart';
import 'package:findword/page/normal/web/web_p.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoutersUtils{
  static final routersList=[
    GetPage(
      name: RoutersName.launch,
      page: ()=> LaunchP(),
      transition: Transition.fadeIn
    ),
    GetPage(
        name: RoutersName.home,
        page: ()=> HomeP(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: RoutersName.play,
        page: ()=> PlayP(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: RoutersName.set,
        page: ()=> SetP(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: RoutersName.web,
        page: ()=> WebP(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: RoutersName.buyHome,
        page: ()=> BuyHomeP(),
        transition: Transition.fadeIn
    ),
  ];

  static toPage({
    required String name,
    Map<String,dynamic>? map,
  }){
    Get.toNamed(name,arguments: map);
  }

  static offAllNamed({
    required String name,
    Map<String,dynamic>? map,
  }){
    Get.offAllNamed(name,arguments: map);
  }

  static off({Map<String, dynamic>? params}){
    Get.back(result: params);
  }


  static Map<String, dynamic> getParams() {
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
    return {};
    }
  }

  static showDialog({
    required Widget child,
    dynamic arguments,
    bool? barrierDismissible,
    Color? barrierColor
  }) {
    Get.dialog(
      child,
      arguments: arguments,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible ?? false,
    );
  }
}