import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserHomeScreen extends GetWidget<UserController> {
  int? selectedPage;
  UserHomeScreen({this.selectedPage});
  AppointmentController appointmentController = Get.find<AppointmentController>();
  NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    notificationController.notRead();
    return LayoutTab(
      initialIndex: selectedPage,
      tabList: [
        Tab(icon: Icon(Icons.calendar_today_outlined)),
        Tab(
            child: Obx(() {
              return Stack(
                children: [
                  Icon(Icons.notifications_active),
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
        Tab(icon: Icon(Icons.qr_code)),
        Tab(icon: Icon(Icons.menu)),
      ],
      tabViews: [
        UserAppointmentScreen(userController: controller),
        UserNotificationScreen(userController: controller),
        UserScanQRCodeScreen(),
        UserInfoScreen(),
      ],
      callback: (index){
        switch(index){
          case 0:
            if(appointmentController.appointments.isEmpty)
            appointmentController.getList();
            break;
          case 1:
            notificationController.getList();
            notificationController.notRead();
            appointmentController.appointments = [];
            break;
          case 2:
            appointmentController.appointments = [];
            controller.getListProductInProgress();
            break;
        }
      },
    );
  }
}
