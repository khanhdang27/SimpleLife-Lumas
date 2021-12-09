import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientForgotPwScreen extends GetWidget<ClientController> {
  final clientForgotFormKey = GlobalKey<FormState>();

  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final cfPassCtrl = TextEditingController();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Form(
        key: clientForgotFormKey,
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
              'enterPhoneForgot'.tr,
              style: TextStyle(
                fontSize: 14,
                fontWeight: AppFont.wLight,
                color: AppColor.blackPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Obx(() {
                return InputFormLogin(
                  txtController: phoneCtrl,
                  label: 'phone'.tr,
                  keyboardType: TextInputType.number,
                  errorText: controller.errorsForgot.value.phone,
                  rules: [
                    Validation.required,
                  ],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Obx(() {
                return InputFormLogin(
                  txtController: passCtrl,
                  obscureText: controller.isObscureFg.value,
                  errorText: controller.errorsForgot.value.password,
                  label: 'password'.tr,
                  rules: [
                    Validation.required,
                  ],
                  suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscureFg.value ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.pinkPrimary,
                      ),
                      onPressed: () {
                        controller.isObscureFg.value = !controller.isObscureFg.value;
                      }),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 60.0),
              child: Obx(() {
                return InputFormLogin(
                  txtController: cfPassCtrl,
                  label: 'confirmPassword'.tr,
                  obscureText: controller.isObscureFgConfirm.value,
                  errorText: controller.errorsForgot.value.confirmPassword,
                  rules: [
                    Validation.required,
                  ],
                  suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscureFgConfirm.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.pinkPrimary,
                      ),
                      onPressed: () {
                        controller.isObscureFgConfirm.value = !controller.isObscureFgConfirm.value;
                      }),
                );
              }),
            ),
            Obx(() {
              if (controller.isLoading.value) {
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
                    ));
              }

              return Btn(
                languageKey: 'resetPw',
                width: 300,
                callback: () {
                  FocusScope.of(context).unfocus();
                  if (controller.validator(clientForgotFormKey)) {
                    controller.forgotValidate(
                      phone: phoneCtrl.text,
                      password: passCtrl.text,
                      confirm: cfPassCtrl.text,
                    );
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
