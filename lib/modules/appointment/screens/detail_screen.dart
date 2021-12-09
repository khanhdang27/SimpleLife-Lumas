import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class AppointmentDetailScreen extends GetWidget<AppointmentController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentCtrl = TextEditingController();
  TextEditingController remarkCtrl = TextEditingController();
  UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isLoading.value) {}
      Appointment appointment = controller.appointment;
      // commentCtrl.text = appointment.comment ?? '';
      var status = getStatus(appointment.status);
      return Layout(
        header: AppBar(
          title: Text('appointmentDetail'.tr),
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child: Text(
                        '${appointment.name ?? '--'}',
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      )),

                  /// Status & Type
                  Row(
                    children: [
                      /// Status
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'status'.tr,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                decoration: BoxDecoration(
                                  color: status['color'],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(status['status'],
                                    style: TextStyle(
                                        fontWeight: AppFont.wMedium, color: AppColor.whiteMain)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      ///Type
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'type'.tr,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '${appointment.type}'.tr,
                                  style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///Time
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'appointmentTime'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${appointment.time}",
                            style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Client
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'client'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${appointment.client == null ? 'N/A' : appointment.client!.name}",
                            style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'staff'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${appointment.user == null ? 'N/A' : appointment.user!.name}",
                            style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Store
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'store'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Causeway Bay",
                            style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Instrument
                  Storage.getRole() == AppConfig.userRole
                      ? Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'instrument'.tr,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${appointment.instrumentName ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),

                  ///Room
                  Storage.getRole() == AppConfig.userRole
                      ? Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'room'.tr,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${appointment.roomName ?? 'N/A'}",
                                  style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),

                  ///Description
                  Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'description'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${appointment.description ?? 'N/A'}",
                            style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Remark
                  Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'remarks'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        appointment.remarks != null
                            ? Container(
                                child: Text(
                                  appointment.remarks ?? "",
                                  style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                                ),
                              )
                            : Text(
                                'noRemark'.tr,
                                style: TextStyle(
                                  color: AppColor.pinkPrimary,
                                  fontSize: 18,
                                ),
                              ),
                        (Storage.getRole() == AppConfig.userRole &&
                                    userController.user.role.id == 1 ||
                                appointment.remarks == null)
                            ? Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: AppBtn(
                                    callback: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColor.pinkPrimary, width: 2),
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      padding: EdgeInsets.only(left: 10),
                                                      child: TextFormField(
                                                        maxLength: 30,
                                                        controller: remarkCtrl,
                                                        keyboardType: TextInputType.multiline,
                                                        maxLines: null,
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding: const EdgeInsets.only(top: 20.0),
                                                        child: AppBtn(
                                                          callback: () {
                                                            if (remarkCtrl.text.isNotEmpty)
                                                              controller.remark(
                                                                  appointment.id, remarkCtrl.text);
                                                          },
                                                          color: AppColor.pinkPrimary,
                                                          child: Text(
                                                            'remark'.tr,
                                                            style: TextStyle(
                                                              color: AppColor.whiteMain,
                                                            ),
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Text(
                                      'remark'.tr,
                                      style: TextStyle(
                                        color: AppColor.whiteMain,
                                      ),
                                    ),
                                    color: AppColor.pinkPrimary,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Product List
            getProductList(appointment.services, appointment.courses),

            /// Comment
            /*Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 25),
                    child: Row(
                      children: [
                        Text('comment'.tr,
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  appointment.commentCreatedAt != null
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 35, left: 25),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(appointment.client!.avatar == null
                                    ? "https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"
                                    : AppConfig.baseUrl +
                                        "/storage/" +
                                        appointment.client!.avatar!),
                                backgroundColor: AppColor.pinkSecondary,
                                radius: 25,
                              ),
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              textDirection: TextDirection.ltr,
                              children: [
                                SizedBox(
                                  child: Text(
                                    appointment.comment ?? '',
                                    style: TextStyle(
                                        color: AppColor.pinkPrimary,
                                        fontWeight: AppFont.wBold,
                                        fontSize: 15),
                                  ),
                                  width: 250,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(appointment.commentCreatedAt ?? ''),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                            'noComment'.tr,
                            style: TextStyle(color: AppColor.pinkPrimary, fontSize: 16),
                          ),
                      ),
                  Storage.getRole() == AppConfig.clientRole
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Center(
                            child: AppBtn(
                              callback: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColor.pinkPrimary, width: 2),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                padding: EdgeInsets.only(left: 10),
                                                child: TextFormField(
                                                  controller: commentCtrl,
                                                  keyboardType: TextInputType.multiline,
                                                  maxLines: null,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets.only(top: 20.0),
                                                  child: AppBtn(
                                                    callback: () {
                                                      if (commentCtrl.text.isNotEmpty)
                                                        controller.comment(
                                                            appointment.id, commentCtrl.text);
                                                    },
                                                    color: AppColor.pinkPrimary,
                                                    child: Text(
                                                      'comment'.tr,
                                                      style: TextStyle(
                                                        color: AppColor.whiteMain,
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                'comment'.tr,
                                style: TextStyle(
                                  color: AppColor.whiteMain,
                                ),
                              ),
                              color: AppColor.pinkPrimary,
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),*/

            ///End Comment
          ],
        ),
      );
    });
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

  getProductList(services, courses) {
    if (services.isNotEmpty) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('serviceList'.tr,
                style: TextStyle(
                    fontSize: 20, color: AppColor.pinkPrimary, fontWeight: AppFont.wBold)),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      "name".tr,
                      style: TextStyle(fontWeight: AppFont.wBold, color: AppColor.pinkPrimary),
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  services!.length,
                  (int index) {
                    var service = services[index];
                    return DataRow(
                      cells: <DataCell>[DataCell(Text('${service.name}'))],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      if (courses.isNotEmpty) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text('courseList'.tr,
                  style: TextStyle(
                      fontSize: 20, color: AppColor.pinkPrimary, fontWeight: AppFont.wBold)),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        "name".tr,
                        style: TextStyle(fontWeight: AppFont.wBold, color: AppColor.pinkPrimary),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    courses!.length,
                    (int index) {
                      var course = courses[index];
                      return DataRow(
                        cells: <DataCell>[DataCell(Text('${course.name}'))],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
            child: Text('noProduct'.tr,
                style: TextStyle(
                    color: AppColor.pinkPrimary, fontSize: 22, fontStyle: FontStyle.italic)));
      }
    }
  }
}
