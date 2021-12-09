import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lumas/general/configs.dart';
import 'package:lumas/general/screens.dart';
import 'package:lumas/general/services.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget{
  final controller;
  AppDrawer({required this.controller});

  @override
  Widget build(BuildContext context) {
    var storageRole = Storage.getRole();
    dynamic userMobile = (storageRole == 1) ? controller.client : controller.user;

    return  Drawer(
      child: ListView(
        children: [
          Obx((){
            if(controller.isLoading.value){
              return LoadingScreen();
            }
            return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.pinkPrimary,
                ),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage("https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png")
                ),
                accountName: Text(userMobile.name, style: TextStyle(fontSize: 20)),
                accountEmail: Text(userMobile.email, style: TextStyle(fontSize: 20))
            );
          }),
          ListTile(
            title: Text('profile'.tr, style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.people),
            onTap: () {
              Navigator.pop(context);
              controller.getProfile();
            },
          ),
          ListTile(
            title: Text('logout'.tr, style: TextStyle(fontSize: 18)),
            leading: Icon(Icons.logout),
            onTap: () => controller.logout(),
          )
        ],
      ),
    );
  }
}