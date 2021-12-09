import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class UserScanQRCodeScreen extends GetWidget<UserController>{

  @override
  Widget build(BuildContext context) {
    return  Obx((){
      if(controller.isLoading.value){
        return Center(child: LoadingScreen());
      }
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: AppBtn(
                  width: 200,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  color: AppColor.pinkPrimary,
                  child: Text('scanQRCode'.tr, style: TextStyle(color: AppColor.whiteMain)),
                  callback: () => Get.toNamed(AppRoute.SCAN_QR_CODE_SCREEN),
                ),
              ),
            ),
            Container(child: Label(icon: Icon(Icons.room_service),text: 'serviceInProgress'.tr, style: TextStyle(fontSize: 18),)),
            Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.serviceInProgress.length,
                  itemBuilder: (BuildContext context, int index) {
                    ClientService serviceInProgress = controller.serviceInProgress[index];
                    return Container(
                      child: getServiceItem(serviceInProgress),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
            ),
            /*Container(child: Label(icon: Icon(Icons.room_service),text: 'courseInProgress'.tr, style: TextStyle(fontSize: 18),)),
            Expanded(
                child:  ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: controller.courseInProgress.length,
                  itemBuilder: (BuildContext context, int index) {
                    ClientCourse courseInProgress = controller.courseInProgress[index];
                    return Container(
                      child: getCourseItem(courseInProgress),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
            )*/
          ],
        ),
      );
    });
  }

  Widget getServiceItem(serviceInProgress){
    Service? service = serviceInProgress.service;
    var color = Color.fromRGBO(253, 103, 93, 1.0);
    return AppBtn(
        padding: EdgeInsets.zero,
        borderSide: BorderSide(
          color: Colors.pink,
        ),
        child : Container(
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
                  child: Text('${serviceInProgress!.code}', style: TextStyle(
                    fontWeight: AppFont.wBold,
                    color: color,
                    fontSize: 16,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.white,
                      ),
                    ],

                  )
                  )
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${service!.name}', style: TextStyle(
                    fontWeight: AppFont.wBold,
                    color: color,
                    fontSize: 15,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.white,
                      ),
                    ],

                  )
                  )
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${service.intendTime} "+"minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold)
                  )
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppBtn(
                          color: Colors.green,
                          child: Text('E-Sign'.tr, style: TextStyle(fontSize: 16, color: Colors.white)),
                          callback: () {
                            controller.codeProduct(serviceInProgress!.code);
                            Get.to(() => LayoutSecond(child: SignNature(type: 'service')));
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AppBtn(
                          color: Colors.red,
                          child: Text('abort'.tr, style: TextStyle(fontSize: 16, color: Colors.white)),
                          callback: () => controller.postAbortServiceUsing(serviceInProgress.code),
                        )
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }

  Widget getCourseItem(courseInProgress){
    Course? course = courseInProgress.course;
    var color = AppColor.courseTextColor;
    return AppBtn(
      padding: EdgeInsets.zero,
      borderSide: BorderSide(
        color: Colors.pink,
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
                child: Text('${courseInProgress!.code}', style: TextStyle(
                  fontWeight: AppFont.wBold,
                  color: color,
                  fontSize: 16,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.white,
                    ),
                  ],

                )
                )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('${course!.name}', style: TextStyle(
                  fontWeight: AppFont.wBold,
                  color: color,
                  fontSize: 15,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 2.0),
                      blurRadius: 2.0,
                      color: Colors.white,
                    ),
                  ],

                )
                )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("${course.intendTime} "+"minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold)
                )
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppBtn(
                        color: Colors.green,
                        child: Text('E-Sign'.tr, style: TextStyle(fontSize: 16, color: Colors.white)),
                        callback: () {
                          controller.codeProduct(courseInProgress!.code);
                          Get.to(() => LayoutSecond(child: SignNature(type: 'course')));
                        }
                      )
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: AppBtn(
                          color: Colors.red,
                          child: Text('abort'.tr, style: TextStyle(fontSize: 16, color: Colors.white)),
                          callback: () => controller.postAbortCourseUsing(courseInProgress.code),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}