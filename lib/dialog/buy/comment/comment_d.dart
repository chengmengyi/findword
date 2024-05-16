import 'package:findword/base/base_d.dart';
import 'package:findword/dialog/buy/comment/comment_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/btn_widget.dart';
import 'package:findword/widget/close_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CommentD extends BaseD<CommentC>{
  @override
  CommentC initC() => CommentC();

  @override
  Widget contentWidget() => Stack(
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CloseWidget(clickCall: (){RoutersUtils.off();}),
          Container(
            width: double.infinity,
            height: 460.h,
            margin: EdgeInsets.only(left: 16.w,right: 16.w),
            child: Stack(
              children: [
                ImagesWidget(name: "comment1", width: double.infinity, height: 460.h,fit: BoxFit.fill,),
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
                        StrokedTextWidget(
                            text: "Evaluate",
                            fontSize: 28.sp,
                            textColor: Colors.white,
                            strokeColor: "#002E63".toColor(),
                            strokeWidth: 2.w
                        ),
                        StrokedTextWidget(
                            text: "Give Us A Good Review",
                            fontSize: 15.sp,
                            textColor: Colors.white,
                            strokeColor: "#002E63".toColor(),
                            strokeWidth: 2.w
                        ),
                        SizedBox(height: 4.h,),
                        ImagesWidget(name: "comment2",width: 88.w,height: 88.h,),
                        SizedBox(height: 16.h,),
                        SizedBox(
                          height: 40.h,
                          child: GetBuilder<CommentC>(
                            id: "star",
                            builder: (_)=>ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)=>InkWell(
                                onTap: (){
                                  con.clickStar(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 6.w,right: 6.w),
                                  child: ImagesWidget(
                                    name: con.starNum>=index?"start2":"start1",
                                    width: 36.w,
                                    height: 36.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWidget(text: "Complete reviews earn 5000", size: 15.sp, color: Colors.white.withOpacity(0.7),fontWeight: FontWeight.w700,),
                            SizedBox(width: 4.w,),
                            ImagesWidget(name: "icon_money2",width: 24.w,height: 24.w,)
                          ],
                        ),
                        SizedBox(height: 32.h,),
                        BtnWidget(
                            text: "Give 5 Stars",
                            clickCall: (){
                              con.clickStar(4);
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      Positioned(
        right: 40.w,
        bottom: 90.h,
        child: GetBuilder<CommentC>(
          id: "finger",
          builder: (_)=>Offstage(
            offstage: !con.showFinger,
            child: InkWell(
              onTap: (){
                con.clickStar(4);
              },
              child: Lottie.asset(
                "asset/figer.zip",
                width: 120.w,
                height: 120.h,
              ),
            ),
          ),
        ),
      )
    ],
  );
}