import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserInfoScreen extends GetWidget<UserController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            BoxButton(
              label: Text("profile".tr),
              icon: Icon(Icons.account_circle_outlined),
              callback: () => controller.getProfile(),
            ),
            BoxButton(
              label: Text("setting".tr),
              icon: Icon(Icons.settings),
              callback: () => Get.toNamed(AppRoute.SETTING),
            ),
            BoxButton(
              label: Text("logout".tr),
              icon: Icon(Icons.logout),
              callback: () => controller.logout(),
            ),
          ],
        )
    );
  }

  Container BoxButton({required Text label, required Icon icon, required VoidCallback callback}) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all( color: Color(0xFFBDBDBD), width: 0.2),
          borderRadius: BorderRadius.circular(7),
          boxShadow: [BoxShadow(blurRadius: 2, color: Color(0xFFBDBDBD), offset: Offset(1, 1))]),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(10),
          primary: AppColor.pinkPrimary,
          textStyle: TextStyle(fontSize: 17)
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              label,
            ],
          ),
        ),
        onPressed: callback,
      ),
    );
  }
}
