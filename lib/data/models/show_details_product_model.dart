class ShowDetailsProductModel {
  List<ShowDetailsProductResponseModel>? data;

  ShowDetailsProductModel({this.data});

  ShowDetailsProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowDetailsProductResponseModel>[];
      json['data'].forEach((v) {
        data!.add(ShowDetailsProductResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowDetailsProductResponseModel {
  int? id;
  String? name;
  int? price;
  int? oldPrice;
  dynamic whatsNumber;
  String? location;
  String? createdAt;
  String? description;
  int? isSold;
  dynamic governorateId;
  dynamic cityId;
  dynamic areaId;
  dynamic brandId;
  List<Images>? images;
  User? user;
  int? status;
  StateModel? stateModel;
  CountryModel? countryModel;
  List<String>? photoList = [];
  Category? category;
  Subcategory? subcategory;
  Brand? brand;
  List<Options>? options;
  int? rate;
  String? imagesPath;
  bool? isSubscriber;

  ShowDetailsProductResponseModel(
      {this.id,
        this.name,
        this.price,
        this.oldPrice,
        this.createdAt,
        this.location,
        this.governorateId,
        this.whatsNumber,
        this.stateModel,
        this.countryModel,
        this.cityId,
        this.areaId,
        this.description,
        this.brandId,
        this.isSold,
        this.images,
        this.status,
        this.user,
        this.category,
        this.photoList,
        this.subcategory,
        this.brand,
        this.options,
        this.rate,
        this.isSubscriber,
        this.imagesPath});

  ShowDetailsProductResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    createdAt = json['created_at'];
    whatsNumber = json['whats_number'];
    governorateId = json['governorate_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    oldPrice = json['old_price'];
    brandId = json['brand_id'];
    location = json['location'];
    status = json['status'];
    description = json['description'];
    isSold = json['is_sold'];
    json["images"].forEach((element) {
      photoList!.add(
          "${json["images_path"] ?? "http://shop-crm.germaniatek.net/public/storage/uploads/products/"}${element["name"]}");
    });
    countryModel = json['country'] != null ? CountryModel.fromJson(json['country']) : null;
    stateModel = json['state'] != null ? StateModel.fromJson(json['state']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? Subcategory.fromJson(json['subcategory'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    rate = json['rate'];
    imagesPath = json['images_path'];
    isSubscriber = json['is_subscriber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['governorate_id'] = governorateId;
    data['city_id'] = cityId;
    data['area_id'] = areaId;
    data['whats_number'] = whatsNumber;
    data['brand_id'] = brandId;
    data['created_at'] = createdAt;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['location'] = location;
    data['description'] = description;
    data['status'] = status;
    data['is_sold'] = isSold;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['rate'] = rate;
    data['images_path'] = imagesPath;
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

class StateModel {
  int? id;
  String? name;

  StateModel({this.id,this.name});

  StateModel.fromJson(Map<String, dynamic> json) {
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

class CountryModel {
  int? id;
  String? name;

  CountryModel({this.id,this.name});

  CountryModel.fromJson(Map<String, dynamic> json) {
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


class User {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? emailVerifiedAt;
  String? phoneNumber;
  String? userImagePath;
  int? isVerified;
  int? type;
  String? photo;
  String? location;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.email,
        this.emailVerifiedAt,
        this.phoneNumber,
        this.userImagePath,
        this.isVerified,
        this.type,
        this.photo,
        this.location,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    email = json['email'];
    userImagePath = json['user_image_path'];
    emailVerifiedAt = json['email_verified_at'];
    phoneNumber = json['phone_number'];
    isVerified = json['isVerified'];
    type = json['type'];
    photo = json["photo"];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['email'] = email;
    data['user_image_path'] = userImagePath;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_number'] = phoneNumber;
    data['isVerified'] = isVerified;
    data['type'] = type;
    data['photo'] = photo;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
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

class Subcategory {
  int? id;
  int? categoryId;
  Name? name;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Subcategory(
      {this.id,
        this.categoryId,
        this.name,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Subcategory.fromJson(Map<String, dynamic> json) {
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


class Options {
  int? id;
  int? productId;
  String? key;
  String? value;
  String? valueAr;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Options(
      {this.id,
        this.productId,
        this.key,
        this.value,
        this.valueAr,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    key = json['key'];
    value = json['value'];
    valueAr = json['value_ar'];
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
    data['value_ar'] = valueAr;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
