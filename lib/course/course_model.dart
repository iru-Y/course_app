class CourseModel {
  String? id;
  String? title;
  String? description;
  String? price;
  List<String>? modules;
  bool? lifetime;
  bool? premium;

  CourseModel({
    this.id,
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
    modules = json['modules'] != null ? List<String>.from(json['modules']) : [];
    lifetime = json['lifetime'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['modules'] = modules;
    data['lifetime'] = lifetime;
    data['premium'] = premium;
    return data;
  }
}
