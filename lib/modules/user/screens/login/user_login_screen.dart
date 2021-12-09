import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserLoginScreen extends StatelessWidget {
  final userLoginFormKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipPath(
            clipper: MyClipperUser(),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColor.whiteMain),
              child: SizedBox(child: Image.asset(AppAsset.logo2)),
            ),
          ),
          Text(
            'Staff Login',
            style: TextStyle(fontSize: 30),
          ),
          Obx(
            ()=>Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
              child: Text(
                '${userController.error.value}',
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.danger
                ),
              ),
            ),
          ),
          Form(
            key: userLoginFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: InputFormLogin(
                    label: 'email'.tr,
                    txtController: emailEditingController,
                    rules: ['required', 'email'],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                  child: InputFormLogin(
                    label: 'password'.tr,
                    txtController: passwordEditingController,
                    obscureText: true,
                    rules: ['required'],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 40),
                      child: GestureDetector(
                        child: Text(
                          'forgotPassword'.tr + '?',
                          style: TextStyle(
                            color: AppColor.blackPrimary,
                            fontSize: 14,
                            fontWeight: AppFont.wLight,
                          ),
                        ),
                        onTap: () {
                          Get.toNamed(AppRoute.USER_FORGOT);
                        },
                      ),
                    ),
                  ],
                ),
                Btn(
                  languageKey: 'login'.tr,
                  callback: () {
                    var email = emailEditingController.text;
                    var password = passwordEditingController.text;
                    if(userController.validator(userLoginFormKey)){
                      userController.login(email: email, password: password);
                    }
                  },
                  width: 300,
                ),
              ],
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Text(
                'forClient'.tr,
                style: TextStyle(
                  color: AppColor.blackPrimary,
                  fontSize: 14,
                  fontWeight: AppFont.wLight,
                ),
              ),
              onTap: () {
                Get.offNamed(AppRoute.CLIENT_LOGIN);
              },
            ),
          )
        ],
      )
    );
  }
}

class MyClipperUser extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
