import 'package:findword/base/base_w.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/coin/coin_c.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CoinWidget extends BaseW<CoinC>{

  @override
  CoinC initC() => CoinC();

  @override
  Widget contentWidget() => Container(
    height: 32.h,
    alignment: Alignment.center,
    padding: EdgeInsets.only(left: 4.w,right: 4.w),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.w),
        gradient: LinearGradient(
            colors: ["#D6FAFF".toColor(),"#B0F6FF".toColor()],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
        )
    ),
    child: Row(
      children: [
        ImagesWidget(name: "home1",width: 24.w,height: 24.h,),
        SizedBox(width: 4.w,),
        GetBuilder<CoinC>(
          id: "coin",
          builder: (_)=>TextWidget(
            text: "${UserInfoUtils.instance.userCoinNum}",
            size: 15.sp,
            color: "#002E63".toColor(),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}