import 'dart:async';
import 'package:findword/dialog/buy/incent/incent_from.dart';
import 'package:findword/utils/event/event_bean.dart';
import 'package:findword/utils/event/event_name.dart';
import 'package:findword/utils/event/event_utils.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BubbleWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget> with SingleTickerProviderStateMixin{
  GlobalKey globalKey=GlobalKey();
  double width=330.w,currentX=0.0;
  double height=832.h,currentY=0.0;
  Timer? _timer;
  bool right=true,down=true,showGuide=false,showBubble=true;
  late StreamSubscription<EventBean>? _bus;
  var addNum=ValueUtils.instance.getFloatAddNum();

  @override
  void initState() {
    super.initState();
    _bus=EventUtils.getInstance()?.on<EventBean>().listen((event) {
      if(event.eventName==EventName.updateHomeIndex){
        if(event.intValue==0&&event.boolValue==true){
          setState(() {
            showGuide=true;
          });
        }
      }
    });
    Future((){
      var size = globalKey.currentContext?.size;
      if(null!=size){
        width=size.width-100.w;
        height=size.height-100.h;
      }
      _initAnimator();
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: double.infinity,
    key: globalKey,
    child: Stack(
      children: [
        Positioned(
          top: currentY,
          left: currentX,
          child: InkWell(
            onTap: (){
              _clickBubble();
            },
            child: Stack(
              children: [
                Offstage(
                  offstage: !showBubble,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ImagesWidget(
                        name: "bubble",
                        width: 100.w,
                        height: 100.h,
                      ),
                      TextWidget(text: "\$${ValueUtils.instance.getCoinToMoney(addNum)}", size: 20.sp, color: Colors.white,fontWeight: FontWeight.w900,)
                    ],
                  ),
                ),
                Offstage(
                  offstage: !showGuide,
                  child: Lottie.asset(
                    "asset/figer.zip",
                    width: 120.w,
                    height: 120.h,
                  ),
                ),
              ],
            )
          ),
        ),
      ],
    ),
  );

  _initAnimator(){
    _timer=Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if(right){
        currentX++;
        if(down){
          currentY++;
          if(currentY>=height){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX>=width){
          right=false;
        }
      }else{
        currentX--;
        if(down){
          currentY++;
          if(currentY>=height){
            down=false;
          }
        }else{
          currentY--;
          if(currentY<=0){
            down=true;
          }
        }
        if(currentX<=0){
          right=true;
        }
      }
      setState(() {});
    });
  }

  _clickBubble(){
    TbaUtils.instance.uploadAppPoint(
      appPoint: AppPoint.word_float_pop,
      params: {"pop_from":"other"},
    );
    setState(() {
      showGuide=false;
      showBubble=false;
    });
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: AdPosId.fw_old_bubble_rv,
        adFormat: AdFomat.REWARD,
        cancelShow: (){
          _showBubble();
        },
        adShowListener: AdShowListener(
          onAdHidden: (MaxAd? ad) {
            UserInfoUtils.instance.updateBubbleNum(1);
            _showBubble();
            showIncentDialog(
                incentFrom: IncentFrom.bubble,
                addNum: addNum,
                closeDialog: (){}
            );
          },
          showAdFail: (ad,error){
            _showBubble();
          }
        )
    );
  }

  _showBubble(){
    Future.delayed(Duration(seconds: FirebaseDataUtils.instance.bubbleTime),(){
      setState(() {
        showBubble=true;
        addNum=ValueUtils.instance.getFloatAddNum();
      });
    });
  }

  @override
  void dispose() {
    _bus?.cancel();
    _timer?.cancel();
    super.dispose();
  }
}