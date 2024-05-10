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
              name: "dialog_bg",
              width: double.infinity,
              height: 576.h,
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
                SizedBox(height: 30.h,),
                _payListWidget(),
                SizedBox(height: 20.h,),
                BtnWidget(
                    text: "Claim Double",
                    clickCall: (){
                      con.clickClaim();
                    }
                )
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
      TextWidget(
        text: "Newbie Rewards",
        size: 28.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(height: 44.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImagesWidget(name: "new1",width: 24.w,height: 24.h,),
          TextWidget(text: "pending withdrawal amount", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,)
        ],
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
                  text: "\$${ValueUtils.instance.getCoinToMoney(con.addNum)}",
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
  
  _payListWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextWidget(text: "You can withdraw money to", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
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
                    ImagesWidget(name: con.payList[index],width: 140.w,height: 56.h,fit: BoxFit.fill,),
                    Offstage(
                      offstage: index==con.payIndex,
                      child: ImagesWidget(
                        name: "new3",
                        width: 140.w,
                        height: 56.h,
                        fit: BoxFit.fill,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    )
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