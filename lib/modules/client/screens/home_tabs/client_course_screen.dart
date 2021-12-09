import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ClientCourseScreen extends GetWidget<CourseController> {
  final ClientController? clientController;

  ClientCourseScreen({this.clientController});

  @override
  Widget build(BuildContext context) {
    if(clientController != null){}
    var color = Colors.deepOrange[400];
    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingScreen();
      }else{
        return RefreshIndicator(
          color: AppColor.whiteMain,
          backgroundColor: AppColor.pinkPrimary,
          onRefresh: () {
            controller.getList();
            return controller.getCategoryList();
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Label(
                                    icon: Icon(Icons.my_library_books_outlined, size: 18, color: color),
                                    text: "outstandingCourseCategories".tr,
                                    style: TextStyle(fontSize: 14, fontWeight: AppFont.wBold, color: color)
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () => controller.getCategoryListScreen(),
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
                        child: Container(
                          child: Wrap(
                            children: getCategoryList()
                          ),
                        ),
                      )
                    ]
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Label(
                                icon: Icon(Icons.menu_book_outlined, size: 18, color: color),
                                text: "outstandingCourses".tr,
                                style: TextStyle(fontSize: 14, fontWeight: AppFont.wBold, color: color)
                            ),
                          ),
                        ),
                        Column( children: getServiceList())
                      ]
                  ),
              ),
            ],
          ),
        );
      }
    });
  }

  getCategoryList(){
    List<Widget> list = [];
    var categoryList = Map.fromIterable(controller.courseCategories);
    var item;
    var count = 0;
    categoryList.forEach((key, category) {
      CourseCategory cate = category;
      count++;
      if(count <= 6){
        item = Container(
          margin: EdgeInsets.all(5),
          child: AppBtn(
            color: AppColor.courseColor,
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Text("${cate.name}", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: AppFont.wMedium)),
            callback: (){
              controller.category = cate;
              controller.getListScreen(categoryId: cate.id);
            },
          ),
        );

        list.add(item);
      }
    });

    return list;
  }

  getServiceList(){
    List<Widget> list = [];
    var courseList = Map.fromIterable(controller.outstandingCourses);
    var item;
    var color = AppColor.courseTextColor;
    var count = 0;
    courseList.forEach((key, course) {
      count++;
      if(count < 5){
        item = Container(
          margin: EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: AppBtn(
              padding: EdgeInsets.zero,
              borderSide: BorderSide(
                color: AppColor.pinkPrimary,
              ),
              child : Container(
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
                        child: Text('${course.name}', style: TextStyle(
                          fontWeight: AppFont.wBold,
                          color: color,
                          fontSize: 15,
                        )
                      )
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${course.intendTime} "+"minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold)
                        )
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("${course.category!.name}".tr, style: TextStyle(fontSize: 14,color: color, fontWeight: AppFont.wBold)
                              )
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "${course.price}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color,
                                    fontWeight: AppFont.wMedium,
                                  )
                              )
                          ),
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
    });

    return list;
  }

}
