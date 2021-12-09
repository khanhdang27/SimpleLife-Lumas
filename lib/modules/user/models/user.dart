import 'package:lumas/general/models.dart';

class User {
  int? id;
  String? name;
  String? email;
  int? basicSalary;
  int? status;
  String? emailVerifiedAt;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  UserRole? role;
  List? appointments;

  User(
      {this.id,
        this.name,
        this.email,
        this.basicSalary,
        this.status,
        this.emailVerifiedAt,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.role,
        this.appointments
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    basicSalary = json['basic_salary'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'] != null ? new UserRole.fromJson(json['role']) : null;
    appointments = [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['basic_salary'] = this.basicSalary;
    data['status'] = this.status;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}

