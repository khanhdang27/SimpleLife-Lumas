import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class CourseCategoryListScreen extends GetWidget<CourseController>{
  @override
  Widget build(BuildContext context) {
    return LayoutSecond(
      header: AppBar(
        title: Text('allCategories'.tr),
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
                    children: getCategoryList()
                ),
              ),
          );
        }
      }),
    );
  }

  getCategoryList(){
    List<Widget> list = [];
    var categoryList = Map.fromIterable(controller.courseCategories);
    var item;
    categoryList.forEach((key, category) {
      CourseCategory cate = category;
      item = Container(
        margin: EdgeInsets.all(5),
        child: AppBtn(
          color: AppColor.whiteMain,
          borderSide: BorderSide(
            color: AppColor.courseColor
          ),
          width: 120,
          height: 120,
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Text("${cate.name}", style: TextStyle(color: AppColor.courseColor, fontSize: 16, fontWeight: AppFont.wMedium)),
          callback: (){
            controller.category = cate;
            controller.getListScreen(categoryId: cate.id);
          },
        ),
      );
      list.add(item);
    });

    return list;
  }
}