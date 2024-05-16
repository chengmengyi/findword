import 'package:findword/base/base_p.dart';
import 'package:findword/page/normal/set/set_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetP extends BaseP<SetC>{
  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
  );

  @override
  SetC initC() => SetC();

  @override
  Widget contentWidget() => Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: (){
            RoutersUtils.off();
          },
          child: Container(
            margin: EdgeInsets.all(16.w),
            child: ImagesWidget(name: "back",width: 32.w,height: 32.h,),
          ),
        ),
      ),
      _itemWidget(0),
      _itemWidget(1),
      _itemWidget(2),

      InkWell(
        onTap: (){
          UserInfoUtils.instance.updateUserCoinNum(100000);
        },
        child: TextWidget(text: "价钱", size: 30.sp, color: Colors.white),
      ),
    ],
  );
  
  _itemWidget(index)=>InkWell(
    onTap: (){
      con.clickItem(index);
    },
    child: Container(
      width: 398.w,
      height: 65.h,
      margin: EdgeInsets.only(top: 16.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(name: "set1",width: 398.w,height: 64.h,fit: BoxFit.fill,),
          Row(
            children: [
              SizedBox(width: 16.w,),
              TextWidget(
                text: index==0?"Privacy Policy":index==1?"Term of  User":"Contact us",
                size: 20.sp,
                color: Colors.white,fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              ImagesWidget(name: "right",width: 24.w,height: 24.h,),
              SizedBox(width: 16.w,),
            ],
          )
        ],
      ),
    ),
  );
}