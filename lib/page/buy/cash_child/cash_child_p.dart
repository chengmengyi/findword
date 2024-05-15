import 'package:findword/base/base_w.dart';
import 'package:findword/page/buy/cash_child/cash_child_c.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CashChildP extends BaseW<CashChildC>{
  @override
  CashChildC initC() => CashChildC();

  @override
  Widget contentWidget() => SafeArea(
    top: true,
    child: Container(
      padding: EdgeInsets.only(left: 16.w,right: 16.w),
      child: SingleChildScrollView(
        child: GetBuilder<CashChildC>(
          id: "page",
          builder: (_)=>Column(
            children: [
              SizedBox(height: 50.h,),
              _topWidget(),
              SizedBox(height: 16.h,),
              _moneyWidget(),
              SizedBox(height: 16.h,),
              _cashTypeListWidget(),
              SizedBox(height: 16.h,),
              _cashNumWidget(),
              _taskWidget(),
              SizedBox(height: 16.h,),
              _withdrawBtnWidget(),
            ],
          ),
        ),
      ),
    ),
  );
  
  _topWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      ImagesWidget(name: "cash1",height: 32.h,),
      StrokedTextWidget(text: "1*****121  user just cashed out \$300",
          fontSize: 13.sp,
          textColor: Colors.white,
          strokeColor: "#520004".toColor(),
          strokeWidth: 1.w
      )
    ],
  );
  
  _moneyWidget()=>SizedBox(
    width: double.infinity,
    height: 160.h,
    child: Stack(
      children: [
        ImagesWidget(name: "cash_bg${con.payTypeIndex+1}",width: double.infinity,height: 160.h,fit: BoxFit.fill,),
        Container(
          margin: EdgeInsets.only(left: 16.w,top: 8.w),
          child: StrokedTextWidget(
              text: "My Cash",
              fontSize: 17.sp,
              textColor: Colors.white,
              strokeColor: "#002E63".toColor(),
              strokeWidth: 1.w
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImagesWidget(name: "icon_money2",width: 56.w,height: 56.h,),
              SizedBox(width: 2.w,),
              GetBuilder<CashChildC>(
                id: "money",
                builder: (_)=>StrokedTextWidget(
                    text: "\$${ValueUtils.instance.getCoinToMoney(UserInfoUtils.instance.userCoinNum)}",
                    fontSize: 48.sp,
                    textColor: Colors.white,
                    strokeColor: "#002E63".toColor(),
                    strokeWidth: 1.w
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 2.w),
            child: ImagesWidget(name: "cash2",height: 32.h,),
          ),
        )
      ],
    ),
  );

  _cashTypeListWidget()=>SizedBox(
    width: double.infinity,
    height: 56.h,
    child: ListView.builder(
      itemCount: con.payTypeList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index)=>Container(
        margin: EdgeInsets.only(right: 8.w),
        child: InkWell(
          onTap: (){
            con.clickPayType(index);
          },
          child: Stack(
            children: [
              ImagesWidget(name: con.payTypeList[index],width: 140.w,height: 56.h,fit: BoxFit.fill,),
              Offstage(
                offstage: index==con.payTypeIndex,
                child: ImagesWidget(
                  name: "new3",
                  width: 140.w,
                  height: 56.h,
                  fit: BoxFit.fill,
                  color: Colors.black.withOpacity(0.4),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

  _cashNumWidget()=>SizedBox(
    width: double.infinity,
    height: 176.w,
    child: ListView.builder(
      itemCount: con.cashNumList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,index)=>_cashNumItemWidget(con.cashNumList[index],index),
    ),
  );

  _cashNumItemWidget(int num,index)=>InkWell(
    onTap: (){
      con.clickCashNum(index);
    },
    child: Container(
      margin: EdgeInsets.only(right: 8.w),
      width: 176.w,
      height: 176.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(name: "cash3",width: 176.w,height: 176.w,fit: BoxFit.fill,),
          Offstage(
            offstage: con.cashNumIndex!=index,
            child: ImagesWidget(name: "cash5",width: 176.w,height: 176.w,fit: BoxFit.fill,),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 8.w),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ImagesWidget(name: "cash_num${con.payTypeIndex+1}",width: 160.w,),
                  TextWidget(text: "\$$num", size: 30.sp, color: "#002E63".toColor(),fontWeight: FontWeight.w700,),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImagesWidget(name: "icon_money2",width: 32.w,height: 32.w,),
                      SizedBox(width: 4.w,),
                      TextWidget(text: "${UserInfoUtils.instance.userCoinNum}", size: 17.sp, color: "#000000".toColor(),fontWeight: FontWeight.w700,),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 160.w,
                        height: 16.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 2.w,right: 2.w),
                        decoration: BoxDecoration(
                            color: "#000000".toColor().withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12.w)
                        ),
                        child: Container(
                          width: (156.w)*con.getCashPro(num),
                          height: 12.h,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: ["#08BE0D".toColor(),"#CEFF65".toColor(),"#08BE0D".toColor(),],
                              ),
                              borderRadius: BorderRadius.circular(16.w)
                          ),
                        ),
                      ),
                      TextWidget(
                        text: "${UserInfoUtils.instance.userCoinNum}/${ValueUtils.instance.getMoneyToCoin(num)}",
                        size: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );

  _taskWidget()=>Container(
    width: double.infinity,
    height: 104.h,
    margin: EdgeInsets.only(top: 4.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.w),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: ["#B0F6FF".toColor(),"#D6FAFF".toColor()],
      ),
      border: Border.all(
        width: 1.w,
        color: "#00B1C8".toColor()
      )
    ),
    child: ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index)=>Container(
        width: double.infinity,
        height: 52.h,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            SizedBox(width: 16.w,),
            TextWidget(
              text: index==0?"Check in for 3 days：":"Collect 10 cash bubbles：",
              size: 15.sp,
              color: "#5F2800".toColor(),
              fontWeight: FontWeight.w700,
            ),
            TextWidget(
              text: index==0?"${SignUtils.instance.signDays}/7":"${UserInfoUtils.instance.bubbleNum}/10",
              size: 15.sp,
              color: "#FF2E00".toColor(),
              fontWeight: FontWeight.w700,
            ),
            const Spacer(),
            InkWell(
              onTap: (){
                con.clickTaskItem(index);
              },
              child: Stack(
                alignment: Alignment.center,
                key: index==0?con.checkInGlobalKey:null,
                children: [
                  ImagesWidget(
                    name: index==0&&SignUtils.instance.todaySign?"btn3":"btn2",
                    width: 96.w,
                    height: 32.h,
                  ),
                  TextWidget(
                    text: index==0?"Check-in":"Go",
                    size: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
            SizedBox(width: 16.w,),
          ],
        ),
      ),
    ),
  );

  _withdrawBtnWidget()=>BtnWidget(
      text: "Withdraw",
      clickCall: (){
        con.clickWithdraw();
      });
}