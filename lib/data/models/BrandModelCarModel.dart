class BrandModelCarModel {
  int? status;
  List<BrandModelCarResponseModel>? data;

  BrandModelCarModel({this.status, this.data});

  BrandModelCarModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BrandModelCarResponseModel>[];
      json['data'].forEach((v) {
        data!.add(BrandModelCarResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandModelCarResponseModel {
  String? inputLabel;
  String? inputType;
  String? inputName;
  List<String>? options;
  List<String>? optionsLabel;

  BrandModelCarResponseModel(
      {this.inputLabel,
        this.inputType,
        this.inputName,
        this.options,
        this.optionsLabel});

  BrandModelCarResponseModel.fromJson(Map<String, dynamic> json) {
    inputLabel = json['input_label'];
    inputType = json['input_type'];
    inputName = json['input_name'];
    options = json['options'].cast<String>();
    optionsLabel = json['options_label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['input_label'] = inputLabel;
    data['input_type'] = inputType;
    data['input_name'] = inputName;
    data['options'] = options;
    data['options_label'] = optionsLabel;
    return data;
  }
}
