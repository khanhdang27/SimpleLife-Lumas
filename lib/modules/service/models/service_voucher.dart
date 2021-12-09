class ServiceVoucher {
  int? id;
  String? code;
  String? description;
  String? image;
  String? price;
  int? status;
  String? startAt;
  String? endAt;
  int? serviceId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ServiceVoucher(
      {this.id,
        this.code,
        this.description,
        this.image,
        this.price,
        this.status,
        this.startAt,
        this.endAt,
        this.serviceId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ServiceVoucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    image = json['image'];
    price = json['price'];
    status = json['status'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    serviceId = json['service_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['image'] = this.image;
    data['price'] = this.price;
    data['status'] = this.status;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['service_id'] = this.serviceId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}