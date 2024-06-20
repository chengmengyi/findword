import 'package:findword/base/base_w.dart';
import 'package:findword/bean/words_char_bean.dart';
import 'package:findword/dialog/buy/sign/sign_from.dart';
import 'package:findword/enums/click_words_tips_from.dart';
import 'package:findword/page/buy/word_child/word_child_c.dart';
import 'package:findword/utils/guide/guide_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/widget/bubble_widget.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/stroked_text_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WordChildP extends BaseW<WordChildC>{

  @override
  WordChildC initC() => WordChildC();

  @override
  Widget contentWidget() => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Stack(
      children: [
        ImagesWidget(
          name: "play1",
          width: double.infinity,
          height: 380.h,
          fit: BoxFit.fill,
        ),
        _topWidget(),
        _contentWidget(),
        GetBuilder<WordChildC>(
          id: "bubble",
          builder: (_)=>Offstage(
            offstage: !GuideUtils.instance.showBubble,
            child: BubbleWidget(),
          ),
        ),
        _wheelGuideWidget(),
      ],
    ),
  );

  _topWidget()=>SafeArea(
    top: true,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 100.h,),
        Stack(
          alignment: Alignment.center,
          children: [
            ImagesWidget(name: "level_bg",width: 270.w,height: 56.h,),
            GetBuilder<WordChildC>(
              id: "level",
              builder: (_)=>StrokedTextWidget(
                  text: "Level ${UserInfoUtils.instance.userLevel}",
                  fontSize: 28.sp,
                  textColor: Colors.white,
                  strokeColor: "#C35E00".toColor(),
                  strokeWidth: 1.w
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h,),
        Container(
          margin: EdgeInsets.only(left: 16.w,right: 16.w),
          child: GetBuilder<WordChildC>(
            id: "words_list",
            builder: (_)=> StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(0),
              itemCount: con.currentWordsBean?.word?.length??0,
              shrinkWrap: true,
              crossAxisCount: 5,
              mainAxisSpacing: 8.w,
              crossAxisSpacing: 8.w,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=>_wordsItemWidget(index),
              staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
            ),
          ),
        ),
      ],
    ),
  );
  
  _wordsItemWidget(int index){
    var wordsBean = con.getHintWordsByIndex(index);
    return Container(
      margin: EdgeInsets.only(left: 4.w,right: 4.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ImagesWidget(
              // name: "new_words1",
              name: null==wordsBean?
              "new_words3":
              wordsBean.chooseStatus==ChooseStatus.error ?
              "new_words2":
              "new_words1",
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          StrokedTextWidget(
            text: wordsBean?.words??"",
            fontSize: 48.sp,
            textColor: Colors.white,
            strokeColor: "#009004".toColor(),
            strokeWidth: 2.w,
          )
        ],
      ),
    );
  }
  
  _wordItemWidget(WordsBean wordsBean)=>Stack(
    alignment: Alignment.center,
    children: [
      ImagesWidget(
        name: wordsBean.isRight?"word2":"word1",
        width: double.infinity,
        height: 64.h,
        fit: BoxFit.fill,
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: _getWordsCharItemWidget(wordsBean),
      ),
    ],
  );

  List<Widget> _getWordsCharItemWidget(WordsBean wordsBean){
    List<Widget> list=[];
    for (var value in wordsBean.charList) {
      list.add(
          StrokedTextWidget(
              text: value.chars,
              fontSize: 28.sp,
              textColor: value.chooseStatus!=ChooseStatus.right||wordsBean.isRight?Colors.white:"#FFE665".toColor(),
              strokeColor: value.chooseStatus==ChooseStatus.right?"#009004".toColor():"#002E63".toColor(),
              strokeWidth: 1.w
          )
      );
    }
    return list;
  }

  _contentWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 330.h,bottom: 8.h),
    child: Column(
      children: [
        _centerWidget(),
        _chooseWordsWidget(),
        _bottomWidget(),
      ],
    ),
  );

  _chooseWordsWidget()=>Expanded(
    child: GetBuilder<WordChildC>(
      id: "choose_list",
      builder: (_)=>Container(
        height: double.infinity,
        width: double.infinity,
        // margin: EdgeInsets.only(
        //     top: 20.h,
        //     bottom: 20.h
        // ),
        // child: StaggeredGridView.countBuilder(
        //   padding: const EdgeInsets.all(0),
        //   itemCount: con.wordsChooseList.length,
        //   shrinkWrap: true,
        //   crossAxisCount: con.rowsNum,
        //   mainAxisSpacing: 30.h,
        //   crossAxisSpacing: 30.w,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context,index)=>_chooseWordsItemWidget(con.wordsChooseList[index]),
        //   staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
        // ),
        // child: GridView.builder(
        //   scrollDirection: Axis.horizontal,
        //     padding: const EdgeInsets.all(0),
        //     itemCount: con.wordsChooseList.length,
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: con.rowsNum,
        //       mainAxisSpacing: 20.h,
        //       crossAxisSpacing: 20.w,
        //       childAspectRatio: 1
        //     ),
        //     itemBuilder: (context,index)=>_chooseWordsItemWidget(con.wordsChooseList[index])
        // ),
        child: Stack(
          children: [
            Positioned(
              top: 100.h,
              left: 60.w,
              child: _chooseWordsItemWidget2(0),
            ),
            Positioned(
              left: 180.w,
              bottom: 33.h,
              child: _chooseWordsItemWidget2(1),
            ),
            Positioned(
              top: 33.h,
              right: 60.w,
              child: _chooseWordsItemWidget2(2),
            ),
            _fingerTipsWidget(),
          ],
        ),
      ),
    ),
  );

  _chooseWordsItemWidget2(int index){
    var wordsBean = con.getChooseWordsBeanByIndex(index);
    return InkWell(
      onTap: (){
        con.clickWordsChar(wordsBean);
      },
      child: Stack(
        alignment: Alignment.center,
        key: wordsBean?.globalKey,
        children: [
          ImagesWidget(
            name: wordsBean?.chooseStatus==ChooseStatus.normal?
            "btn_normal":
            wordsBean?.chooseStatus==ChooseStatus.right?
            "btn_right":
            "btn_error",
            width: 72.w,
            height: 72.w,
          ),
          StrokedTextWidget(
            text: wordsBean?.words??"",
            fontSize: 48.sp,
            textColor: Colors.white,
            strokeColor: wordsBean?.chooseStatus==ChooseStatus.normal?
            "#B75800".toColor():
            wordsBean?.chooseStatus==ChooseStatus.error?"#DE3500".toColor():
            "#009004".toColor(),
            strokeWidth: 2.w,
          ),
        ],
      ),
    );
  }

  _centerWidget()=>Container(
    width: double.infinity,
    height: 80.h,
    alignment: Alignment.center,
    child: SizedBox(
      width: 334.w,
      height: 80.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ImagesWidget(name: "word3",width: 334.w,height: 80.h,),
          Row(
            children: [
              SizedBox(width: 16.w,),
              SizedBox(
                key: con.wheelGlobalKey,
                child: InkWell(
                  onTap: (){
                    con.clickWheel();
                  },
                  child: ImagesWidget(
                    name: "icon_wheel",
                    width: 48.w,
                    height: 48.h,
                  ),
                ),
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 16.w),
                      child: StrokedTextWidget(
                          text: "Pass 5 Level，Get A Chance To Spin The Wheel",
                          fontSize: 13.sp,
                          textColor: Colors.white,
                          strokeColor: "#C32300".toColor(),
                          strokeWidth: 1.w
                      ),
                    ),
                    GetBuilder<WordChildC>(
                      id: "progress",
                      builder: (_)=>Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 246.w,
                            height: 16.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 2.w,right: 3.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.w),
                                color: "#C32300".toColor()
                            ),
                            //242
                            child: Container(
                              width: 242.w*con.getLevelProgress(),
                              height: 12.h,
                              decoration: BoxDecoration(
                                  color: "#FFD643".toColor(),
                                  borderRadius: BorderRadius.circular(100.w)
                              ),
                            ),
                          ),
                          StrokedTextWidget(
                              text: "${UserInfoUtils.instance.wheelChanceProgress}/5",
                              fontSize: 13.sp,
                              textColor: Colors.white,
                              strokeColor: "#2F0058".toColor(),
                              strokeWidth: 1.w
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );

  _bottomWidget()=>Row(
    children: [
      // SizedBox(width: 16.w,),
      // InkWell(
      //   onTap: (){
      //     con.checkShowFinger(ClickWordsTipsFrom.hint);
      //   },
      //   child: Stack(
      //     alignment: Alignment.center,
      //     children: [
      //       ImagesWidget(name: "play4",width: 120.w,height: 40.h,),
      //       Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           ImagesWidget(name: "play5",width: 32.w,height: 32.h,),
      //           SizedBox(width: 6.w,),
      //           GetBuilder<WordChildC>(
      //             id: "tips",
      //             builder: (_)=>TextWidget(
      //               text: "${UserInfoUtils.instance.userTipsNum}/3",
      //               size: 17.sp,
      //               color: "#002E63".toColor(),
      //               fontWeight: FontWeight.w700,
      //             ),
      //           )
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      const Spacer(),
      GetBuilder<WordChildC>(
        id: "box",
        builder: (_)=>Visibility(
          visible: GuideUtils.instance.showBox,
          key: con.boxGlobalKey,
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          child: InkWell(
            onTap: (){
              RoutersUtils.showSignDialog(SignFrom.other);
            },
            child: ImagesWidget(name: "icon_box",width: 64.w,height: 64.w,),
          ),
        ),
      ),
      SizedBox(width: 16.w,),
    ],
  );

  _fingerTipsWidget()=>GetBuilder<WordChildC>(
    id: "finger",
    builder: (_)=>Positioned(
      top: con.getFingerTop(),
      left: con.getFingerLeft(),
      right: con.getFingerRight(),
      bottom: con.getFingerBottom(),
      child: Offstage(
        offstage: con.tipsIndex==-1,
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
  );

  _wheelGuideWidget()=>GetBuilder<WordChildC>(
    id: "wheel_guide",
    builder: (_)=>Container(
      margin: EdgeInsets.only(top: (con.wheelGuideOffset?.dy??30.w)-30.w,left: 20.w),
      child: Offstage(
        offstage: null==con.wheelGuideOffset,
        child: InkWell(
          onTap: (){
            con.clickWheel();
          },
          child: Lottie.asset(
            "asset/figer.zip",
            width: 200.w,
            height: 200.h,
          ),
        ),
      ),
    ),
  );
}