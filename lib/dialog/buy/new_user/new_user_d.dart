import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/new_user/new_user_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/light_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NewUserD extends BaseD<NewUserC>{
  @override
  NewUserC initC() => NewUserC();

  @override
  Widget contentWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      CloseWidget(
        clickCall: (){
          con.clickClose();
        },
      ),
      Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            child: ImagesWidget(
              name: "dialog_bg2",
              width: double.infinity,
              height: 532.h,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 32.w,right: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _topWidget(),
                SizedBox(height: 10.h,),
                _payListWidget(),
                SizedBox(height: 20.h,),
                InkWell(
                  onTap: (){
                    con.clickClaim();
                  },
                  child: Lottie.asset(
                    "asset/button.zip",
                    width: 300.w,
                    height: 80.w,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    ],
  );

  _topWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 10.h,),
      ImagesWidget(name: "new_user1",height: 83.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImagesWidget(name: "new1",width: 24.w,height: 24.h,),
          SizedBox(width: 5.w,),
          StrokedTextWidget(
            text: "Pending Withdrawal Amount",
            fontSize: 17.sp,
            textColor: Colors.white,
            strokeColor: "#8B3B01".toColor(),
            strokeWidth: 2.w,
          )
        ],
      ),
      SizedBox(height: 30.h,),
      ImagesWidget(name: "new_user2",width: double.infinity,height: 120.h,),
      StrokedTextWidget(
          text: "\$${ValueUtils.instance.getCoinToMoney(con.addNum)}",
          fontSize: 28.sp,
          textColor: "#3DFF39".toColor(),
          strokeColor: "#053400".toColor(),
          strokeWidth: 1.w
      )
    ],
  );
  
  _payListWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(text: "You can withdraw money to", size: 17.sp, color: "#8C3B00".toColor(),fontWeight: FontWeight.w700,),
      SizedBox(height: 6.h,),
      SizedBox(
        width: double.infinity,
        height: 56.h,
        child: GetBuilder<NewUserC>(
          id: "pay_list",
          builder: (_)=>ListView.builder(
            itemCount: con.payList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index)=>Container(
              margin: EdgeInsets.only(right: 8.w),
              child: InkWell(
                onTap: (){
                  con.clickPay(index);
                },
                child: Stack(
                  children: [
                    ImagesWidget(
                      name: index==con.payIndex?"new_user3":"new_user4",
                      width: 140.w,
                      height: 56.h,
                      fit: BoxFit.fill,
                    ),
                    ImagesWidget(name: con.payList[index],width: 140.w,height: 56.h,fit: BoxFit.fill,),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}