class AreaModel {
  AreaResponseModel? data;

  AreaModel({this.data});

  AreaModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? AreaResponseModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AreaResponseModel {
  int? id;
  int? governorateId;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Areas>? areas;

  AreaResponseModel(
      {this.id,
        this.governorateId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.areas});

  AreaResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateId = json['governorate_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['governorate_id'] = governorateId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (areas != null) {
      data['areas'] = areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  int? id;
  int? cityId;
  String? name;
  String? createdAt;
  String? updatedAt;

  Areas({this.id, this.cityId, this.name, this.createdAt, this.updatedAt});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityId = json['city_id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city_id'] = cityId;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
