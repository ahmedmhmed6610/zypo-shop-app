

class DetailsProductModel {
  List<DetailsProductResponseModel>? data;

  DetailsProductModel({this.data});

  DetailsProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DetailsProductResponseModel>[];
      json['data'].forEach((v) {
        data!.add(DetailsProductResponseModel.fromJson(v));
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

class DetailsProductResponseModel {
  int? id;
  String? name;
  double? price;
  double? oldPrice;
  String? location;
  String? description;
  List<Images>? images;
  List<String> photoList = [];
  OwnerContacts? user;
  ProductDetailsMainCategory? category;
  Images? subcategory;
  Images? brand;
  double? proTax;
  double? rate;
  String? imagesPath;

  DetailsProductResponseModel(
      {this.id,
        this.name,
        this.price,
        this.oldPrice,
        this.location,
        this.description,
        this.images,
        this.proTax,
       required this.photoList,
        this.user,
        this.category,
        this.subcategory,
        this.brand,
        this.rate,
        this.imagesPath});

  DetailsProductResponseModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
    price = double.parse((json["price"] ?? 0.0).toString()); //120
    oldPrice = double.parse((json["old_price"] ?? 0.0).toString()); //150
    location = json["location"] ?? "";
    description = json["description"] ?? "";
    rate = double.parse((json["rate"] ?? 0.0).toString());
    imagesPath = json["images_path"] ??
        "http://shop-crm.germaniatek.net/public/storage/uploads/products/";
    json["images"].forEach((element) {
      photoList.add(
          "${json["images_path"] ?? "http://shop-crm.germaniatek.net/public/storage/uploads/products/"}${element["name"]}");
    });
    proTax =
    (((json["old_price"]! - json["price"]!) / json["old_price"]!) * 100);
    user = OwnerContacts.fromJson(json["user"]);
    category =
        ProductDetailsMainCategory.fromJson(json["category"]);
    subcategory =
        Images.fromJson(json["subcategory"]);
    brand = json["brand"]["brand"] ?? "Shop";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['location'] = location;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    // if (this.user != null) {
    //   data['user'] = this.user!.toJson();
    // }
    // if (this.category != null) {
    //   data['category'] = this.category!.toJson();
    // }
    if (subcategory != null) {
      data['subcategory'] = subcategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['rate'] = rate;
    data['images_path'] = imagesPath;
    return data;
  }
}

class Images {
  String? name;

  Images({this.name});

  Images.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class OwnerContacts {
  int? id;
  String? userName;
  String? email;
  String? phoneNumber;
  String? photo;
  String? location;
  double? rate;

  OwnerContacts({
    required this.id,
    required this.userName,
    required this.email,
    required this.location,
    required this.phoneNumber,
    required this.photo,
    required this.rate,
  });

  OwnerContacts.fromJson(Map json) {
    id = json["id"] ?? 0;
    userName = json["user_name"] ?? "User";
    email = json["email"] ?? "";
    phoneNumber = json["phone_number"] ?? "";
    photo = json["photo"] ??
        "https://img.freepik.com/free-photo/excited-man-celebrating-victory-rejoicing-making-fist-pump-gesture-winning-looking-satisfied-saying-yes-achieve-goal-standing-light-turquoise-wall_1258-23890.jpg?w=1060&t=st=1660172869~exp=1660173469~hmac=0ed5bff0eaf4351e4f8be5777ffbcc142793655b001ccf3f66e9743a45634605";
    location = json["location"] ?? "";
    rate = json["rate"] ?? 0;
  }
}

class ProductDetailsMainCategory {
  int? id;
  String? name;
  ProductDetailsMainCategory({
    required this.id,
    required this.name,
  });
  ProductDetailsMainCategory.fromJson(Map json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? "";
  }
}

class ProductDetailsSubCategory {
  int? id;
  int? categoryId;
  String? name;
  ProductDetailsSubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
  });
  ProductDetailsSubCategory.fromJson(Map json) {
    id = json["id"] ?? 0;
    categoryId = json["category_id"] ?? 0;
    name = json["name"] ?? "";
  }
}
