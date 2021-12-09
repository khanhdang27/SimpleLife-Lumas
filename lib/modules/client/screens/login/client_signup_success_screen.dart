import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientSignupSuccessScreen extends StatelessWidget {
  const ClientSignupSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      background: AppColor.silverMain,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteMain,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  AppAsset.success,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    'signupSuccess'.tr,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: AppFont.wMedium,
                    ),
                  ),
                ),
                Text(
                  'sendAuth'.tr,
                  style: TextStyle(
                    color: AppColor.blackPrimary,
                  ),
                ),
                Text(
                  Storage.getEmailSignup(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: AppFont.wMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 80),
                  child: Text(
                    'pleaseCheckEmail'.tr,
                    style: TextStyle(
                      color: AppColor.blackPrimary,
                    ),
                  ),
                ),
                Btn(
                  languageKey: 'login',
                  width: 200,
                  callback: () {
                    Get.offAllNamed(AppRoute.CLIENT_LOGIN);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
