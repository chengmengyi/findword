import 'package:findword/base/base_c.dart';
import 'package:findword/base/base_p.dart';
import 'package:findword/page/normal/home/home_c.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/words/words_enum.dart';
import 'package:findword/widget/coin/coin_widget.dart';
import 'package:findword/widget/heart/heart_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeP extends BaseP<HomeC>{

  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
  );

  @override
  HomeC initC() => HomeC();

  @override
  Widget contentWidget() => Column(
    children: [
      _topWidget(),
      SizedBox(height: 60.w,),
      ImagesWidget(name: "home4",width: 284.w,height: 112.h),
      _centerWidget(),
      SizedBox(height: 60.w,),
      _playBtnWidget(),
    ],
  );

  _centerWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      Container(
        margin: EdgeInsets.only(top: 28.h),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ImagesWidget(name: "home6",width: 398.w,height: 316.h,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _itemWidget(WordsEnum.easy),
                _itemWidget(WordsEnum.middle),
                _itemWidget(WordsEnum.high),
              ],
            )
          ],
        ),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(name: "home5",width: 270.w,height: 56.h,),
          TextWidget(text: "Challenge", size: 28.sp, color: "#FFFFFF".toColor(),fontWeight: FontWeight.w700,)
        ],
      ),

    ],
  );

  _itemWidget(WordsEnum wordsEnum)=>InkWell(
    onTap: (){
      con.toPlay(wordsEnum);
    },
    child: Container(
      width: 366.w,
      height: 68.h,
      margin: EdgeInsets.only(top: 16.h),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ImagesWidget(name: "home7",width: 366.w,height: 68.h,),
          Row(
            children: [
              SizedBox(width: 8.w,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: wordsEnum==WordsEnum.easy?"Easy":wordsEnum==WordsEnum.middle?"Middle":"High",
                    size: 17.sp,
                    color: "#FFFFFF".toColor(),
                    fontWeight: FontWeight.w700,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: _getStarWidget(wordsEnum),
                  )
                ],
              ),
              const Spacer(),
              Container(
                width: 80.w,
                height: 44.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.w),
                    gradient: LinearGradient(
                        colors: ["#FF9900".toColor(),"#FFE665".toColor()],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    ),
                    border: Border.all(
                        width: 1.w,
                        color: "#B75800".toColor()
                    )
                ),
                child: TextWidget(
                  text: "Go",
                  size: 20.sp,
                  color: "#FFFFFF".toColor(),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w,),
            ],
          )
        ],
      ),
    ),
  );

  _playBtnWidget()=>InkWell(
    onTap: (){
      con.toPlay(WordsEnum.easy);
    },
    child: Container(
      width: 302.w,
      height: 72.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        gradient: LinearGradient(
          colors: ["#08BE0D".toColor(),"#CEFF65".toColor()],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: TextWidget(text: "Play", size: 28.sp, color: Colors.white,fontWeight: FontWeight.w700,),
    ),
  );

  _topWidget()=>Row(
    children: [
      SizedBox(width: 8.w,),
      CoinWidget(),
      SizedBox(width: 8.w,),
      HeartWidget(),
      const Spacer(),
      InkWell(
        onTap: (){
          con.toSet();
        },
        child: ImagesWidget(name: "home3",width: 32.w,height: 32.h,),
      ),
      SizedBox(width: 16.w,)
    ],
  );

  List<Widget> _getStarWidget(WordsEnum wordsEnum){
    List<Widget> list=[
      TextWidget(
        text: "difficulty：",
        size: 17.sp,
        color: "#FFFFFF".toColor(),
      ),
    ];
    for(int i=0;i<(wordsEnum==WordsEnum.easy?2:wordsEnum==WordsEnum.middle?3:4);i++){
      list.add(ImagesWidget(name: "star",width: 24.w,height: 24.h,));
    }
    return list;
  }
}