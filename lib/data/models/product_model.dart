class ProductModel {
  int? id;
  String? name;
  double? price;
  double? oldPrice;
  String? location;
  String? createdAt;
  String? description;
  double? rate;
  List<Images>? images;
  Category? category;
  String? imagesPath;
  List<String>? photoList = [];
  double? proTax;

  ProductModel({
     this.id,
     this.name,
     this.price,
     this.createdAt,
     this.oldPrice,
     this.location,
     this.images,
     this.category,
     this.description,
     this.rate,
     this.imagesPath,
    this.photoList,
    this.proTax,
  });
  ProductModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    createdAt = json["created_at"] ?? "";
    price = double.parse((json["price"] ?? 0.0).toString()); //120
    oldPrice = double.parse((json["old_price"] ?? 0.0).toString()); //150
    location = json["location"] ?? "";
    description = json["description"] ?? "";
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    rate = double.parse((json["rate"] ?? 0.0).toString());
    imagesPath = json["images_path"] ??
        "http://shop-crm.germaniatek.net/public/storage/uploads/products/";
    json["images"].forEach((element) {
      photoList!.add(
          "${json["images_path"] ?? "http://shop-crm.germaniatek.net/public/storage/uploads/products/"}${element["name"]}");
    });
    // proTax =
    // (((json["old_price"]! - json["price"]!) / json["old_price"]!) * 100);

    json["old_price"] != null ? proTax =
    (((json["old_price"]! - json["price"]!) / json["old_price"]!) * 100) : ' ';
  }
}

class OwnerContacts {
  int? id;
  String? userName;
  String? userFirstName;
  String? userLastName;
  String? email;
  String? phoneNumber;
  String? userImagePath;
  dynamic photo;
  String? location;
  double? rate;

  OwnerContacts({
    required this.id,
    required this.userName,
    required this.email,
    this.userFirstName,
    this.userLastName,
    required this.location,
    required this.userImagePath,
    required this.phoneNumber,
    required this.photo,
    required this.rate,
  });

  OwnerContacts.fromJson(Map json) {
    id = json["id"] ?? 0;
    userName = json["user_name"] ?? "User";
    email = json["email"] ?? "";
    userFirstName = json['first_name'];
    userLastName = json['last_name'];
    userImagePath = json['user_image_path'];
    phoneNumber = json["phone_number"] ?? "";
    photo = json["photo"];
    location = json["location"] ?? "";
    rate = json["rate"] ?? 0;
  }
}

class Category {
  int? id;
  Name? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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

class Images {
  int? id;
  String? name;

  Images({this.id,this.name});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
