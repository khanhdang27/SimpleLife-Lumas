

class Store {
  int? id;
  String? name;
  String? location;
  String? address;
  String? openCloseTime;
  int? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Store(
      {this.id,
        this.name,
        this.location,
        this.address,
        this.openCloseTime,
        this.status,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    address = json['address'];
    openCloseTime = json['open_close_time'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['address'] = this.address;
    data['open_close_time'] = this.openCloseTime;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}