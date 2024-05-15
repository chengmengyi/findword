import 'package:findword/utils/utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BubbleGuideOverlay extends StatelessWidget{
  Offset offset;
  Function() click;
  BubbleGuideOverlay({required this.offset,required this.click});

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
              right: ScreenUtil().screenWidth-offset.dx-64.w,
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
                      width: 64.w,
                      height: 64.h,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: offset.dy,
              right: 0,
              child: InkWell(
                onTap: (){
                  click.call();
                },
                child: Lottie.asset(
                  "asset/figer.zip",
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}