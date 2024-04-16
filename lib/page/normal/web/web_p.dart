import 'package:findword/base/base_p.dart';
import 'package:findword/page/normal/web/web_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/widget/images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebP extends BaseP<WebC>{
  @override
  Widget bgWidget() => ImagesWidget(
    name: "launch1",
    width: double.infinity,
    height: double.infinity,
  );
  
  @override
  WebC initC() => WebC();
  
  @override
  Widget contentWidget() => Column(
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: (){
            RoutersUtils.off();
          },
          child: Container(
            margin: EdgeInsets.all(16.w),
            child: ImagesWidget(name: "back",width: 32.w,height: 32.h,),
          ),
        ),
      ),
      Expanded(
        child: WebViewWidget(controller: con.webViewController),
      )
    ],
  );
}