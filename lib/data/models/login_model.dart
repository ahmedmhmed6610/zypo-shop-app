class LoginModel {
  LoginModel({
      this.message, 
      this.user, 
      this.status,});

  LoginModel.fromJson(dynamic json) {
    message = json['message'];
    user = json['data'] != null ? User.fromJson(json['data']) : null;
    status = json['success'];
  }
  String? message;
  User? user;
  bool? status;
LoginModel copyWith({  String? message,
  User? user,
  bool? status,
}) => LoginModel(  message: message ?? this.message,
  user: user ?? this.user,
  status: status ?? this.status,
);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['message'] = message;
    if (user != null) {
      map['data'] = user?.toJson();
    }
    map['success'] = status;
    return map;
  }

}

class User {
  User({
      this.id, 
      this.userFirstName, 
      this.userLastName, 
      this.phoneNumber, 
      this.userEmail, 
      this.isVerified, 
      this.createdAt, 
      this.updatedAt, 
      this.userImagePath,
      this.photo,
      this.role,
      this.roleId, 
      this.userName, 
      this.fcmToken, 
      this.plz, 
      this.emailVerifiedAt, 
      this.verificationCode, 
      this.token, 
      this.primary,});

  User.fromJson(dynamic json) {
    id = json['id'];
    userFirstName = json['first_name'];
    userLastName = json['last_name'];
    phoneNumber = json['phone_number'];
    userEmail = json['email'];
    isVerified = json['isVerified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userImagePath = json['user_image_path'];
    photo = json['photo'];
    role = json['role'];
    roleId = json['role_id'];
    userName = json['user_name'];
    fcmToken = json['fcm_token'];
    plz = json['plz'];
    emailVerifiedAt = json['email_verified_at'];
    verificationCode = json['verification_code'];
    token = json['token'];
    primary = json['primary'];
  }
  int? id;
  String? userFirstName;
  String? userLastName;
  String? phoneNumber;
  dynamic photo;
  String? userEmail;
  dynamic isVerified;
  String? createdAt;
  String? updatedAt;
  String? userImagePath;
  String? role;
  String? roleId;
  String? userName;
  dynamic fcmToken;
  dynamic plz;
  dynamic emailVerifiedAt;
  dynamic verificationCode;
  String? token;
  String? primary;
User copyWith({  int? id,
  String? userFirstName,
  String? userLastName,
  String? phoneNumber,
  String? userEmail,
  dynamic isVerified,
  dynamic photo,
  String? userImagePath,
  String? createdAt,
  String? updatedAt,
  String? role,
  String? roleId,
  String? userName,
  dynamic fcmToken,
  dynamic plz,
  dynamic emailVerifiedAt,
  dynamic verificationCode,
  String? token,
  String? primary,
}) => User(  id: id ?? this.id,
  userFirstName: userFirstName ?? this.userFirstName,
  userLastName: userLastName ?? this.userLastName,
  phoneNumber: phoneNumber ?? this.phoneNumber,
  userEmail: userEmail ?? this.userEmail,
  photo: photo ?? this.photo,
  isVerified: isVerified ?? this.isVerified,
  createdAt: createdAt ?? this.createdAt,
  userImagePath: createdAt ?? this.userImagePath,
  updatedAt: updatedAt ?? this.updatedAt,
  role: role ?? this.role,
  roleId: roleId ?? this.roleId,
  userName: userName ?? this.userName,
  fcmToken: fcmToken ?? this.fcmToken,
  plz: plz ?? this.plz,
  emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
  verificationCode: verificationCode ?? this.verificationCode,
  token: token ?? this.token,
  primary: primary ?? this.primary,
);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = userFirstName;
    map['last_name'] = userLastName;
    map['phone_number'] = phoneNumber;
    map['photo'] = photo;
    map['email'] = userEmail;
    map['isVerified'] = isVerified;
    map['created_at'] = createdAt;
    map['user_image_path'] = userImagePath;
    map['updated_at'] = updatedAt;
    map['role'] = role;
    map['role_id'] = roleId;
    map['user_name'] = userName;
    map['fcm_token'] = fcmToken;
    map['plz'] = plz;
    map['email_verified_at'] = emailVerifiedAt;
    map['verification_code'] = verificationCode;
    map['token'] = token;
    map['primary'] = primary;
    return map;
  }

}