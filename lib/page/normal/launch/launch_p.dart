import 'package:findword/base/base_p.dart';
import 'package:findword/page/normal/launch/launch_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LaunchP extends BaseP<LaunchC>{

  @override
  LaunchC initC() => LaunchC();

  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
  );

  @override
  Widget contentWidget() => Column(
    children: [
      SizedBox(height: 124.h,),
      ImagesWidget(name: "launch2",width: 284.w,height: 112.h,),
      const Spacer(),
      _progressWidget(),
      SizedBox(height: 124.h,),
    ],
  );

  _progressWidget()=>Container(
    width: 334.w,
    height: 24.h,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 2.w,right: 2.w),
    decoration: BoxDecoration(
      color: "#59B0F8".toColor(),
      borderRadius: BorderRadius.circular(100.w)
    ),
    child: GetBuilder<LaunchC>(
      id: "progress",
      builder: (_)=>Container(
        width: (334.w)*con.progress,
        height: 20.h,
        decoration: BoxDecoration(
            color: "#FFD643".toColor(),
            borderRadius: BorderRadius.circular(100.w)
        ),
      ),
    ),
  );
}