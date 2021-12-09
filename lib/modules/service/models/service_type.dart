class ServiceType {
  int? id;
  String? name;
  int? status;
  String? description;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ServiceType(
      {this.id,
        this.name,
        this.status,
        this.description,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['description'] = this.description;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}