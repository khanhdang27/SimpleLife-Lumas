import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserForgotPwScreen extends StatelessWidget {
  final email = TextEditingController();
  final userForgotPwFormKey = GlobalKey<FormState>();
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(
              Icons.lock_outline,
              size: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'forgotPassword'.tr,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Text(
            'enterEmailForgot'.tr,
            style: TextStyle(
              fontSize: 14,
              fontWeight: AppFont.wLight,
              color: AppColor.blackPrimary,
            ),
          ),
          Form(
            key: userForgotPwFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 60.0),
                  child: InputFormLogin(
                    txtController: email,
                    label: '',
                    rules: ['email'],
                  ),
                ),
                Obx(() {
                  if(userController.isLoading.value){
                    return Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 50, 30),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: 300,
                        child: FloatingActionButton.extended(
                          heroTag: key,
                          splashColor: Colors.red,
                          backgroundColor: AppColor.pinkPrimary,
                          label: CircularProgressIndicator(
                            semanticsLabel: 'Linear progress indicator',
                            valueColor: new AlwaysStoppedAnimation<Color>(AppColor.whiteMain),
                          ),
                          onPressed: () {},
                        )
                    );
                  }

                  return Btn(
                    languageKey: 'resetPw',
                    width: 300,
                    callback: () {
                      FocusScope.of(context).unfocus();
                      if(userController.validator(userForgotPwFormKey)){
                        userController.forgotPassword(email: email.text);
                      }
                    },
                  );
                }),
              ],
            )

          )
        ],
      ),
    );
  }
}
