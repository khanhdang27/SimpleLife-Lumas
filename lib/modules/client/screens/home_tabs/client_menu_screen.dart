import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientMenuScreen extends GetWidget<ClientController> {
  @override
  Widget build(BuildContext context) {
    if (controller.isLoggedIn(AppConfig.clientRole)) {
      return Obx(() {
        if (controller.isLoading.value) {
          return LoadingScreen();
        } else {
          Client userMobile = controller.client;
          return ListView(
            children: [
              UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColor.pinkPrimary,
                  ),
                  currentAccountPicture: Obx(() {
                    if (controller.isLoading.value) {}
                    var avatar = (controller.client.avatar == null)
                        ? "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"
                        : AppConfig.baseUrl + "/storage/" + controller.client.avatar;
                    return CircleAvatar(
                      backgroundColor: AppColor.whiteMain,
                      backgroundImage: NetworkImage('$avatar'),
                    );
                  }),
                  accountName: Text('${userMobile.name}', style: TextStyle(fontSize: 20)),
                  accountEmail: Text('${userMobile.email}', style: TextStyle(fontSize: 20))),
              BoxButton(
                label: "profile".tr,
                icon: Icons.account_circle_outlined,
                callback: () => controller.getProfile(),
              ),
              BoxButton(
                label: "paidProducts".tr,
                icon: Icons.shopping_cart,
                callback: () {
                  controller.getPaidProductScreen();
                },
              ),
              BoxButton(
                label: "invoice".tr,
                icon: Icons.description,
                callback: () {
                  controller.getOrderScreen();
                },
              ),
              BoxButton(
                label: "setting".tr,
                icon: Icons.settings,
                callback: () => Get.toNamed(AppRoute.SETTING),
              ),
              BoxButton(
                label: "helperCenter".tr,
                icon: Icons.call_outlined,
                callback: () {
                  if (Storage.getPhoneHelper() == null) {
                    Get.snackbar('pleaseSympathize'.tr, 'notYetPhoneHelper'.tr,
                        backgroundColor: AppColor.silverMain, duration: Duration(seconds: 3));
                  } else {
                    launch('tel:${Storage.getPhoneHelper()}');
                  }
                },
              ),
              BoxButton(
                label: "logout".tr,
                icon: Icons.logout,
                callback: () => controller.logout(),
              ),
            ],
          );
        }
      });
    }
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: AppColor.pinkPrimary,
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: AppColor.whiteMain,
            backgroundImage:
                NetworkImage("https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"),
          ),
          accountName: Text('alreadyHaveAccount'.tr, style: TextStyle(fontSize: 20)),
          accountEmail: GestureDetector(
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
        BoxButton(
          label: "setting".tr,
          icon: Icons.settings,
          callback: () => Get.toNamed(AppRoute.SETTING),
        ),
        BoxButton(
          label: "helperCenter".tr,
          icon: Icons.call_outlined,
          callback: () {
            if (Storage.getPhoneHelper() == null) {
              Get.snackbar('pleaseSympathize'.tr, 'notYetPhoneHelper'.tr,
                  backgroundColor: AppColor.silverMain, duration: Duration(seconds: 3));
            } else {
              launch('tel:${Storage.getPhoneHelper()}');
            }
          },
        ),
      ],
    );
  }

  Container BoxButton(
      {required String label, required IconData icon, required VoidCallback callback}) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFBDBDBD), width: 1)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListTile(
          title: Text(label, style: TextStyle(color: AppColor.pinkPrimary)),
          leading: Icon(icon, color: AppColor.pinkPrimary),
          onTap: callback,
        ),
      ),
    );
  }
}
