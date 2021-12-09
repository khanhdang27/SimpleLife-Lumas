import 'package:lumas/general/helper.dart';
import 'package:lumas/general/models.dart';
import 'package:lumas/modules/service/models/service_type.dart';

class Service {
  int? id;
  String? name;
  String? price;
  int? intendTime;
  Null additionalPrice;
  Null additionalService;
  String? description;
  int? status;
  int? typeId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  ServiceType? type;
  List<ServiceVoucher>? vouchers;

  Service(
      {this.id,
        this.name,
        this.price,
        this.intendTime,
        this.additionalPrice,
        this.additionalService,
        this.description,
        this.status,
        this.typeId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = Helper.formatCurrency(json['price'].toString());
    intendTime = json['intend_time'];
    additionalPrice = json['additional_price'];
    additionalService = json['additional_service'];
    description = json['description'];
    status = json['status'];
    typeId = json['type_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'] != null ? new ServiceType.fromJson(json['type']) : null;
    if (json['vouchers'] != null) {
      List<ServiceVoucher> vouchers = [];
      json['vouchers'].forEach((v) {
        vouchers.add(new ServiceVoucher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['intend_time'] = this.intendTime;
    data['additional_price'] = this.additionalPrice;
    data['additional_service'] = this.additionalService;
    data['description'] = this.description;
    data['status'] = this.status;
    data['type_id'] = this.typeId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.vouchers != null) {
      data['vouchers'] = this.vouchers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}