import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/load_fail/load_fail_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadFailD extends BaseD<LoadFailC>{
  Function() tryAgain;
  LoadFailD({required this.tryAgain});

  @override
  LoadFailC initC() => LoadFailC();

  @override
  Widget contentWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CloseWidget(clickCall: (){RoutersUtils.off();}),
      Container(
        width: double.infinity,
        height: 318.h,
        margin: EdgeInsets.only(left: 16.w,right: 16.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImagesWidget(name: "tips1", width: double.infinity, height: 318.h,fit: BoxFit.fill,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagesWidget(name: "icon_money2",height: 120.h,),
                SizedBox(height: 16.h,),
                TextWidget(text: "Ads are loading, please try again later", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                SizedBox(height: 34.h,),
                BtnWidget(
                    text: "Try Again",
                    bg: "btn4",
                    clickCall: (){
                      RoutersUtils.off();
                      tryAgain.call();
                    })
              ],
            )
          ],
        ),
      )
    ],
  );
}