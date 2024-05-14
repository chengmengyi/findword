import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentSuccessDialog extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: Center(
      child: Container(
        width: double.infinity,
        height: 342.h,
        margin: EdgeInsets.only(left: 16.w,right: 16.w),
        child: Stack(
          children: [
            ImagesWidget(name: "comment_success", width: double.infinity, height: 342.h,fit: BoxFit.fill,),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 12.h),
                child: TextWidget(text: "Evaluate", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(left: 16.w,right: 16.w,bottom: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagesWidget(name: "comment_success2",width: 88.w,height: 88.h,),
                    TextWidget(text: "thanks for your feedback", size: 17.sp, color: Colors.white,fontWeight: FontWeight.w700,),
                    SizedBox(height: 32.h,),
                    BtnWidget(
                        text: "ok",
                        clickCall: (){
                          RoutersUtils.off();
                        }),
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