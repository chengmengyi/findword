import 'package:findword/base/base_c.dart';
import 'package:findword/base/base_p.dart';
import 'package:findword/utils/routers/routers_name.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends BaseP<TestC>{
  @override
  Widget bgWidget() => Container();

  @override
  Widget contentWidget() => Center(
    child: InkWell(
      onTap: (){
        RoutersUtils.toPage(name: RoutersName.buyHome);
      },
      child: Text("kkkkkk"),
    ),
  );

  @override
  TestC initC() => TestC();
}

class TestC extends BaseC{

}