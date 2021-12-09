import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserNotificationScreen extends GetWidget<NotificationController> {
  final UserController userController;

  UserNotificationScreen({required this.userController});

  @override
  Widget build(BuildContext context) {
    controller.getList();
    if (userController.isLoggedIn(AppConfig.userRole)) {
      return Obx(() {
        if (controller.isLoading.value) {
          return LoadingScreen();
        } else {
          if(controller.notifications.length == 0){
            return Align(
                alignment: Alignment.center,
                child: Text(
                    'No news yet...'.tr,
                    style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic)
                ));
          }
          return getNotificationList(controller);
        }
      });
    }

    return ClientLoginResquestScreen();
  }

  getNotificationList(NotificationController controller) {
    return RefreshIndicator(
      color: AppColor.whiteMain,
      backgroundColor: AppColor.pinkPrimary,
      onRefresh: (){
        controller.notRead();
        return controller.getList();
      },
      child: ListView.builder(
        itemCount: controller.notifications.length,
        itemBuilder: (BuildContext context, int index) {
          Notify notification = controller.notifications[index];
          return Obx(() {
            if (controller.isAddLoading.value) {
              if (index == controller.notifications.length - 1) {
                return Container(
                  child: AppBtn(
                    padding: EdgeInsets.all(18),
                    borderSide: BorderSide(color: AppColor.pinkPrimary),
                    child: LoadingScreen(),
                  ),
                );
              }
            }
            return InkWell(
              onTap: (){
                AppointmentController appointmentController = Get.find<AppointmentController>();
                controller.readNoti(appointmentId: notification.appointmentId, userId: notification.userId);
                appointmentController.getDetail(notification.appointmentId);
              },
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColor.whiteMain)),
                  color: notification.userReadAt == null ? AppColor.pinkSecondary.withOpacity(0.4) : null,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CircleAvatar(
                        backgroundColor: AppColor.whiteMain,
                        backgroundImage: NetworkImage("https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 250,
                                child: Text('${notification.member}'+' '+'userNoti'.tr,
                                    style: TextStyle(
                                        color: AppColor.pinkPrimary,
                                        fontWeight: AppFont.wBold,
                                        fontSize: 15)
                                )
                              ),
                              notification.userReadAt == null
                                  ? Icon(Icons.notifications)
                                  : SizedBox(),
                            ],
                          ),
                          Text("${notification.title}", style: TextStyle(color: AppColor.pinkPrimary)),
                          Text("${notification.time}", style: TextStyle(color: AppColor.pinkPrimary)),
                          Text("${notification.type}".tr,
                              style: TextStyle(fontWeight: AppFont.wBold, color: AppColor.pinkPrimary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }
      ),
    );
  }
}
