class MyFavoriteUserModel {
  List<MyFavoriteUserResponseModel>? subscribers;

  MyFavoriteUserModel({this.subscribers});

  MyFavoriteUserModel.fromJson(Map<String, dynamic> json) {
    if (json['subscribers'] != null) {
      subscribers = <MyFavoriteUserResponseModel>[];
      json['subscribers'].forEach((v) {
        subscribers!.add(new MyFavoriteUserResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subscribers != null) {
      data['subscribers'] = this.subscribers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyFavoriteUserResponseModel {
  int? id;
  int? userId;
  int? subscriberId;
  String? createdAt;
  String? updatedAt;
  User? user;

  MyFavoriteUserResponseModel(
      {this.id,
        this.userId,
        this.subscriberId,
        this.createdAt,
        this.updatedAt,
        this.user});

  MyFavoriteUserResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    subscriberId = json['subscriber_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['subscriber_id'] = this.subscriberId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
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
  int? productsCount;
  String? userImagePath;

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
        this.updatedAt,
        this.productsCount,
        this.userImagePath});

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
    productsCount = json['products_count'];
    userImagePath = json['user_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_name'] = this.userName;
    data['phone_number'] = this.phoneNumber;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['isVerified'] = this.isVerified;
    data['location'] = this.location;
    data['type'] = this.type;
    data['renew_count'] = this.renewCount;
    data['fcm_token'] = this.fcmToken;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['products_count'] = this.productsCount;
    data['user_image_path'] = this.userImagePath;
    return data;
  }
}
