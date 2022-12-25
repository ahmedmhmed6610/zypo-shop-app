class GovernmentModel {
  bool? success;
  bool? data;
  List<Message>? message;

  GovernmentModel({this.success, this.data, this.message});

  GovernmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int? id;
  String? name;
  String? shortName;
  String? flagImg;
  String? countryCode;
  String? createdAt;
  String? updatedAt;

  Message(
      {this.id,
        this.name,
        this.shortName,
        this.flagImg,
        this.countryCode,
        this.createdAt,
        this.updatedAt});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['short_name'];
    flagImg = json['flag_img'];
    countryCode = json['country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['short_name'] = this.shortName;
    data['flag_img'] = this.flagImg;
    data['country_code'] = this.countryCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
