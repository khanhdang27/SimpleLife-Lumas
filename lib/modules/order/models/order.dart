import 'order_detail.dart';
import 'package:get/get.dart';

class Order {
  int? id;
  String? code;
  int? memberId;
  String? remarks;
  int? totalPrice;
  int? status;
  String? orderType;
  String? creator;
  String? createdAt;
  String? updatedAt;
  String? paymentMethod;
  int? paymentMethodId;
  int? createdBy;
  int? updatedBy;
  List? orderDetails;

  Map<int, String> statuses = {
    -1: 'abort'.tr,
    0: 'draft'.tr,
    1: 'paid'.tr,
  };

  Order(
      {this.id,
      this.code,
      this.memberId,
      this.remarks,
      this.totalPrice,
      this.status,
      this.orderType,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.paymentMethodId,
      this.creator,
      this.paymentMethod,
      this.orderDetails});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    memberId = json['member_id'];
    remarks = json['remarks'];
    totalPrice = json['total_price'];
    status = json['status'];
    orderType = json['order_type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentMethodId = json['payment_method_id'];
    creator = json['creator'];
    paymentMethod = json['payment_method'];

    var listOrderDetails = json['order_details'] != null ? json['order_details'] : [];
    orderDetails = listOrderDetails != []
        ? listOrderDetails.map((e) {
            return OrderDetails.fromJson(e);
          }).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['member_id'] = this.memberId;
    data['remarks'] = this.remarks;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['order_type'] = this.orderType;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_method_id'] = this.paymentMethodId;
    data['creator'] = this.creator;
    data['payment_method'] = this.paymentMethod;
    return data;
  }

  String? getStatus(status) {
    return statuses[status] ?? null;
  }
}
