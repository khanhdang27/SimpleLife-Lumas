import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class OrderScreen extends GetWidget<OrderController> {
  final ClientController clientController = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    controller.getList();
    if (clientController.isLoggedIn(AppConfig.clientRole)) {
      return LayoutSecond(
        header: AppBar(
          title: Text('invoice'.tr),
        ),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: LoadingScreen());
          } else {
            return Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isAddLoading.value) {}
                    return getOrderList(controller);
                  }),
                ),
              ],
            );
          }
        }),
      );
    }
    return ClientLoginResquestScreen();
  }

  getStatus(statusInt) {
    Order order = Order();
    var status = order.getStatus(statusInt);
    var statusColor = AppColor.pinkPrimary;

    if (status == "abort".tr) {
      statusColor = AppColor.abortAppointment;
    } else if (status == "draft".tr) {
      statusColor = AppColor.progressingAppointment;
    } else if (status == "paid".tr) {
      statusColor = AppColor.paid;
    }

    return {'status': status, 'color': statusColor};
  }

  getOrderList(controller) {
    return NotificationListener<ScrollEndNotification>(
      child: RefreshIndicator(
        color: AppColor.whiteMain,
        backgroundColor: AppColor.pinkPrimary,
        onRefresh: () => controller.getList(),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: controller.orders.length,
          itemBuilder: (BuildContext context, int index) {
            Order order = controller.orders[index];
            var status = getStatus(order.status);
            return Obx(() {
              if (controller.isAddLoading.value) {
                if (index == controller.orders.length - 1) {
                  return Container(
                    child: AppBtn(
                      padding: EdgeInsets.all(18),
                      borderSide: BorderSide(color: AppColor.pinkPrimary),
                      child: LoadingScreen(),
                    ),
                  );
                }
              }
              return Container(
                child: AppBtn(
                  borderRadius: 10,
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 300,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal ,
                                child: Text(order.code??'--',
                                    style: TextStyle(
                                        color: AppColor.pinkPrimary,
                                        fontWeight: AppFont.wBold,
                                        fontSize: 18)),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$'+order.totalPrice.toString(), style: TextStyle(color: AppColor.pinkPrimary)),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  callback: () => controller.getDetail(order.id)
                ),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        ),
      ),
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
}
