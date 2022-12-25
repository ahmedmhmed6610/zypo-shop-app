class CategoryModel {
  int? id;
  Name? name;
  String? image;
  int? parentId;
  int? isParent;

  CategoryModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.isParent,
  });

  CategoryModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    image = json["image"] ??
        "https://static.vecteezy.com/system/resources/previews/005/129/872/original/category-black-filled-icon-style-free-vector.jpg";
    isParent = json["isParent"] ?? 0;
    parentId = json["parentID"] ?? 0;
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
