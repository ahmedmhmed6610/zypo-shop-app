class BrandModel {
  int? id;
  Name? brandName;
  int? categoryId;

  BrandModel({required this.id, required this.brandName, this.categoryId});
  BrandModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    brandName = json['name'] != null ? Name.fromJson(json['name']) : null;
    categoryId = json["category_id"] ?? 0;
  }
}

class Name {
  String? en;
  String? ar;
  String? de;
  String? tr;

  Name({this.en, this.ar, this.de, this.tr});

  Name.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    ar = json['ar'];
    de = json['de'];
    tr = json['tr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['en'] = en;
    data['ar'] = ar;
    data['de'] = de;
    data['tr'] = tr;
    return data;
  }
}