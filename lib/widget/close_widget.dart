import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseWidget extends StatelessWidget{
  Function() clickCall;
  CloseWidget({required this.clickCall});

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topRight,
    child: Container(
      margin: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: (){
          clickCall.call();
        },
        child: ImagesWidget(name: "icon_close",width: 36.w,height: 36.h,)
      ),
    ),
  );
  
}