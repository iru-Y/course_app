class RegisterModel {
  String? name;
  String? email;
  String? cpf;
  String? password;
  String? passwordCheck;
  bool? premiumAccess;
  bool? paidAccess;

  RegisterModel(
      {this.name,
      this.email,
      this.cpf,
      this.password,
      this.passwordCheck,
      this.premiumAccess,
      this.paidAccess});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    password = json['password'];
    passwordCheck = json['passwordCheck'];
    premiumAccess = json['premiumAccess'];
    paidAccess = json['paidAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['cpf'] = this.cpf;
    data['password'] = this.password;
    data['passwordCheck'] = this.passwordCheck;
    data['premiumAccess'] = this.premiumAccess;
    data['paidAccess'] = this.paidAccess;
    return data;
  }
}
