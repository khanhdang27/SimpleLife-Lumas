import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/components/components.dart';
import 'package:lumas/general/general.dart';

class OrderDetailScreen extends GetWidget<OrderController> {
  const OrderDetailScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    Order order = controller.order;
    var status = getStatus(order.status);
    return Layout(
      header: AppBar(
        title: Text(order.code ?? 'invoice'.tr),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Text(
                '${order.code}',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                color: status['color'],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status['status'],
                  style: TextStyle(fontWeight: AppFont.wMedium, color: AppColor.whiteMain)),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Text(
                'HK\$${order.totalPrice}',
                style: TextStyle(fontSize: 25.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'type'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10),
              child: Text(
                '${order.orderType}'.tr,
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'remark'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10),
              child: Text(
                '${order.remarks ?? 'noRemark'.tr}'.tr,
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'paymentMethod'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10),
              child: Text(
                '${order.paymentMethod ?? '--'}'.tr,
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'creator'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10),
              child: Text(
                '${order.creator ?? '--'}'.tr,
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'createAt'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 10),
              child: Text(
                '${order.updatedAt != null ? order.updatedAt!.substring(0, 10) + ' ' + order.updatedAt!.substring(11, 16) : '--'}',
                style: TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
            child: Label(
              text: 'invoiceDetail'.tr,
              style: TextStyle(fontSize: 20, fontWeight: AppFont.wBold),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 30),
              child: Column(children: getOrderDetail())),
        ],
      ),
    );
  }

  getOrderDetail() {
    List<Widget> list = [];
    var orderDetails = Map.fromIterable(controller.order.orderDetails);
    var item;
    var color = Color.fromRGBO(253, 103, 93, 1.0);
    var count = 0;
    orderDetails.forEach((key, orderDetail) {
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
                      child: Text('${orderDetail.product}',
                          style: TextStyle(
                            fontWeight: AppFont.wBold,
                            color: color,
                            fontSize: 18,
                          ))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: color,
                          fontSize: 15,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'voucher'.tr + ': ',
                              style: TextStyle(
                                fontWeight: AppFont.wBold,
                              )),
                          TextSpan(
                            text: '${orderDetail.voucher ?? "--"}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: orderDetail.voucher == null
                        ? RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: color,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'price'.tr + ': ',
                                    style: TextStyle(
                                      fontWeight: AppFont.wBold,
                                    )),
                                TextSpan(
                                  text: '\$${orderDetail.productPrice ?? '--'}',
                                ),
                              ],
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: color,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'price'.tr + ': ',
                                    style: TextStyle(
                                      fontWeight: AppFont.wBold,
                                    )),
                                TextSpan(
                                  text: ' \$${orderDetail.productPrice ?? '--'}',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: AppColor.blackPrimary,
                                  ),
                                ),
                                TextSpan(text: ' \$${orderDetail.price ?? '--'}'),
                              ],
                            ),
                          ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: color,
                          fontSize: 15,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'discount'.tr + ': ',
                              style: TextStyle(
                                fontWeight: AppFont.wBold,
                              )),
                          TextSpan(
                            text: '${orderDetail.discount ?? "0"}%',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: color,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'quantity'.tr + ': ',
                                    style: TextStyle(
                                      fontWeight: AppFont.wBold,
                                    )),
                                TextSpan(
                                  text: "${orderDetail.quantity}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("\$${orderDetail.amount}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: color,
                                  fontWeight: AppFont.wMedium,
                                ))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // callback: () => controller.getDetailScreen(service.id)),
          ),
        );
        list.add(item);
      }
    });
    return list;
  }
}
