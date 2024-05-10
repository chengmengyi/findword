import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/guide/new_user_guide_step.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CheckInGuideOverlay extends StatelessWidget{
  Offset offset;
  Function() click;
  CheckInGuideOverlay({required this.offset,required this.click});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: InkWell(
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
                  click.call();
                  },
                child: Stack(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ImagesWidget(name: "btn2",width: 96.w,height: 32.h,),
                        TextWidget(
                          text: "Check-in",
                          size: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                    Lottie.asset(
                      "asset/figer.zip",
                      width: 80.w,
                      height: 80.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}