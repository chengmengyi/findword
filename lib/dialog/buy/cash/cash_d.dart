import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/cash/cash_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CashD extends BaseD<CashC>{
  int money;
  CashD({required this.money});

  @override
  CashC initC() => CashC();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    height: 422.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w),
    child: Stack(
      children: [
        ImagesWidget(name: "cash8", width: double.infinity, height: 422.h,fit: BoxFit.fill,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 12.h),
            child: TextWidget(text: "Congratulations", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(text: "\$$money", size: 56.sp, color: "#D5FF65".toColor(),fontWeight: FontWeight.w700,),
                _inputWidget(),
                SizedBox(height: 8.h,),
                TextWidget(text: "Your cash will arrive in your account within 3-7 business days. Please keep an eye on your account!", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                SizedBox(height: 32.h,),
                BtnWidget(
                    text: "Withdraw Now",
                    clickCall: (){
                      con.clickWithdraw();
                    }),
              ],
            ),
          ),
        )
      ],
    ),
  );
  
  _inputWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      ImagesWidget(name: "cash9",width: double.infinity,height: 56.h,),
      TextField(
        enabled: true,
        maxLength: 20,
        textAlign: TextAlign.center,
        controller: con.controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          isCollapsed: true,
          hintText: 'Please input your account',
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      )
    ],
  );
}