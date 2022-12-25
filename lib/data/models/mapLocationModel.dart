class MapLocationModel {
  bool? success;
  LocationResponseModel? locationResponseModel;
  String? message;

  MapLocationModel({this.success, this.locationResponseModel, this.message});

  MapLocationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    locationResponseModel = json['data'] != null ? new LocationResponseModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.locationResponseModel != null) {
      data['data'] = this.locationResponseModel!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class LocationResponseModel {
  double? lat;
  double? lng;

  LocationResponseModel({this.lat, this.lng});

  LocationResponseModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
