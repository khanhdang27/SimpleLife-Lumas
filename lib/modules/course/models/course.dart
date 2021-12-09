import 'package:lumas/general/helper.dart';
import 'package:lumas/general/models.dart';

class Course {
  int? id;
  String? name;
  String? price;
  int? intendTime;
  String? description;
  int? status;
  int? categoryId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  CourseCategory? category;
  List<CourseVoucher>? vouchers;


  Course(
      {this.id,
        this.name,
        this.price,
        this.intendTime,
        this.description,
        this.status,
        this.categoryId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.vouchers
      });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = Helper.formatCurrency(json['price'].toString());
    intendTime = json['intend_time'];
    description = json['description'];
    status = json['status'];
    categoryId = json['category_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new CourseCategory.fromJson(json['category'])
        : null;
    if (json['vouchers'] != null) {
      List<CourseVoucher> vouchers = [];
      json['vouchers'].forEach((v) {
        vouchers.add(new CourseVoucher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['intend_time'] = this.intendTime;
    data['description'] = this.description;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}