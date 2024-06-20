import 'package:findword/base/base_w.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/buy_coin/buy_coin_c.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuyCoinW extends BaseW<BuyCoinC>{
  @override
  BuyCoinC initC() => BuyCoinC();

  @override
  Widget contentWidget() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        height: 32.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            gradient: LinearGradient(
                colors: ["#D6FAFF".toColor(),"#B0F6FF".toColor()],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImagesWidget(name: "icon_money1",width: 32.w,height: 32.w,),
            SizedBox(width: 8.w,),
            GetBuilder<BuyCoinC>(
              id: "coin",
              builder: (_)=>TextWidget(
                text: "\$${UserInfoUtils.instance.userMoney}",
                size: 15.sp,
                color: "#002E63".toColor(),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 8.w,),
            GetBuilder<BuyCoinC>(
              id: "cash",
              builder: (_)=>Offstage(
                offstage: !con.showCash,
                child: InkWell(
                  onTap: (){
                    con.clickCash();
                  },
                  child: Container(
                    width: 64.w,
                    height: 22.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: ["#009004".toColor(),"#CEFF65".toColor()]
                        ),
                        borderRadius: BorderRadius.circular(6.w),
                        border: Border.all(
                            width: 1.w,
                            color: "#009004".toColor()
                        )
                    ),
                    child: TextWidget(
                      text: "Cash",
                      size: 17.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w,),
          ],
        ),
      ),
      SizedBox(
        width: 180.w,
        height: 46.h,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            ImagesWidget(name: "home",width: 180.w,height: 46.h,fit: BoxFit.fill,),
            Container(
              margin: EdgeInsets.only(left: 12.w),
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "earn another",
                          style: TextStyle(
                              color: "#000000".toColor()
                          )
                      ),
                      TextSpan(
                          text: " \$${con.getCashProgress()} ",
                          style: TextStyle(
                              color: "#DE3500".toColor()
                          )
                      ),
                      TextSpan(
                          text: "to reach",
                          style: TextStyle(
                              color: "#000000".toColor()
                          )
                      ),
                      TextSpan(
                          text: "  \$500",
                          style: TextStyle(
                              color: "#DE3500".toColor()
                          )
                      ),
                      TextSpan(
                          text: "!",
                          style: TextStyle(
                              color: "#000000".toColor()
                          )
                      ),
                    ]
                ),
              ),
            )
          ],
        ),
      )
    ],
  );
}