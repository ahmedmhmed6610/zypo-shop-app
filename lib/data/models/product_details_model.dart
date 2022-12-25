class ProductDetailsModel {
  int? id;
  String? name;
  double? price;
  double? oldPrice;
  String? location;
  String? description;
  double? rate;
  dynamic status;
  dynamic governorateId;
  dynamic cityId;
  dynamic areaId;
  String? imagesPath;
  List<Options>? options;
  List<String> photoList = [];
  double? proTax;
  OwnerContacts? ownerContacts;
  ProductDetailsMainCategory? productDetailsMainCategory;
  ProductDetailsSubCategory? productDetailsSubCategory;
  Brand? brand;
  bool? isSubscriber;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.governorateId,
    required this.cityId,
    required this.areaId,
    required this.oldPrice,
    required this.location,
    required this.description,
    required this.rate,
    required this.imagesPath,
    required this.photoList,
    this.proTax,
    this.status,
    this.options,
    required this.ownerContacts,
    required this.productDetailsMainCategory,
    required this.productDetailsSubCategory,
    required this.isSubscriber,
  });
  ProductDetailsModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    price = double.parse((json["price"] ?? 0.0).toString()); //120
    oldPrice = double.parse((json["old_price"] ?? 0.0).toString()); //150
    location = json["location"] ?? "";
    governorateId = json["governorate_id"] ?? "";
    cityId = json["city_id"] ?? "";
    areaId = json["area_id"] ?? "";
    description = json["description"] ?? "";
    status = json["status"] ?? "";
    isSubscriber = json["is_subscriber"] ?? "";
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    rate = double.parse((json["rate"] ?? 0.0).toString());
    imagesPath = json["images_path"] ??
        "http://shop-crm.germaniatek.net/public/storage/uploads/products/";
    json["images"].forEach((element) {
      photoList.add(
          "${json["images_path"] ?? "http://shop-crm.germaniatek.net/public/storage/uploads/products/"}${element["name"]}");
    });
    proTax != null ? proTax = (((json["old_price"]! - json["price"]!) / json["old_price"]!) * 100) : '';
    ownerContacts = OwnerContacts.fromJson(json["user"]);
    productDetailsMainCategory =
        ProductDetailsMainCategory.fromJson(json["category"]);
    productDetailsSubCategory =
        ProductDetailsSubCategory.fromJson(json["subcategory"]);
    brand = Brand.fromJson(json["brand"]);
  }
}

class Options {
  int? id;
  int? productId;
  String? key;
  String? value;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Options(
      {this.id,
        this.productId,
        this.key,
        this.value,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    key = json['key'];
    value = json['value'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['key'] = key;
    data['value'] = value;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Brand {
  Name? name;

  Brand({this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) {
      data['name'] = name!.toJson();
    }
    return data;
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

class ProductDetailsMainCategory {
  int? id;
  Name? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ProductDetailsMainCategory(
      {this.id, this.name, this.deletedAt, this.createdAt, this.updatedAt});

  ProductDetailsMainCategory.fromJson(Map<String, dynamic> json) {
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

class ProductDetailsSubCategory {
  int? id;
  int? categoryId;
  Name? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  ProductDetailsSubCategory(
      {this.id,
        this.categoryId,
        this.name,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  ProductDetailsSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


// class ProductDetailsModel {
//   final int id;
//   final String title;
//   final double price;
//   final String description;
//   final String proPicture;
//   // final String location;
//   // final String condition;
//   // final String brand;
//   final List<ProductImages> images;
//   // final int year;
//   // final String color;
//   // final double proTax;
//   final OwnerContacts ownerContacts;
//   Map<String, String> details = {};
//   ProductDetailsModel({
//     required this.id,
//     required this.title,
//     required this.price,
//     required this.description,
//     required this.proPicture,
//     // required this.location,
//     // required this.condition,
//     // required this.brand,
//     // required this.year,
//     // required this.proTax,
//     // required this.color,
//     required this.images,
//     required this.ownerContacts,
//     required this.details,
//   });
// }
//
// class ProductImages {
//   final int id;
//   final String imgUrl;
//   ProductImages({required this.id, required this.imgUrl});
// }
//
// class OwnerContacts {
//   final String img;
//   final String name;
//   final double rate;
//   final String phoneNumber;
//   OwnerContacts({
//     required this.name,
//     required this.img,
//     required this.phoneNumber,
//     required this.rate,
//   });
// }
