import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ServiceTypeListScreen extends GetWidget<ServiceController>{
  @override
  Widget build(BuildContext context) {
    return LayoutSecond(
      header: AppBar(
        title: Text('allTypes'.tr),
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: LoadingScreen());
        }else {
          return RefreshIndicator(
              color: AppColor.whiteMain,
              backgroundColor: AppColor.pinkPrimary,
              onRefresh: () => controller.getOutStandingList(),
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: GridView.count(
                    crossAxisCount: 3,
                    children: getTypeList()
                ),
              ),
          );
        }
      }),
    );
  }

  getTypeList() {
    List<Widget> list = [];
    var typeList = Map.fromIterable(controller.serviceTypes);
    var item;
    typeList.forEach((key, type) {
      item = Container(
        margin: EdgeInsets.all(5),
        child: AppBtn(
          color: AppColor.whiteMain,
          borderSide: BorderSide(
              color: AppColor.courseColor
          ),
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text("${type.name}", style: TextStyle(color: AppColor.serviceColor, fontSize: 16, fontWeight: AppFont.wMedium)),
          callback: () {
            controller.type = type;
            controller.getListScreen(typeId: type.id);
          },
        ),
      );

      list.add(item);
    });

    return list;
  }
}