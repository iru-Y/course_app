class CourseModel {
  String? id;
  String? title;
  String? description;
  String? price;
  List<String>? modules;
  bool? lifetime;
  bool? premium;

  CourseModel({
    this.title,
    this.description,
    this.price,
    this.modules,
    this.lifetime,
    this.premium,
  });

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    modules = json['modules'].cast<String>();
    lifetime = json['lifetime'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['modules'] = this.modules;
    data['lifetime'] = this.lifetime;
    data['premium'] = this.premium;
    return data;
  }
}
