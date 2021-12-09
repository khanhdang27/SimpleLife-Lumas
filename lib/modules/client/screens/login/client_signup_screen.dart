import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientSignupScreen extends StatefulWidget {
  @override
  _ClientSignupScreenState createState() => _ClientSignupScreenState();
}

class _ClientSignupScreenState extends State<ClientSignupScreen>{
  final controller = Get.find<ClientController>();

  final clientSignUpFormKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();

  TextEditingController userNameCtrl = TextEditingController();

  TextEditingController emailCtrl = TextEditingController();

  TextEditingController phoneCtrl = TextEditingController();

  TextEditingController passCtrl = TextEditingController();

  TextEditingController confirmPassCtrl = TextEditingController();

  void dispose() {

    nameCtrl.dispose();
    userNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    passCtrl.dispose();
    confirmPassCtrl.dispose();
  }

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Layout(
      background: AppColor.silverMain,
      child: Form(
        key: clientSignUpFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                color: AppColor.silverMain,
                width: 200,
                height: 60,
                child: CustomPaint(
                  foregroundPainter: Triangle(),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppColor.whiteMain,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 10, color: AppColor.blackPrimary, offset: Offset(1, 1))
                  ]),
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.web_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'name'.tr,
                              txtController: nameCtrl,
                              rules: [Validation.required],
                              errorText: controller.errors.value.name,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.account_box_sharp,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'username'.tr,
                              txtController: userNameCtrl,
                              rules: [Validation.required],
                              errorText: controller.errors.value.username,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.email,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'email'.tr,
                              txtController: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              rules: [Validation.required, Validation.email],
                              errorText: controller.errors.value.email,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.phone_android,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'phone'.tr,
                              txtController: phoneCtrl,
                              keyboardType: TextInputType.number,
                              rules: [Validation.required],
                              errorText: controller.errors.value.phone,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.vpn_key_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'password'.tr,
                              txtController: passCtrl,
                              obscureText: controller.isObscure.value,
                              rules: [Validation.required],
                              errorText: controller.errors.value.password,
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscure.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.pinkPrimary,
                                  ),
                                  onPressed: () {
                                    controller.isObscure.value = !controller.isObscure.value;
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                          child: Icon(
                            Icons.vpn_key_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15, left: 30),
                          child: Obx(
                            () => InputFormLogin(
                              label: 'confirmPassword'.tr,
                              txtController: confirmPassCtrl,
                              obscureText: controller.isObscureConfirm.value,
                              rules: [Validation.required],
                              errorText: controller.errors.value.passwordReEnter,
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isObscureConfirm.value
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppColor.pinkPrimary,
                                  ),
                                  onPressed: () {
                                    controller.isObscureConfirm.value = !controller.isObscureConfirm.value;
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                      width: 300,
                      child: Btn(
                        languageKey: 'register',
                        callback: () {
                          var name = nameCtrl.text;
                          var username = userNameCtrl.text;
                          var email = emailCtrl.text;
                          var phone = phoneCtrl.text;
                          var password = passCtrl.text;
                          var confirmPass = confirmPassCtrl.text;
                          if (controller.validator(clientSignUpFormKey)) {
                            controller.signUpValidate(
                              name: name,
                              username: username,
                              email: email,
                              phone: phone,
                              password: password,
                              confirm: confirmPass,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'alreadyAccount'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: AppFont.wLight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Triangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.pinkPrimary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}