class Client {
  int? id;
  String? name;
  String? birthday;
  int? sex;
  String? avatar;
  String? email;
  String? phone;
  String? address;
  String? contactInfo;
  String? username;
  int? status;
  String? emailVerifiedAt;
  int? typeId;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Client(
      {this.id,
      this.name,
      this.birthday,
      this.sex,
      this.avatar,
      this.email,
      this.phone,
      this.address,
      this.contactInfo,
      this.username,
      this.status,
      this.emailVerifiedAt,
      this.typeId,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthday = json['birthday'];
    sex = json['sex'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    contactInfo = json['contact_info'];
    username = json['username'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    typeId = json['type_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['birthday'] = this.birthday;
    data['sex'] = this.sex;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['contact_info'] = this.contactInfo;
    data['username'] = this.username;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['type_id'] = this.typeId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
