class ResponseModel {
  bool? success;
  dynamic data;
  String? message;

  ResponseModel({this.success, this.data, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] ;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

