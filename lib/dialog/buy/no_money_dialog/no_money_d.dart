import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/no_money_dialog/no_money_c.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoMoneyD extends BaseD<NoMoneyC>{
  @override
  NoMoneyC initC() => NoMoneyC();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    height: 296.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w),
    child: Stack(
      children: [
        ImagesWidget(name: "no1", width: double.infinity, height: 296.h,fit: BoxFit.fill,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 12.h),
            child: TextWidget(text: "Sorry", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(text: "Insufficient balance", size: 22.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                SizedBox(height: 8.h,),
                TextWidget(text: "Your account balance is insufficient and withdrawal is temporarily unavailable.", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                SizedBox(height: 32.h,),
                BtnWidget(
                    text: "Earn More Cash",
                    clickCall: (){
                      RoutersUtils.off();
                      EventBean(eventName: EventName.updateHomeIndex,intValue: 0).sendEvent();
                    }),
              ],
            ),
          ),
        )
      ],
    ),
  );
}