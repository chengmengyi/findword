import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/wheel/wheel_c.dart';
import 'package:findword/dialog/buy/wheel/wheel_widget.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WheelD extends BaseD<WheelC>{
  @override
  WheelC initC() => WheelC();

  @override
  Widget contentWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _topWidget(),
      SizedBox(height: 10.h,),
      ImagesWidget(name: "wheel1",height: 40.h,fit: BoxFit.fitHeight,),
      SizedBox(height: 6.h,),
      TextWidget(text: "20000 users have successfully withdrawn money", size: 13.sp, color: Colors.white,fontWeight: FontWeight.w700,),
      SizedBox(height: 16.h,),
      _wheelWidget(),
      SizedBox(height: 16.h,),
      // _boxWidget(),
      SizedBox(height: 30.h,),
      GetBuilder<WheelC>(
        id: "wheel_chance",
        builder: (_)=>BtnWidget(
          text: UserInfoUtils.instance.wheelNum>0?"Free To Play":"Get More Chance",
          clickCall: (){
            con.startWheel();
          },
          bg: "btn",
        ),
      ),
      SizedBox(height: 10.h,),
      GetBuilder<WheelC>(
        id: "wheel_chance",
        builder: (_)=> TextWidget(text: "Today Remaining times : ${UserInfoUtils.instance.wheelNum}", size: 13.sp, color: Colors.white.withOpacity(0.7))
      ),
    ],
  );

  _boxWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextWidget(text: "Play 3, 5, 7 times to get extra bonus", size: 15.sp, color: Colors.white,fontWeight: FontWeight.w700,),
      SizedBox(height: 2.h,),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: 398.w,
            height: 24.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12.w)
            ),
            child: Container(
              width: 100.w,
              height: 20.h,
              decoration: BoxDecoration(
                  color: "#FFD643".toColor(),
                  borderRadius: BorderRadius.circular(12.w)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 146.w),
            child: ImagesWidget(name: "wheel4",width: 48.w,height: 48.h,),
          ),
          Container(
            margin: EdgeInsets.only(left: 260.w),
            child: ImagesWidget(name: "wheel4",width: 48.w,height: 48.h,),
          ),
          Container(
            margin: EdgeInsets.only(left: 374.w),
            child: ImagesWidget(name: "wheel4",width: 48.w,height: 48.h,),
          )
        ],
      )
    ],
  );

  _wheelWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      WheelWidget(),
      InkWell(
        onTap: (){
          con.startWheel();
        },
        child: ImagesWidget(name: "wheel3",width: 121.w),
      ),
    ],
  );

  _topWidget()=>Row(
    children: [
      // SizedBox(width: 16.w,),
      // BuyCoinW(),
      const Spacer(),
      CloseWidget(clickCall: (){ con.clickClose(); })
    ],
  );
}