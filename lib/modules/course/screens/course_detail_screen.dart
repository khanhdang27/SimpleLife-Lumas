import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class CourseDetailScreen extends GetWidget<CourseController>{
  @override
  Widget build(BuildContext context) {
    Course course = controller.course;

    return Layout(
      header: AppBar(
        title: Text('${course.name}'),
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
              '${course.name}',
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: GestureDetector(
              child: Text(
                '${course.category!.name}',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 16.0),
              ),
              onTap: (){
                controller.category = course.category;
                controller.getListScreen(categoryId: course.category!.id);
              },
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Text(
              '${course.price}',
              style: TextStyle(
                  fontSize: 30.0),
            )
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
              child: Text(
                'intendTime'.tr + ': ${course.intendTime} minutes',
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
                '${course.description}',
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
    var serviceList = Map.fromIterable(controller.outstandingCourses);
    var item;
    var color = AppColor.courseTextColor;
    var count = 0;
    serviceList.forEach((key, course) {
      if(course.id != controller.course.id && course.categoryId == controller.course.categoryId) {
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
                                fontSize: 15,
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
                                      fontWeight: AppFont.wMedium,
                                    ))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                callback: () => controller.getDetailScreen(course.id)
            ),
          );
          list.add(item);
        }
      }
    });

    return list;
  }
}