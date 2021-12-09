import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientHomeScreen extends GetWidget<ClientController> {
  ServiceController serviceController = Get.find<ServiceController>();
  CourseController courseController = Get.find<CourseController>();
  NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    notificationController.notRead();
    return LayoutTab(
      initialIndex: (controller.isLoggedIn(AppConfig.clientRole)) ? 3 : 1,
      bottomTabBar: true,
      tabList: clientTab(),
      tabViews: clientTabView(),
      callback: (index){
        if (controller.isLoggedIn(AppConfig.clientRole)) {
          switch(index){
            case 2:
              notificationController.getList();
              notificationController.notRead();
              break;
          }
        }
      },
    );
  }

  List<Tab> clientTab() {
    if (controller.isLoggedIn(AppConfig.clientRole)) {
      return [
        Tab(icon: Icon(Icons.room_service, color: AppColor.pinkPrimary)),
        // Tab(icon: Icon(Icons.menu_book, color: AppColor.courseColor)),
        // Tab(icon: Icon(Icons.home_work_outlined, color: AppColor.pinkPrimary)),
        Tab(icon: Icon(Icons.calendar_today_outlined, color: AppColor.pinkPrimary)),
        Tab(
            child: Obx(() {
              return Stack(
                children: [
                  Icon(Icons.notifications_active, color: AppColor.pinkPrimary),
                  notificationController.notiNotRead.value == 0
                      ? SizedBox()
                      : Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(1),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: new Text(
                        notificationController.notiNotRead.value.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            })),
        Tab(icon: Icon(Icons.person, color: AppColor.pinkPrimary)),
      ];
    }

    return [
      Tab(icon: Icon(Icons.room_service, color: AppColor.pinkPrimary)),
      // Tab(icon: Icon(Icons.menu_book, color: AppColor.courseColor)),
      // Tab(icon: Icon(Icons.home_work_outlined, color: AppColor.pinkPrimary)),
      Tab(icon: Icon(Icons.menu, color: AppColor.pinkPrimary)),
    ];
  }

  List<Widget> clientTabView() {
    if (controller.isLoggedIn(AppConfig.clientRole)) {
      return [
        ClientServiceScreen(clientController: controller),
        // ClientCourseScreen(clientController: controller),
        // StoreScreen(),
        ClientAppointmentScreen(clientController: controller),
        ClientNotificationScreen(clientController: controller),
        ClientMenuScreen(),
      ];
    }

    return [
      ClientServiceScreen(clientController: controller),
      // ClientCourseScreen(clientController: controller),
      // StoreScreen(),
      ClientMenuScreen(),
    ];
  }
}
