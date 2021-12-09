import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ServiceDetailScreen extends GetWidget<ServiceController>{
  @override
  Widget build(BuildContext context) {
    Service service = controller.service;

    return Layout(
      header: AppBar(
        title: Text('${service.name}'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              child: Icon(Icons.home_outlined, size: 30),
              onTap: () => Get.offAllNamed(AppRoute.CLIENT_HOME),
            ),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Text(
              '${service.name}',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: GestureDetector(
              child: Text(
                '${service.type!.name}',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 16.0),
              ),
              onTap: (){
                controller.type = service.type;
                controller.getListScreen(typeId: service.type!.id);
              },
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Text(
              '${service.price}',
              style: TextStyle(
                  fontSize: 30.0),
            )
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
              child: Text(
                'intendTime'.tr + ': ${service.intendTime} minutes',
                style: TextStyle(
                    fontSize: 20.0),
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(text: 'description'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 30),
              child: Text(
                '${service.description}',
                style: TextStyle(
                    fontSize: 20.0),
              )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(text: 'relatedServices'.tr, style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 30),
              child: Column(children: getServiceList())
          ),
        ],
      )
    );
  }

  getServiceList() {
    List<Widget> list = [];
    var serviceList = Map.fromIterable(controller.outstandingServices);
    var item;
    var color = Color.fromRGBO(253, 103, 93, 1.0);
    var count = 0;
    serviceList.forEach((key, service) {
      if(service.id != controller.service.id && service.typeId == controller.service.typeId) {
        count++;
        if (count < 5) {
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
                callback: () => controller.getDetailScreen(service.id)
            ),
          );
          list.add(item);
        }
      }
    });

    return list;
  }
}