import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/buy_heart/buy_heart_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyHeartD extends BaseD<BuyHeartC>{
  @override
  BuyHeartC initC() => BuyHeartC();

  @override
  Widget contentWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CloseWidget(clickCall: (){ RoutersUtils.off(); }),
      SizedBox(height: 16.h,),
      SizedBox(
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
              child: Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ImagesWidget(name: "heart1",width: 120.w,height: 120.h,),
                        TextWidget(text: "x${UserInfoUtils.instance.userHeartNum}", size: 20.sp, color: Colors.white,fontWeight: FontWeight.w700,)
                      ],
                    ),
                    SizedBox(height: 8.h,),
                    TextWidget(text: "No chance left to play，come back tomorrow", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                    SizedBox(height: 32.h,),
                    InkWell(
                      onTap: (){
                        con.showAd();
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
              ),
            )
          ],
        ),
      )
    ],
  );
}