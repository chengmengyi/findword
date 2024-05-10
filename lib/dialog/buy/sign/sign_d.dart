import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/sign/sign_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignD extends BaseD<SignC>{

  @override
  SignC initC() => SignC();

  @override
  Widget contentWidget() => Stack(
    children: [
      _topWidget(),
      _contentWidget(),
    ],
  );

  _topWidget()=>SizedBox(
    width: double.infinity,
    height: 188.h,
    child: Stack(
      children: [
        ImagesWidget(
          name: "sign1",
          width: double.infinity,
          height: 188.h,
          fit: BoxFit.fill,
        ),
        CloseWidget(clickCall: (){RoutersUtils.off();}),
      ],
    ),
  );
  
  _contentWidget()=>Container(
    margin: EdgeInsets.only(top: 135.h,left: 16.w,right: 16.w),
    child: SizedBox(
      width: double.infinity,
      height: 540.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ImagesWidget(
            name: "sign2",
            width: double.infinity,
            height: 540.h,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              SizedBox(height: 15.h,),
              _textWidget(),
              _listWidget(),
            ],
          )
        ],
      ),
    ),
  );

  _listWidget()=>Expanded(
    child: Container(
      margin: EdgeInsets.all(16.w),
      child: GetBuilder<SignC>(
        id: "list",
        builder: (_)=>StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(0),
          itemCount: 7,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=>index==6?_sign7ItemWidget(index):_sign6ItemWidget(index),
          staggeredTileBuilder: (int index) => index==6?const StaggeredTile.fit(3):const StaggeredTile.fit(1),
        ),
      ),
    ),
  );

  _sign6ItemWidget(index)=>InkWell(
    onTap: (){
      con.clickSign(index);
    },
    child: AspectRatio(
      aspectRatio: 1,
      key: con.globalList[index],
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(
            name: index%2==0?"sign3":"sign4",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text: "Day ${index+1}",
                size: 13.sp,
                color: index%2==0?"#B70063".toColor():"#D35900".toColor(),
                fontWeight: FontWeight.w700,
              ),
              ImagesWidget(
                name: SignUtils.instance.signDays>index?"sign8":"icon_money2",
                width: 48.w,
                height: 48.w,
              ),
              StrokedTextWidget(
                  text: "+${con.signList[index]}",
                  fontSize: 13.sp,
                  textColor: SignUtils.instance.signDays>index?Colors.white.withOpacity(0.5):Colors.white,
                  strokeColor: index%2==0?"#B70063".toColor():"#D35900".toColor(),
                  strokeWidth: 1.w
              )
            ],
          )
        ],
      ),
    ),
  );

  _sign7ItemWidget(index)=>InkWell(
    onTap: (){
      con.clickSign(index);
    },
    child: SizedBox(
      width: double.infinity,
      height: 128.h,
      key: con.globalList[index],
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(name: "sign6",width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text: "Day ${index+1}",
                size: 13.sp,
                color: "#B70063".toColor(),
                fontWeight: FontWeight.w700,
              ),
              SignUtils.instance.signDays>index?
              ImagesWidget(
                name: "sign8",
                width: 48.w,
                height: 48.w,
              ):
              ImagesWidget(name: "sign7",width: 140.w,height: 64.h,),
              StrokedTextWidget(
                  text: "+${con.signList.last}",
                  fontSize: 13.sp,
                  textColor: SignUtils.instance.signDays>index?Colors.white.withOpacity(0.5):Colors.white,
                  strokeColor: "#B70063".toColor(),
                  strokeWidth: 1.w
              )
            ],
          )
        ],
      ),
    ),
  );

  _textWidget()=>Container(
    width: double.infinity,
    height: 120.h,
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StrokedTextWidget(
            text: "Daily Rewards",
            fontSize: 23.sp,
            textColor: Colors.white,
            strokeColor: "#D35900".toColor(),
            strokeWidth: 1.w
        ),
        StrokedTextWidget(
            text: "Sign in for 7 consecutive days to get \$100",
            fontSize: 15.sp,
            textColor: Colors.white,
            strokeColor: "#D35900".toColor(),
            strokeWidth: 1.w
        ),
      ],
    ),
  );
}