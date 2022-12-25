class MyProductUserModel {
  List<MyProductUserResponseModel>? data;
  Links? links;
  Meta? meta;

  MyProductUserModel({this.data, this.links, this.meta});

  MyProductUserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MyProductUserResponseModel>[];
      json['data'].forEach((v) {
        data!.add(MyProductUserResponseModel.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class MyProductUserResponseModel {
  int? id;
  String? name;
  int? price;
  int? oldPrice;
  String? location;
  String? createdAt;
  String? description;
  int? isSold;
  int? status;
  List<Images>? images;
  User? user;
  Category? category;
  Subcategory? subcategory;
  Brand? brand;
//  List<Options>? options;
  int? rate;
  String? imagesPath;
  List<String>? photoList = [];
  double? proTax;
  bool? isSubscriber;

  MyProductUserResponseModel(
      {this.id,
        this.createdAt,
        this.name,
        this.price,
        this.oldPrice,
        this.location,
        this.description,
        this.isSold,
        this.proTax,
        this.photoList,
        this.status,
        this.images,
        this.user,
        this.isSubscriber,
        this.category,
        this.subcategory,
        this.brand,
      //  this.options,
        this.rate,
        this.imagesPath});

  MyProductUserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    location = json['location'];
    createdAt = json['created_at'];
    description = json['description'];
    isSold = json['is_sold'];
    status = json['status'];
    isSubscriber = json['is_subscriber'];
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
    // if (json['options'] != null) {
    //   options = <Options>[];
    //   json['options'].forEach((v) {
    //     options!.add(new Options.fromJson(v));
    //   });
    // }
    rate = json['rate'];
    imagesPath = json["images_path"] ??
        "http://shop-crm.germaniatek.net/public/storage/uploads/products/";
    json["images"].forEach((element) {
      photoList!.add(
          "${json["images_path"] ?? "http://shop-crm.germaniatek.net/public/storage/uploads/products/"}${element["name"]}");
    });
    json["old_price"] != null ?
    proTax =
    (((json["old_price"]! - json["price"]!) / json["old_price"]!) * 100) : ' ';

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['created_at'] = createdAt;
    data['location'] = location;
    data['is_subscriber'] = isSubscriber;
    data['description'] = description;
    data['is_sold'] = isSold;
    data['status'] = status;
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
    // if (this.options != null) {
    //   data['options'] = this.options!.map((v) => v.toJson()).toList();
    // }
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


class User {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? phoneNumber;
  String? photo;
  String? email;
  String? emailVerifiedAt;
  int? isVerified;
  String? location;
  int? type;
  int? renewCount;
  String? fcmToken;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.userName,
        this.phoneNumber,
        this.photo,
        this.email,
        this.emailVerifiedAt,
        this.isVerified,
        this.location,
        this.type,
        this.renewCount,
        this.fcmToken,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    phoneNumber = json['phone_number'];
    photo = json['photo'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    isVerified = json['isVerified'];
    location = json['location'];
    type = json['type'];
    renewCount = json['renew_count'];
    fcmToken = json['fcm_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['phone_number'] = phoneNumber;
    data['photo'] = photo;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['isVerified'] = isVerified;
    data['location'] = location;
    data['type'] = type;
    data['renew_count'] = renewCount;
    data['fcm_token'] = fcmToken;
    data['deleted_at'] = deletedAt;
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

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.links,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
