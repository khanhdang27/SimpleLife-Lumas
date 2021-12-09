import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class SettingIndexScreen extends GetWidget<SettingController> {

  @override
  Widget build(BuildContext context) {
      return Layout(
        header: PreferredSize(
            preferredSize: Size.fromHeight(40.0), // here the desired height
            child: AppBar(
              title: Text('setting'.tr),
            )
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('changeLang'.tr, style: TextStyle(fontSize: 18, fontWeight: AppFont.wMedium)),
              ChangeLocale(),
            ],
          ),
        ),
      );
  }

}
