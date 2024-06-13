import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BubbleGuideOverlay extends StatelessWidget{
  Function() click;
  BubbleGuideOverlay({required this.click});

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
              right: 30.w,
              top: 100.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.w)
                    ),
                    child: TextWidget(
                      text: "Collect 10 cash bubbles,\nGet \$10",
                      size: 15.sp,
                      color: "#002E63".toColor(),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      click.call();
                    },
                    child: ImagesWidget(
                      name: "bubble",
                      width: 100.w,
                      height: 100.h,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 100.h,
              right: 0,
              child: InkWell(
                onTap: (){
                  click.call();
                },
                child: Lottie.asset(
                  "asset/figer.zip",
                  width: 120.w,
                  height: 120.h,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}