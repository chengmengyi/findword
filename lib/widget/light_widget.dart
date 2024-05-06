import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LightWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) =>Stack(
    alignment: Alignment.center,
    children: [
      Lottie.asset(
        "asset/light.zip",
        width: 120.w,
        height: 120.h,
      ),
      ImagesWidget(name: "icon_money2",width: 100.w,height: 100.h,fit: BoxFit.fill,)
    ],
  );
}