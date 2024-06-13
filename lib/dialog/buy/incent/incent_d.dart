import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/incent/incent_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/light_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class IncentD extends BaseD<IncentC>{
  Function() closeDialog;
  IncentD({required this.closeDialog});

  @override
  IncentC initC() => IncentC();

  @override
  Widget contentWidget() => Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 16.w,right: 16.w),
              child: ImagesWidget(
                name: "dialog_bg",
                width: double.infinity,
                height: 587.h,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 32.w,right: 32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 6.h,),
                  _topWidget(),
                  _progressWidget(),
                  SizedBox(height: 10.h,),
                  _btnWidget(),
                  SizedBox(height: 6.h,),
                  _closeTextWidget(),
                ],
              ),
            )
          ],
        ),
      ),
      Column(
        children: [
          Expanded(
            child: Lottie.asset(
                "asset/caidai.json",
                width: double.infinity,
                // height: double.infinity,
                fit: BoxFit.fill
            ),
          ),
          const Spacer(flex: 1,),
        ],
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
        alignment: Alignment.bottomCenter,
        children: [
          ImagesWidget(
            name: "new4",
            width: double.infinity,
            height: 286.h,
            fit: BoxFit.fill,
          ),
          StrokedTextWidget(
              text: "\$${ValueUtils.instance.getCoinToMoney(con.addNum)}",
              fontSize: 25.sp,
              textColor: "#3DFF39".toColor(),
              strokeColor: "#126709".toColor(),
              strokeWidth: 2.w
          )
        ],
      )
    ],
  );

  _progressWidget(){
    var progress = ValueUtils.instance.getCashProgress();
    return Column(
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
                        width: (300.w)*progress,
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
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ImagesWidget(name: "icon_money1",width: 40.w,height: 40.w,),
                        TextWidget(text: "\$300", size: 11.sp, color: Colors.white,fontWeight: FontWeight.w800,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: (300.w)*progress-24.w<0?0:(300.w)*progress-24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 1.h,bottom: 2.h),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#FF9900".toColor(),"#FFE665".toColor()]
                        ),
                        borderRadius: BorderRadius.circular(16.w)
                    ),
                    child: TextWidget(
                      text: "\$${ValueUtils.instance.getCoinToMoney(UserInfoUtils.instance.userCoinNum)}",
                      size: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  ImagesWidget(name: "jiantou",width: 8.w,)
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h,),
        StrokedTextWidget(
            text: "Coll \$50 More To Cash Out \$100",
            fontSize: 13.sp,
            textColor: Colors.white,
            strokeColor: "#002E63".toColor(),
            strokeWidth: 1.w
        )
      ],
    );
  }

  _btnWidget()=>Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        margin: EdgeInsets.all(8.w),
        child: BtnWidget(
            text: "Claim",
            clickCall: (){
              con.clickDouble(closeDialog);
            }),
      ),
      ImagesWidget(name: "incent1",width: 83.w,height: 41.h,),
    ],
  );

  _closeTextWidget()=> InkWell(
    onTap: (){
      con.clickClose(closeDialog: closeDialog,clickClaim: true);
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