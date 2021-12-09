import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumas/configs/app_color.dart';

class LoadingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            semanticsLabel: 'Linear progress indicator',
            valueColor: new AlwaysStoppedAnimation<Color>(AppColor.pinkPrimary),
          ),
        ]
      )
    );
  }

}