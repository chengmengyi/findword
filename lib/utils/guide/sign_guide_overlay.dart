import 'dart:ui';

import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/sign_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SignGuideOverlay extends StatelessWidget{
  Offset offset;
  Size? size;
  int addNum;
  int index;
  Function() click;
  SignGuideOverlay({
    required this.offset,
    required this.size,
    required this.addNum,
    required this.index,
    required this.click
  });

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(
      onTap: (){
        // GuideUtils.instance.hideOverlay();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: "#000000".toColor().withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              // child: InkWell(
              //   onTap: (){
              //     click.call();
              //   },
              //   child: Lottie.asset(
              //     "asset/figer.zip",
              //     width: 200.w,
              //     height: 200.h,
              //   ),
              // ),
              child: InkWell(
                onTap: (){
                  click.call();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    index<6?_sign6ItemWidget():_sign7ItemWidget(),
                    Lottie.asset(
                        "asset/figer.zip",
                        height: 101
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );


  _sign6ItemWidget()=>SizedBox(
    width: size?.width??101,
    height: size?.height??101,
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
              name: "icon_money2",
              width: 48.w,
              height: 48.w,
            ),
            StrokedTextWidget(
                text: "+$addNum",
                fontSize: 13.sp,
                textColor: SignUtils.instance.signDays>index?Colors.white.withOpacity(0.5):Colors.white,
                strokeColor: index%2==0?"#B70063".toColor():"#D35900".toColor(),
                strokeWidth: 1.w
            )
          ],
        )
      ],
    ),
  );

  _sign7ItemWidget()=>SizedBox(
    width: size?.width??319,
    height: size?.height??111,
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
                text: "+$addNum",
                fontSize: 13.sp,
                textColor: SignUtils.instance.signDays>index?Colors.white.withOpacity(0.5):Colors.white,
                strokeColor: "#B70063".toColor(),
                strokeWidth: 1.w
            )
          ],
        )
      ],
    ),
  );
}