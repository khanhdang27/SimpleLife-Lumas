import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class PaidProductScreen extends GetWidget<ClientController> {
  @override
  Widget build(BuildContext context) {
    return Layout(
        header: AppBar(
          title: Text('paidProducts'.tr),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'refresh'.tr,
              onPressed: () {
                controller.getPaidProductScreen();
              },
            ),
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(8),
          child: Obx(() {
            if (controller.isServiceLoading.value) {
              return Center(child: LoadingScreen());
            }

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  child: AppBtn(
                    borderSide: BorderSide(color: AppColor.pinkPrimary),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Label(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  size: 23,
                                ),
                                text: "services".tr,
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        Expanded(
                          flex: 5,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${controller.services.length}',
                                style: TextStyle(fontSize: 30, fontWeight: AppFont.wMedium),
                              )),
                        )
                      ],
                    ),
                    callback: () => Get.toNamed(AppRoute.CLIENT_SERVICE_LIST),
                  ),
                ),
                // Container(
                //   width: double.infinity,
                //   child: AppBtn(
                //     borderSide: BorderSide(color: AppColor.pinkPrimary),
                //     padding: EdgeInsets.all(20),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           flex: 5,
                //           child: Align(
                //               alignment: Alignment.centerLeft,
                //               child: Label(
                //                 icon: Icon(
                //                   Icons.menu_book,
                //                   size: 23,
                //                 ),
                //                 text: "courses".tr,
                //                 style: TextStyle(fontSize: 20),
                //               )),
                //         ),
                //         Expanded(
                //           flex: 5,
                //           child: Align(
                //               alignment: Alignment.centerRight,
                //               child: Text(
                //                 '${controller.courses.length}',
                //                 style: TextStyle(fontSize: 30, fontWeight: AppFont.wMedium),
                //               )),
                //         )
                //       ],
                //     ),
                //     callback: () => Get.toNamed(AppRoute.CLIENT_COURSE_LIST),
                //   ),
                // )
              ],
            );
          }),
        ));
  }
}
