import 'package:flutter/material.dart';

class ImagesWidget extends StatelessWidget{
  String name;
  double? width;
  double? height;
  BoxFit? fit;

  ImagesWidget({
    required this.name,
    this.width,
    this.height,
    this.fit,
});

  @override
  Widget build(BuildContext context) => Image.asset(
    "images/$name.png",
    width: width,
    height: height,
    fit: fit
  );
}