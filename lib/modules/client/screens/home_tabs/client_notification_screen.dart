import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientNotificationScreen extends GetWidget<NotificationController> {
  final ClientController clientController;

  ClientNotificationScreen({required this.clientController});

  @override
  Widget build(BuildContext context) {
    controller.getList();
    if (clientController.isLoggedIn(AppConfig.clientRole)) {
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
      onRefresh: () {
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
                  color: notification.clientReadAt == null ? AppColor.pinkSecondary.withOpacity(0.4) : null,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CircleAvatar(
                        backgroundColor: AppColor.whiteMain,
                        backgroundImage: NetworkImage(clientController.client.avatar == null
                            ? "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"
                            : AppConfig.baseUrl + "/storage/" + clientController.client.avatar),
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
                                  child: Text('clientNoti'.tr,
                                      style: TextStyle(
                                          color: AppColor.pinkPrimary,
                                          fontWeight: AppFont.wBold,
                                          fontSize: 15)
                                  )
                              ),
                              notification.clientReadAt == null
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
