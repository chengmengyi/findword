import 'package:findword/widget/images_widget.dart';
import 'package:findword/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BtnWidget extends StatelessWidget{
  String text;
  String? bg;

  Function() clickCall;
  BtnWidget({
    required this.text,
    required this.clickCall,
    this.bg
  });
  
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: (){
      clickCall.call();
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        ImagesWidget(name: bg??"btn_bg",width: 270.w,height: 64.h,),
        TextWidget(text: text, size: 22.sp, color: Colors.white,fontWeight: FontWeight.w700,),
      ],
    ),
  );
}