import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/configs.dart';

class Btn extends StatelessWidget {
  final String languageKey;
  final VoidCallback? callback;
  final Icon? icon;
  final double? width;

  Btn({
    Key? key,
    required this.languageKey,
    this.callback,
    this.icon,
    this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(50, 0, 50, 30),
        padding: EdgeInsets.symmetric(vertical: 10),
        width: width,
        child: FloatingActionButton.extended(
          heroTag: key,
          label: Text(
            languageKey.tr,
            style: TextStyle(
              fontSize: 21,
              fontWeight: AppFont.wMedium,
              color: AppColor.whiteMain,
            ),
            textAlign: TextAlign.center,
          ),
          splashColor: Colors.red,
          icon: icon ?? SizedBox.shrink(),
          backgroundColor: AppColor.pinkPrimary,
          onPressed: callback,
        )
    );
  }
}
