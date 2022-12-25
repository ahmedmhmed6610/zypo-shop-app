class NotificationModel {
  List<NotificationResponseModel>? notificationResponseModel;

  NotificationModel({this.notificationResponseModel});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notificationResponseModel = <NotificationResponseModel>[];
      json['data'].forEach((v) {
        notificationResponseModel!.add(NotificationResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationResponseModel != null) {
      data['data'] = notificationResponseModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationResponseModel {
  String? title;
  String? details;
  int? productId;
  dynamic prodcut;

  NotificationResponseModel({this.title, this.details, this.productId, this.prodcut});

  NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    details = json['details'];
    productId = json['product_id'];
    prodcut = json['prodcut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['details'] = details;
    data['product_id'] = productId;
    data['prodcut'] = prodcut;
    return data;
  }
}
