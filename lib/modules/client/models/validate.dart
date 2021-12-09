class Validate {
  String? username;
  String? name;
  String? phone;
  String? password;
  String? passwordReEnter;
  String? email;

  Validate({this.username, this.name, this.phone, this.password, this.passwordReEnter, this.email});

  Validate.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    phone = json['phone'];
    password = json['password'];
    passwordReEnter = json['password_re_enter'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['password_re_enter'] = this.passwordReEnter;
    data['email'] = this.email;
    return data;
  }
}

class ValidateForgot {
  String? phone;
  String? password;
  String? confirmPassword;

  ValidateForgot({
    this.phone,
    this.password,
    this.confirmPassword,
  });

  ValidateForgot.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    return data;
  }
}
