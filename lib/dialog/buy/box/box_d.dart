import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/box/box_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/light_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BoxD extends BaseD<BoxC>{
  Function() dismissDialog;
  BoxD({required this.dismissDialog});

  @override
  bool custom() => true;

  @override
  BoxC initC() => BoxC();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _finishWidget(),
        _animateWidget(),
        SizedBox(height: 100.h,)
      ],
    ),
  );

  _finishWidget()=>GetBuilder<BoxC>(
    id: "top",
    builder: (_)=>Visibility(
      visible: con.showTop,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CloseWidget(clickCall: (){RoutersUtils.off();}),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LightWidget(),
                  StrokedTextWidget(
                      text: "+${con.addNum}  ≈ \$${ValueUtils.instance.getCoinToMoney(con.addNum)}",
                      fontSize: 20.sp,
                      textColor: "#D5FF65".toColor(),
                      strokeColor: "#116508".toColor(),
                      strokeWidth: 2.w
                  )
                ],
              ),
              SizedBox(width: 20.w,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LightWidget(centerIcon: "time1",),
                  StrokedTextWidget(
                      text: "x1",
                      fontSize: 20.sp,
                      textColor: "#D5FF65".toColor(),
                      strokeColor: "#116508".toColor(),
                      strokeWidth: 2.w
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 40.h,),
          BtnWidget(
              text: "Collect",
              clickCall: (){
                con.clickCollect(dismissDialog);
              }),
        ],
      ),
    ),
  );

  _animateWidget()=>Lottie.asset(
    "asset/box.zip",
    width: 300.w,
    repeat: false,
    fit: BoxFit.fitWidth,
  );
}