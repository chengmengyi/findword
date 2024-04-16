import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/normal/time_out/time_out_c.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeOutD extends BaseD<TimeOutC>{
  Function() click;
  TimeOutD({required this.click});

  @override
  TimeOutC initC() => TimeOutC();

  @override
  Widget contentWidget() => SizedBox(
    width: 398.w,
    height: 368.h,
    child: Stack(
      children: [
        ImagesWidget(name: "right1",width: 398.w,height: 368.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 12.h),
            child: TextWidget(text: "No Times", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ImagesWidget(name: "time1",width: 120.w,height: 120.h,),
                  TextWidget(text: "x${UserInfoUtils.instance.userTipsNum}", size: 20.sp, color: Colors.white,fontWeight: FontWeight.w700,)
                ],
              ),
              SizedBox(height: 8.h,),
              TextWidget(text: "Do you need to use hint?", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
              SizedBox(height: 32.h,),
              InkWell(
                onTap: (){
                  con.clickBtn(click);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ImagesWidget(name: "btn",width: 270.w,height: 64.h,),
                    TextWidget(text: "Claim", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,)
                  ],
                ),
              ),
              SizedBox(height: 32.h,),
            ],
          ),
        )
      ],
    ),
  );
}