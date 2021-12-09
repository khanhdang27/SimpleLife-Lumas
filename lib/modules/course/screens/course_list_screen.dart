import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class CourseListScreen extends GetWidget<CourseController> {
  final ClientController clientController = Get.find<ClientController>();
  dynamic iconSort = Icons.import_export.obs;

  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutSecond(
      header: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: SearchBar(
            title: Text("${controller.category.name}"),
            searchCtrl: searchCtrl,
            callback: (value) {
              controller.getList(name: value, categoryId: controller.categoryId);
            },
          ),
      ),
      child: Column(
        children: [
          Expanded(child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: LoadingScreen());
            }
            if(controller.courses.length == 0){
              return getToolBar();
            }
            return getCourseList();
          }))
        ],
      ),
    );
  }

  getCourseList() {
    if (controller.isAddLoading.value) {}
    return NotificationListener<ScrollEndNotification>(
      child: RefreshIndicator(
          color: AppColor.whiteMain,
          backgroundColor: AppColor.pinkPrimary,
          onRefresh: () => controller.getList(categoryId: controller.categoryId),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: controller.courses.length,
            itemBuilder: (BuildContext context, int index) {
              Course course = controller.courses[index];
              return Obx(() {
                if (controller.isAddLoading.value) {
                  if (index == controller.courses.length - 1) {
                    return Container(
                      child: AppBtn(
                        padding: EdgeInsets.all(18),
                        borderSide: BorderSide(color: AppColor.pinkPrimary),
                        child: LoadingScreen(),
                      ),
                    );
                  }
                }
                if(index == 0){
                  return Column(
                    children: [
                      getToolBar(),
                      Container(
                        width: double.infinity,
                        child: getCourseItem(course),
                      )
                    ],
                  );
                }
                return Container(
                  child: getCourseItem(course)
                );
              });
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )),
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

  Widget getToolBar(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Container(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('total'.tr+": ${controller.courses.length}", style: TextStyle(fontSize: 17, color: AppColor.serviceColor, fontWeight: AppFont.wMedium))
                ),
              )
          ),
          Expanded(
              flex: 5,
              child: Container(
                child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      child: Label(
                          icon: Obx(() => Icon(iconSort.value, size: 20,)),
                          text: "price".tr,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: AppColor.serviceColor,
                              fontWeight: AppFont.wMedium
                          )
                      ),
                      onTap: (){
                        if(iconSort.value == Icons.arrow_upward){
                          iconSort(Icons.arrow_downward);
                          controller.getList(name: searchCtrl.text, categoryId: controller.categoryId, priceSort: 'DESC');
                        }else{
                          iconSort(Icons.arrow_upward);
                          controller.getList(name: searchCtrl.text, categoryId: controller.categoryId, priceSort: 'ASC');
                        }
                      },
                    )
                ),
              )
          ),
        ],
      ),
    );
  }

  getCourseItem(course){
    var color = Colors.deepOrange[900];
    return AppBtn(
        padding: EdgeInsets.zero,
        borderSide: BorderSide(
          color: AppColor.pinkPrimary,
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.backgroundCourse),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${course.name}',
                      style: TextStyle(
                          fontWeight: AppFont.wBold,
                          color: color,
                          fontSize: 15
                      ))),
              Align(alignment: Alignment.centerLeft, child: Text("${course.intendTime} " + "minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold))),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(alignment: Alignment.centerLeft, child: Text("${course.category!.name}".tr, style: TextStyle(fontSize: 14, color: color, fontWeight: AppFont.wBold))),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("${course.price}",
                            style: TextStyle(
                                fontSize: 16,
                                color: color,
                                fontWeight: AppFont.wMedium
                            ))),
                  ),
                ],
              )
            ],
          ),
        ),
        callback: () => controller.getDetailScreen(course.id));
  }
}
