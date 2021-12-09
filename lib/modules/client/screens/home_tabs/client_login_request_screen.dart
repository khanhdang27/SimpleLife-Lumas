import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lumas/general/general.dart';

class ClientLoginResquestScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              'alreadyHaveAccount'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: AppFont.wBold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoute.CLIENT_LOGIN);
              },
              child: Text(
                'loginOrSignUp'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: AppFont.wLight,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}