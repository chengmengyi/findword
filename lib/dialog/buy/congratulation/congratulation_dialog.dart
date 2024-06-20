import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/congratulation/congratulation_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CongratulationDialog extends BaseD<CongratulationC>{
  Function() dismiss;
  CongratulationDialog({required this.dismiss});

  @override
  initView() {
    con.dismiss=dismiss;
  }

  @override
  CongratulationC initC() => CongratulationC();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.w),
    margin: EdgeInsets.only(left: 48.w,right: 48.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(32.w),
      color: "#000000".toColor().withOpacity(0.7)
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (r){
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ["#FF9900".toColor(),"#FFE665".toColor()]
            ).createShader(Offset.zero & r.size);
          },
          blendMode: BlendMode.srcATop,
          child: TextWidget(
            text: "Congratulations",
            size: 32.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Lottie.asset("asset/money_new.zip",width: 200.w,height: 200.w,fit: BoxFit.fill),
            StrokedTextWidget(
              text: "+\$${con.addNum}",
              fontSize: 40.sp,
              textColor: "#D5FF65".toColor(),
              strokeColor: "#116508".toColor(),
              strokeWidth: 2.w,
            )
          ],
        ),
      ],
    ),
  );

}