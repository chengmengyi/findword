import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/load_ad/load_ad_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoadAdD extends BaseD<LoadAdC>{
  AdType adType;
  Function() loadSuccess;
  Function() loadFail;
  LoadAdD({
    required this.adType,
    required this.loadSuccess,
    required this.loadFail,
});

  @override
  LoadAdC initC() => LoadAdC();

  @override
  Widget contentWidget(){
    con.initInfo(adType, loadSuccess, loadFail);
    return Container(
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
              ImagesWidget(name: "icon_money2",height: 68.h,),
              TextWidget(text: "Get Coins After Watching video！", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
              SizedBox(height: 34.h,),
              Container(
                width: 334.w,
                height: 24.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 2.w,right: 2.w),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(100.w)
                ),
                child: GetBuilder<LoadAdC>(
                  id: "progress",
                  builder: (_)=>Container(
                    width: (334.w)*con.getPro(),
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: "#FFD643".toColor(),
                        borderRadius: BorderRadius.circular(100.w)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h,),
              TextWidget(text: "Watch Ad for 30s", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
            ],
          )
        ],
      ),
    );
  }
}