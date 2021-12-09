import 'package:lumas/general/helper.dart';
import 'package:lumas/general/models.dart';

class ClientCourse {
  int? id;
  String? code;
  int? memberId;
  int? courseId;
  int? voucherId;
  int? quantity;
  int? deductQuantity;
  String? price;
  int? status;
  String? remarks;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  Course? course;
  CourseVoucher? voucher;
  String? totalPrice;
  int? remainingQuantity;

  ClientCourse(
      {this.id,
        this.code,
        this.memberId,
        this.courseId,
        this.voucherId,
        this.quantity,
        this.deductQuantity,
        this.remainingQuantity,
        this.price,
        this.totalPrice,
        this.status,
        this.remarks,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.course,
        this.voucher});

  ClientCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    memberId = json['member_id'];
    courseId = json['course_id'];
    voucherId = json['voucher_id'];
    quantity = json['quantity'];
    deductQuantity = json['deduct_quantity'];
    remainingQuantity = json['quantity'] - json['deduct_quantity'];
    price = Helper.formatCurrency(json['price'].toString());
    totalPrice = Helper.formatCurrency((json['price']*json['quantity']).toString());
    status = json['status'];
    remarks = json['remarks'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    voucher =
    json['voucher'] != null ? new CourseVoucher.fromJson(json['voucher']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['member_id'] = this.memberId;
    data['course_id'] = this.courseId;
    data['voucher_id'] = this.voucherId;
    data['quantity'] = this.quantity;
    data['deduct_quantity'] = this.deductQuantity;
    data['price'] = this.price;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    return data;
  }
}