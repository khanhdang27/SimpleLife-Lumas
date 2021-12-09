import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientServiceScreen extends GetWidget<ServiceController> {
  final ClientController? clientController;

  ClientServiceScreen({this.clientController});

  @override
  Widget build(BuildContext context) {
    if (clientController != null) {}
    var color = AppColor.serviceTextColor;

    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingScreen();
      } else {
        return RefreshIndicator(
          color: AppColor.whiteMain,
          backgroundColor: AppColor.pinkPrimary,
          onRefresh: () {
            controller.getList();
            return controller.getTypeList();
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Label(
                                icon: Icon(Icons.stars_outlined, size: 18, color: color),
                                text: "outstandingServiceTypes".tr,
                                style: TextStyle(fontSize: 14, fontWeight: AppFont.wBold, color: color)
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () => controller.getTypeListScreen(),
                              child: Text(
                                'seeMore'.tr,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: color,
                                  fontWeight: AppFont.wMedium,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(child: Wrap(children: getTypeList())),
                  )
                ]),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Label(
                          icon: Icon(Icons.room_service, size: 18, color: color),
                          text: "outstandingServices".tr,
                          style: TextStyle(fontSize: 14, fontWeight: AppFont.wBold, color: color)),
                    ),
                  ),
                  Column(children: getServiceList())
                ]),
              ),
            ],
          ),
        );
      }
    });
  }

  getTypeList() {
    List<Widget> list = [];
    var typeList = Map.fromIterable(controller.serviceTypes);
    var item;
    var count = 0;
    typeList.forEach((key, type) {
      count++;
      if (count <= 6) {
        item = Container(
          margin: EdgeInsets.all(5),
          child: AppBtn(
            color: AppColor.serviceColor,
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Text("${type.name}", style: TextStyle(color: AppColor.whiteMain, fontSize: 13, fontWeight: AppFont.wMedium)),
            callback: () {
              controller.type = type;
              controller.getListScreen(typeId: type.id);
            },
          ),
        );

        list.add(item);
      }
    });

    return list;
  }

  getServiceList() {
    List<Widget> list = [];
    var serviceList = Map.fromIterable(controller.outstandingServices);
    var item;
    var color = Color.fromRGBO(253, 103, 93, 1.0);
    var count = 0;
    serviceList.forEach((key, service) {
      count++;
      if (count < 6) {
        item = Container(
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: AppBtn(
              padding: EdgeInsets.zero,
              borderSide: BorderSide(
                color: Colors.pink,
              ),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAsset.backgroundService),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${service.name}',
                            style: TextStyle(
                              fontWeight: AppFont.wBold,
                              color: color,
                              fontSize: 15,
                            ))),
                    Align(alignment: Alignment.centerLeft, child: Text("${service.intendTime} " + "minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold))),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(alignment: Alignment.centerLeft, child: Text("${service.type!.name}".tr, style: TextStyle(fontSize: 14, color: color, fontWeight: AppFont.wBold))),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("${service.price}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color,
                                    fontWeight: AppFont.wMedium,
                                  ))),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              callback: () =>  controller.getDetailScreen(service.id)),
        );
        list.add(item);
      }
    });

    return list;
  }
}
