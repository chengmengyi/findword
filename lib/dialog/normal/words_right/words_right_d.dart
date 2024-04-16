import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/normal/words_right/wods_right_c.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordsRightD extends BaseD<WordsRightC>{
  Function() click;
  WordsRightD({required this.click});

  @override
  WordsRightC initC() => WordsRightC();

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
            child: TextWidget(text: "Amazing", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ImagesWidget(name: "right2",width: 366.w,height: 152.h,),
                  ImagesWidget(name: "right3",width: 120.w,height: 120.h,)
                ],
              ),
              SizedBox(height: 32.h,),
              InkWell(
                onTap: (){
                  con.clickSure(click);
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