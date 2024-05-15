import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/up_level/up_level_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/buy_coin/buy_coin_w.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UpLevelD extends BaseD<UpLevelC>{
  Function() closeDialog;
  UpLevelD({required this.closeDialog});

  @override
  UpLevelC initC() => UpLevelC();

  // @override
  // bool custom() => true;

  @override
  Widget contentWidget() => Stack(
    children: [
      Lottie.asset(
          "asset/caidai.json",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _levelWidget(),
          _moneyWidget(),
          _progressWidget(),
          SizedBox(height: 20.h,),
          _btnWidget(),
        ],
      ),
      // Column(
      //   children: [
      //     _topWidget(),
      //     Expanded(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           _levelWidget(),
      //           _moneyWidget(),
      //           _progressWidget(),
      //           SizedBox(height: 20.h,),
      //           _btnWidget(),
      //         ],
      //       ),
      //     )
      //   ],
      // )
    ],
  );

  _topWidget()=>Row(
    children: [
      SizedBox(width: 10.w,),
      BuyCoinW(),
      const Spacer(),
      CloseWidget(clickCall: (){RoutersUtils.off();}),
    ],
  );

  _levelWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(left: 16.w,right: 16.w),
        child: ImagesWidget(name: "level1",width: double.infinity,height: 48.h,fit: BoxFit.fill,),
      ),
      StrokedTextWidget(
          text: "Level ${UserInfoUtils.instance.userLevel+1}",
          fontSize: 50.sp,
          textColor: Colors.white,
          strokeColor: "#C35E00".toColor(),
          strokeWidth: 1.w
      ),
    ],
  );

  _moneyWidget()=>SizedBox(
    width: 260.w,
    height: 260.w,
    child: Stack(
      children: [
        Lottie.asset("asset/light.zip",width: 260.w,height: 260.w,fit: BoxFit.fill),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 16.w),
            child: TextWidget(text: "Congratulations on reaching level ${UserInfoUtils.instance.userLevel+1}", size: 13.sp, color: Colors.white),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ImagesWidget(name: "icon_money2",width: 100.w,height: 100.w,),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 22.w),
            child: StrokedTextWidget(
                text: "+${con.addNum} ≈ \$${ValueUtils.instance.getCoinToMoney(con.addNum)}",
                fontSize: 28.sp,
                textColor: "#D5FF65".toColor(),
                strokeColor: "#116508".toColor(),
                strokeWidth: 1.w
            ),
          ),
        )
      ],
    ),
  );

  _progressWidget()=>Stack(
    alignment: Alignment.centerRight,
    children: [
      Stack(
        alignment: Alignment.center ,
        children: [
          Container(
            width: 334.w,
            height: 24.h,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(right: 22.w),
            padding: EdgeInsets.only(left: 2.w,right: 2.w),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.w)
            ),
            child: Container(
              width: (330.w)*con.getLevelPro(),
              height: 20.h,
              decoration: BoxDecoration(
                  color: "#FFD643".toColor(),
                  borderRadius: BorderRadius.circular(100.w)
              ),
            ),
          ),
          StrokedTextWidget(
              text: "${UserInfoUtils.instance.userLevel%5+1}/5 level",
              fontSize: 13.sp,
              textColor: Colors.white,
              strokeColor: "#520004".toColor(),
              strokeWidth: 1.w
          ),
        ],
      ),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ImagesWidget(name: "sign5",width: 48.w,height: 48.w,),
          GetBuilder<UpLevelC>(
            id: "time",
            builder: (_)=>StrokedTextWidget(
                text: con.countDownTime,
                fontSize: 13.sp,
                textColor: Colors.white,
                strokeColor: "#D35900".toColor(),
                strokeWidth: 1.w
            ),
          ),
        ],
      )
    ],
  );

  _btnWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      BtnWidget(
          text: "Claim Double",
          clickCall: (){
            con.clickDouble(closeDialog);
          }),
      SizedBox(height: 10.h,),
      BtnWidget(
        text: "Level ${UserInfoUtils.instance.userLevel+1}",
        clickCall: (){
          con.clickClose(closeDialog,close: true);
        },
        bg: "btn",
      ),
    ],
  );
}