import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientLoginScreen extends StatelessWidget {
  final clientLoginFormKey = GlobalKey<FormState>();

  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  final controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColor.whiteMain),
              child: SizedBox(child: Image.asset(AppAsset.logo2)),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
              child: Text(
                '${controller.error.value}',
                style: TextStyle(fontSize: 20, color: AppColor.danger),
              ),
            ),
          ),
          Form(
              key: clientLoginFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                    child: InputFormLogin(
                      label: 'phone'.tr,
                      txtController: phoneEditingController,
                      rules: ['required'],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    child: Obx(() {
                      return InputFormLogin(
                        label: 'password'.tr,
                        txtController: passwordEditingController,
                        obscureText: controller.isObscure.value,
                        rules: ['required'],
                        suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscure.value ? Icons.visibility_off : Icons.visibility,
                              color: AppColor.pinkPrimary,
                            ),
                            onPressed: () {
                              controller.isObscure.value = !controller.isObscure.value;
                            }),
                      );
                    }),
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
                            Get.toNamed(AppRoute.CLIENT_FORGOT);
                          },
                        ),
                      ),
                    ],
                  ),
                  Btn(
                    languageKey: 'login',
                    callback: () {
                      var phone = phoneEditingController.text;
                      var password = passwordEditingController.text;
                      if (controller.validator(clientLoginFormKey)) {
                        controller.login(phone: phone, password: password);
                      }
                    },
                    width: 300,
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  'signUp'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: AppFont.wLight,
                  ),
                ),
                onTap: () {
                  // Navigator.pushNamed(context, AppRoute.signUp);
                  Get.toNamed(AppRoute.CLIENT_SIGNUP);
                },
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              child: Text(
                'forStaffOnly'.tr,
                style: TextStyle(
                  color: AppColor.blackPrimary,
                  fontSize: 14,
                  fontWeight: AppFont.wLight,
                ),
              ),
              onTap: () {
                Get.offNamed(AppRoute.USER_LOGIN);
              },
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
