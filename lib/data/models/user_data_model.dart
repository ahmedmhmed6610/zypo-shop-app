import 'package:shop/utils/app_constants.dart';

class UserDataModel {
  int? id;
  String? userName;
  String? email;
  String? emailVerifiedAt;
  String? phoneNumber;
  int? isVerified;
  String? userImagePath;
  int? type;
  String? photo;
  String? location;
  String? createdAt;
  String? updatedAt;
  String? token;
  UserDataModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.emailVerifiedAt,
    required this.phoneNumber,
    required this.userImagePath,
    required this.isVerified,
    required this.type,
    required this.photo,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });
  UserDataModel.empty() {
    id = 0;
    userName = "";
    email = "";
    emailVerifiedAt = DateTime.now().toIso8601String();
    userImagePath = "";
    phoneNumber = "";
    isVerified = 0;
    type = 0;
    photo = profileImage;
    location = "";
    createdAt = DateTime.now().toIso8601String();
    updatedAt = DateTime.now().toIso8601String();
    token = "";
  }

  UserDataModel.fromJson(Map json) {
    id = json["id"] ?? 0;
    userName = json["user_name"] ?? "user";
    email = json["email"] ?? "dummy@mail.com";
    emailVerifiedAt = json["email_verified_at"] ?? DateTime.now().toString();
    phoneNumber = json["phone_number"] ?? "01287059341";
    isVerified = json["isVerified"] ?? 0;
    userImagePath = json["user_default_image"] ?? 0;
    type = json["type"] ?? 0;
    photo = json["photo"] ?? profileImage;
    location = json["location"] ?? "";
    createdAt = json["created_at"] ?? DateTime.now().toString();
    updatedAt = json["updated_at"] ?? DateTime.now().toString();
    token = json["token"] ?? "";
  }
}
