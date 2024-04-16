import 'package:findword/base/base_p.dart';
import 'package:findword/bean/words_char_bean.dart';
import 'package:findword/page/normal/play/play_c.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/coin/coin_widget.dart';
import 'package:findword/widget/heart/heart_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PlayP extends BaseP<PlayC>{

  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
  );

  @override
  PlayC initC() => PlayC();

  @override
  bool customWidget() => true;

  @override
  Widget contentWidget() => Stack(
    children: [
      bgWidget(),
      Column(
        children: [
          _wordWidget(),
          _chooseWordsWidget(),
          _bottomWidget(),
        ],
      ),
      GetBuilder<PlayC>(
        id: "finger",
        builder: (_)=>Positioned(
          top: con.fingerTop,
          left: con.fingerLeft,
          child: Offstage(
            offstage: !con.showFinger,
            child: InkWell(
              onTap: (){
                con.clickTipsFinger();
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

  _wordWidget()=>SizedBox(
    width: double.infinity,
    height: 400.h,
    child: Stack(
        children: [
          ImagesWidget(name: "play1",width: double.infinity,height: 385.h,fit: BoxFit.fill,),
          SafeArea(
            top: true,
            child: Column(
              children: [
                _topWidget(),
                SizedBox(height: 20.h,),
                _wordsListWidget(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ImagesWidget(name: "home8",width: 120.w,height: 44.h,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImagesWidget(name: "home9",width: 32.w,height: 32.h,),
                    SizedBox(width: 4.w,),
                    GetBuilder<PlayC>(
                      id: "timer",
                      builder: (_)=>TextWidget(
                        text: "${con.answerTimeCount}",
                        size: 17.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
    ),
  );

  _wordsListWidget()=>GetBuilder<PlayC>(
    id: "words_list",
    builder: (_)=>ListView.builder(
      itemCount: con.wordsList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context,index)=>_wordsItemWidget(con.wordsList[index]),
    ),
  );

  _wordsItemWidget(WordsBean wordsBean)=>Container(
    margin: EdgeInsets.only(top: 16.h),
    child: Stack(
      alignment: Alignment.center,
      children: [
        ImagesWidget(name: "play2",width: 398.w,height: 64.h,),
        RichText(
          text: TextSpan(
            children: _getWordsCharItemWidget(wordsBean.charList)
          ),
        )
      ],
    ),
  );

  _getWordsCharItemWidget(List<WordsCharBean> charList){
    List<InlineSpan> list=[];
    for (var value in charList) {
      list.add(
        TextSpan(
          text: value.chars,
          style: TextStyle(
            fontSize: 40.sp,
            color: value.chooseStatus==ChooseStatus.right?"#FFE665".toColor():Colors.white,
            fontWeight: FontWeight.w700
          )
        )
      );
    }
    return list;
  }

  _topWidget()=>Row(
    children: [
      InkWell(
        onTap: (){
          con.clickBack();
        },
        child: Container(
          margin: EdgeInsets.only(left: 16.w),
          child: ImagesWidget(name: "back",width: 32.w,height: 32.h,),
        ),
      ),
      const Spacer(),
      CoinWidget(),
      SizedBox(width: 8.w,),
      HeartWidget(),
      SizedBox(width: 16.w,),
    ],
  );

  _chooseWordsWidget()=>Expanded(
    child: GetBuilder<PlayC>(
      id: "choose_list",
      builder: (_)=>Container(
        margin: EdgeInsets.only(
            left: con.getChooseCharMargin(),
            right: con.getChooseCharMargin(),
            top: 20.h
        ),
        child: StaggeredGridView.countBuilder(
          padding: const EdgeInsets.all(0),
          itemCount: con.wordsChooseList.length,
          shrinkWrap: true,
          crossAxisCount: con.rowsNum,
          mainAxisSpacing: 30.h,
          crossAxisSpacing: 30.w,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index)=>_chooseWordsItemWidget(con.wordsChooseList[index]),
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        ),
      ),
    ),
  );

  _chooseWordsItemWidget(WordsCharBean bean)=> InkWell(
    onTap: (){
      con.clickWordsChar(bean);
    },
    child: AspectRatio(
      aspectRatio: 1,
      key: bean.globalKey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImagesWidget(
              name: bean.chooseStatus==ChooseStatus.normal?
              "btn_normal":
              bean.chooseStatus==ChooseStatus.error?
              "btn_error":
              "btn_right"
          ),
          TextWidget(
            text: bean.chars,
            size: 34.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    ),
  );

  _bottomWidget()=>Container(
    margin: EdgeInsets.only(left: 16.w,bottom: 22.h),
    child: Row(
      children: [
        InkWell(
          onTap: (){
            con.checkShowFinger();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              ImagesWidget(name: "play4",width: 120.w,height: 40.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImagesWidget(name: "play5",width: 32.w,height: 32.h,),
                  SizedBox(width: 6.w,),
                  GetBuilder<PlayC>(
                    id: "tips",
                    builder: (_)=>TextWidget(
                      text: "${UserInfoUtils.instance.userTipsNum}/3",
                      size: 17.sp,
                      color: "#002E63".toColor(),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}