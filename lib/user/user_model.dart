class UserModel {
  String? id;
  String? name;
  String? email;
  String? cpf;
  bool? premiumAccess;
  bool? paidAccess;

  UserModel({
    this.name,
    this.email,
    this.cpf,
    this.premiumAccess,
    this.paidAccess,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id']; 
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    premiumAccess = json['premiumAccess'];
    paidAccess = json['paidAccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['cpf'] = cpf;
    data['premiumAccess'] = premiumAccess;
    data['paidAccess'] = paidAccess;
    return data;
  }
}