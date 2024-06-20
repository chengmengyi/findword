import 'dart:math';

import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BoxGuideOverlay extends StatelessWidget{
  Offset offset;
  Function() call;
  BoxGuideOverlay({required this.offset,required this.call});

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
              child: InkWell(
                onTap: (){
                  GuideUtils.instance.hideOverlay();
                  call.call();
                },
                child: ImagesWidget(name: "icon_box",width: 64.w,height: 64.w,),
              ),
            ),
            Positioned(
              top: offset.dy-20.h,
              right: 0,
              child: InkWell(
                onTap: (){
                  GuideUtils.instance.hideOverlay();
                  call.call();
                },
                child: Transform.scale(
                  scaleX: -1,
                  child: Lottie.asset(
                      "asset/figer.zip",
                      width: 200.w,
                      height: 200.w,
                      fit: BoxFit.fill
                  ),
                )
              ),
            )
          ],
        ),
      ),
    ),
  );
}