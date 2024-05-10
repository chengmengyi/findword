import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/task_incomplete/task_incomplete_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/light_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskIncompleteD extends BaseD<TaskIncompleteC>{
  int money;
  bool signTask;
  TaskIncompleteD({required this.money,required this.signTask});

  @override
  TaskIncompleteC initC() => TaskIncompleteC();

  @override
  Widget contentWidget() => Container(
    width: double.infinity,
    height: 476.h,
    margin: EdgeInsets.only(left: 16.w,right: 16.w),
    child: Stack(
      children: [
        ImagesWidget(name: "task1", width: double.infinity, height: 476.h,fit: BoxFit.fill,),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 12.h),
            child: TextWidget(text: "Withdraw", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 32.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(text: "One last step left to withdraw", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                SizedBox(height: 8.h,),
                TextWidget(
                  text: signTask?"Pending：Check in for 7 days ":"Pending：Collect 10 cash coins",
                  size: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(height: 32.h,),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ImagesWidget(name: "new2",width: double.infinity,height: 186.h,fit: BoxFit.fill,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LightWidget(),
                        StrokedTextWidget(
                            text: "\$$money",
                            fontSize: 28.sp,
                            textColor: "#D5FF65".toColor(),
                            strokeColor: "#002E63".toColor(),
                            strokeWidth: 1.w
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 32.h,),
                BtnWidget(
                    text: signTask?"Check in":"Go",
                    clickCall: (){
                      con.clickBtn(signTask);
                    }),
              ],
            ),
          ),
        )
      ],
    ),
  );
}