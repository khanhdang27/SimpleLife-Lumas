import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientProfileScreen extends GetWidget<ClientController> {
  final updateClientProfileKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if(controller.client == null.obs){
      controller.getDataProfile();
    }
    return Obx((){
      if(controller.isLoading()){
        return LoadingScreen();
      }

      Client client = controller.client;
      var passwordObscure = true.obs;
      var passwordReEnterObscure = true.obs;

      TextEditingController nameCtrl = TextEditingController(text: client.name);
      TextEditingController phoneCtrl = TextEditingController(text: client.phone);
      TextEditingController addressCtrl = TextEditingController(text: client.address);
      TextEditingController emailCtrl = TextEditingController(text: client.email);
      TextEditingController usernameCtrl = TextEditingController(text: client.username);
      TextEditingController passwordCtrl = TextEditingController();
      TextEditingController passwordReEnterCtrl = TextEditingController();

      return Layout(
        header: PreferredSize(
            preferredSize: Size.fromHeight(40.0), // here the desired height
            child: AppBar()
        ),
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClientAvatar(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      Text('${client.name}', style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold)),
                      Text('${client.email}', style: TextStyle(fontSize: 18, fontWeight: AppFont.wLight)),
                    ],
                  ),
                ),
              ),
              Form(
                key: updateClientProfileKey,
                child: Obx( () {
                  return Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('username'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(txtController: usernameCtrl, rules: ['required'], errorText: controller.errors.value.username, enabled: false,)
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('name'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(txtController: nameCtrl, rules: ['required'])
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('phone'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(txtController: phoneCtrl, rules: ['required'], errorText: controller.errors.value.phone)
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('email'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(txtController: emailCtrl, rules: ['required'], errorText: controller.errors.value.email)
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('address'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(txtController: addressCtrl, rules: [])
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('password'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(
                                  txtController: passwordCtrl,
                                  obscureText: passwordObscure.value,
                                  rules: [],
                                  errorText: controller.errors.value.password,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordObscure.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColor.pinkPrimary,
                                      ),
                                      onPressed: () {
                                        passwordObscure.value = !passwordObscure.value;
                                      }
                                  ),
                                )
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                            child: FormGroup(
                                label: Text('confirmPassword'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wMedium)),
                                value: InputForm(
                                  txtController: passwordReEnterCtrl,
                                  obscureText: passwordReEnterObscure.value,
                                  rules: [],
                                  errorText: controller.errors.value.passwordReEnter,
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordReEnterObscure.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: AppColor.pinkPrimary,
                                      ),
                                      onPressed: () {
                                        passwordReEnterObscure.value = !passwordReEnterObscure.value;
                                      }
                                  ),
                                )
                            )
                        ),
                        Center(
                            child: Btn(
                              languageKey: 'update'.tr,
                              callback: () {
                                var data = {
                                  "name": nameCtrl.text,
                                  "username": usernameCtrl.text,
                                  "phone": phoneCtrl.text,
                                  "email": emailCtrl.text,
                                  "address": addressCtrl.text,
                                  "password": passwordCtrl.text,
                                  "password_re_enter": passwordReEnterCtrl.text,
                                };
                                if (controller.validator(updateClientProfileKey)) {
                                  controller.postProfile(data);
                                }
                              },
                            )
                        ),
                      ]);
                }
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}
