import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientAppointmentScreen extends GetWidget<AppointmentController> {
  final ClientController clientController;

  ClientAppointmentScreen({required this.clientController});

  @override
  Widget build(BuildContext context) {
    if (clientController.isLoggedIn(AppConfig.clientRole)) {
      return Obx(() {
        if (controller.isLoading.value) {
          return LoadingScreen();
        } else {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AppBtn(
                      child: Text('all'.tr, style: TextStyle(color: AppColor.whiteMain)),
                      color: AppColor.pinkPrimary,
                      callback: () => controller.getList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AppBtn(
                      child: Text('today'.tr, style: TextStyle(color: AppColor.whiteMain)),
                      color: AppColor.pinkPrimary,
                      callback: () {
                        var now = DateTime.now();
                        controller.getList(time: now);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: AppBtn(
                      child: Text('tomorrow'.tr, style: TextStyle(color: AppColor.whiteMain)),
                      color: AppColor.pinkPrimary,
                      callback: () {
                        var now = DateTime.now();
                        var tomorrow = DateTime(now.year, now.month, now.day + 1);

                        controller.getList(time: tomorrow);
                      },
                    ),
                  ),
                ],
              ),
              // Filter by status
              /*Padding(
                padding: EdgeInsets.all(5),
                child: AppBtn(
                  child: Obx(() => Text('${controller.statusName}', style: TextStyle(color: AppColor.whiteMain))),
                  color: AppColor.pinkPrimary,
                  callback: () => controller.filterByStatus(),
                ),
              ),*/
              Expanded(
                child: Obx(() {
                  if (controller.isAddLoading.value) {}

                  ///Must have this line in obx if there is no condition
                  return getAppointmentList(controller);
                }),
              )
            ],
          );
        }
      });
    }

    return ClientLoginResquestScreen();
  }

  getStatus(statusInt) {
    Appointment appointmentModel = Appointment();
    var status = appointmentModel.getStatus(statusInt);
    var statusColor = AppColor.pinkPrimary;

    if (status == "waiting".tr) {
      statusColor = AppColor.waitingAppointment;
    } else if (status == "progressing".tr) {
      statusColor = AppColor.progressingAppointment;
    } else if (status == "completed".tr) {
      statusColor = AppColor.completedAppointment;
    } else if (status == "abort".tr) {
      statusColor = AppColor.abortAppointment;
    }

    return {'status': status, 'color': statusColor};
  }

  getAppointmentList(controller) {
    return NotificationListener<ScrollEndNotification>(
      child: RefreshIndicator(
        color: AppColor.whiteMain,
        backgroundColor: AppColor.pinkPrimary,
        onRefresh: () => controller.getList(),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.appointments.length,
          itemBuilder: (BuildContext context, int index) {
            Appointment appointment = controller.appointments[index];
            var status = getStatus(appointment.status);
            return Obx(() {
              if (controller.isAddLoading.value) {
                if (index == controller.appointments.length - 1) {
                  return Container(
                    child: AppBtn(
                      padding: EdgeInsets.all(18),
                      borderSide: BorderSide(color: AppColor.pinkPrimary),
                      child: LoadingScreen(),
                    ),
                  );
                }
              }
              return Container(
                child: AppBtn(
                    padding: EdgeInsets.all(18),
                    borderSide: BorderSide(color: AppColor.pinkPrimary),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('${appointment.name}',
                                      style: TextStyle(
                                          color: AppColor.pinkPrimary,
                                          fontWeight: AppFont.wBold,
                                          fontSize: 18))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${appointment.time}",
                                      style: TextStyle(color: AppColor.pinkPrimary))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${appointment.type}".tr,
                                      style: TextStyle(
                                          fontWeight: AppFont.wBold, color: AppColor.pinkPrimary))),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('${appointment.client!.name}',
                                        style: TextStyle(color: AppColor.pinkPrimary))),
                              ),
                              Expanded(
                                flex: 5,
                                child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                        color: status['color'],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(status['status'],
                                          style: TextStyle(
                                              fontWeight: AppFont.wMedium,
                                              color: AppColor.whiteMain)),
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    callback: () => controller.getDetail(appointment.id)),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
      onNotification: (t) {
        var metrics = t.metrics;
        if (metrics.atEdge) {
          //is bottom
          if (metrics.pixels != 0) // metrics.pixels == 0 is top
            controller.addList();
        }
        return true;
      },
    );
  }
}
