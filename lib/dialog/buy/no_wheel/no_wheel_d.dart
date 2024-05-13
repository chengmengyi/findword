import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/no_wheel/no_wheel_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoWheelD extends BaseD<NoWheelC>{
  Function() addChanceCall;
  NoWheelD({required this.addChanceCall});

  @override
  NoWheelC initC() => NoWheelC();

  @override
  Widget contentWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CloseWidget(clickCall: (){RoutersUtils.off();}),
      Container(
        width: double.infinity,
        height: 388.h,
        margin: EdgeInsets.only(left: 16.w,right: 16.w),
        child: Stack(
          children: [
            ImagesWidget(name: "wheel5", width: double.infinity, height: 388.h,fit: BoxFit.fill,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 12.h),
                child: TextWidget(text: "No Times", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 120.w,
                      child: Stack(
                        children: [
                          ImagesWidget(name: "wheel6",width: 120.w,height: 120.w,),
                          Align(
                            alignment: Alignment.center,
                            child: ImagesWidget(name: "wheel7",width: 36.w,height: 36.w,),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: StrokedTextWidget(
                                text: "x0",
                                fontSize: 20.sp,
                                textColor: Colors.white,
                                strokeColor: "#C52424".toColor(),
                                strokeWidth: 2.w
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    TextWidget(
                      text: "Watch video to get three chances to enter the drawing",
                      size: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32.h,),
                    InkWell(
                      onTap: (){
                        con.showAd(addChanceCall);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ImagesWidget(name: "btn4",width: 270.w,height: 64.h,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ImagesWidget(name: "icon_video",width: 24.w,height: 24.w,),
                              SizedBox(width: 6.w,),
                              StrokedTextWidget(
                                  text: "Get",
                                  fontSize: 22.sp,
                                  textColor: Colors.white,
                                  strokeColor: "#B75800".toColor(),
                                  strokeWidth: 2.w
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}