class LoginModel {
  String? name;
  String? email;
  String? cpf;
  String? password;
  String? passwordCheck;
  bool? premiumAccess;
  bool? paidAccess;

  LoginModel(
      {this.name,
      this.email,
      this.cpf,
      this.password,
      this.passwordCheck,
      this.premiumAccess,
      this.paidAccess});

  LoginModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    password = json['password'];
    passwordCheck = json['passwordCheck'];
    premiumAccess = json['premiumAccess'];
    paidAccess = json['paidAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['password'] = password;
    data['passwordCheck'] = passwordCheck;
    data['premiumAccess'] = premiumAccess;
    data['paidAccess'] = paidAccess;
    return data;
  }
}
