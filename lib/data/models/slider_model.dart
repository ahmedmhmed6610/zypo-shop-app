class SliderModel {
  List<SliderResponseModel>? sliderResponseModel;

  SliderModel({this.sliderResponseModel});

  SliderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      sliderResponseModel = <SliderResponseModel>[];
      json['data'].forEach((v) {
        sliderResponseModel!.add(SliderResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliderResponseModel != null) {
      data['data'] = sliderResponseModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderResponseModel {
  int? id;
  String? text;
  String? link;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? bannerImagePath;
  ImageSlider? image;

  SliderResponseModel(
      {this.id,
        this.text,
        this.link,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.bannerImagePath,
        this.image});

  SliderResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    link = json['link'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bannerImagePath = json['banner_image_path'];
    image = json['image'] != null ? ImageSlider.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['link'] = link;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['banner_image_path'] = bannerImagePath;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class ImageSlider {
  int? imageableId;
  String? name;

  ImageSlider({this.imageableId, this.name});

  ImageSlider.fromJson(Map<String, dynamic> json) {
    imageableId = json['imageable_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageable_id'] = imageableId;
    data['name'] = name;
    return data;
  }
}
