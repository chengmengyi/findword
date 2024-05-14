import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LightWidget extends StatelessWidget{
  String? centerIcon;
  LightWidget({this.centerIcon});

  @override
  Widget build(BuildContext context) =>Stack(
    alignment: Alignment.center,
    children: [
      Lottie.asset(
        "asset/light.zip",
        width: 120.w,
        height: 120.h,
      ),
      ImagesWidget(
        name: centerIcon??"icon_money2",
        width: 80.w,
        height: 80.h,
        fit: BoxFit.fill,
      )
    ],
  );
}