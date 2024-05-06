import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/incent/incent_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/light_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IncentD extends BaseD<IncentC>{

  @override
  IncentC initC() => IncentC();

  @override
  Widget contentWidget() => Stack(
    children: [
      Container(
        margin: EdgeInsets.only(left: 16.w,right: 16.w),
        child: ImagesWidget(
          name: "dialog_bg",
          width: double.infinity,
          height: 530.h,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 32.w,right: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h,),
            _topWidget(),
            _progressWidget(),
            SizedBox(height: 24.h,),
            _btnWidget(),
            SizedBox(height: 10.h,),
            _closeTextWidget(),
          ],
        ),
      )
    ],
  );

  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextWidget(
        text: "Amazing",
        size: 28.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(height: 30.h,),
      Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(name: "new2",width: double.infinity,height: 186.h,fit: BoxFit.fill,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LightWidget(),
              StrokedTextWidget(
                  text: "\$2.2",
                  fontSize: 28.sp,
                  textColor: "#D5FF65".toColor(),
                  strokeColor: "#002E63".toColor(),
                  strokeWidth: 1.w
              )
            ],
          )
        ],
      )
    ],
  );

  _progressWidget()=>Column(
    children: [
      SizedBox(height: 10.h,),
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 40.h,
            margin: EdgeInsets.only(top: 12.h),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 334.w,
                    height: 24.h,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(right: 20.w),
                    padding: EdgeInsets.only(left: 2.w,right: 2.w),
                    decoration: BoxDecoration(
                        color: "#3D7FD8".toColor(),
                        borderRadius: BorderRadius.circular(12.w)
                    ),
                    child: Container(
                      width: 100.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                          color: "#FFD643".toColor(),
                          borderRadius: BorderRadius.circular(12.w)
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ImagesWidget(name: "icon_money1",width: 40.w,height: 40.w,),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.w),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ImagesWidget(name: "pro_bg",width: 48.w,height: 24.h,),
                Container(
                  margin: EdgeInsets.only(top: 1.h),
                  child: TextWidget(
                    text: "\$20",
                    size: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h,),
      StrokedTextWidget(
          text: "Withdrawal coming soon...",
          fontSize: 13.sp,
          textColor: Colors.white,
          strokeColor: "#002E63".toColor(),
          strokeWidth: 1.w
      )
    ],
  );

  _btnWidget()=>Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        margin: EdgeInsets.all(8.w),
        child: BtnWidget(text: "Claim", clickCall: (){}),
      ),
      ImagesWidget(name: "incent1",width: 80.w,height: 32.h,),
    ],
  );

  _closeTextWidget()=> InkWell(
    onTap: (){
      RoutersUtils.off();
    },
    child: StrokedTextWidget(
        text: "Claim",
        fontSize: 20.sp,
        textColor: Colors.white.withOpacity(0.5),
        strokeColor: "#002E63".toColor(),
        strokeWidth: 1.w
    ),
  );

}