import 'package:findword/base/base_p.dart';
import 'package:findword/page/buy/buy_home/buy_home_c.dart';
import 'package:findword/widget/buy_coin/buy_coin_w.dart';
import 'package:findword/widget/heart/heart_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuyHomeP extends BaseP<BuyHomeC>{
  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
    fit: BoxFit.fill,
  );

  @override
  BuyHomeC initC() => BuyHomeC();

  @override
  bool customWidget() => true;

  @override
  Widget contentWidget() => Stack(
    children: [
      bgWidget(),
      SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: GetBuilder<BuyHomeC>(
          id: "home",
          builder: (_)=>Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: con.showIndex,
                  children: con.pageList,
                ),
              ),
              _bottomWidget(),
            ],
          ),
        ),
      ),
      _topWidget(),
    ],
  );

  _bottomWidget()=>SizedBox(
    width: double.infinity,
    height: 122.h,
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: ImagesWidget(name: "bottom_bg",width: double.infinity,height: 96.h,fit: BoxFit.fill,),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _bottomItemWidget(0),
              SizedBox(width: 120.w,),
              _bottomItemWidget(1),
            ],
          ),
        )
      ],
    ),
  );

  _bottomItemWidget(index)=>InkWell(
    onTap: (){
      con.clickTab(index);
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImagesWidget(
          name: index==0?"tab_word":"tab_cash",
          width: index==con.showIndex?64.w:44.w,
          height: index==con.showIndex?64.w:44.w,
        ),
        TextWidget(text: index==0?"Word":"Cash", size: 15.sp, color: Colors.white,fontWeight: FontWeight.w700,)
      ],
    ),
  );
  
  _topWidget()=>SafeArea(
    top: true,
    child: Row(
      children: [
        SizedBox(width: 8.w,),
        BuyCoinW(),
        SizedBox(width: 8.w,),
        HeartWidget(),
        const Spacer(),
        InkWell(
          onTap: (){
            con.clickSet();
          },
          child: ImagesWidget(name: "home3",width: 32.w,height: 32.h,),
        ),
        SizedBox(width: 16.w,),
      ],
    ),
  );
}