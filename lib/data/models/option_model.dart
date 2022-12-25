class OptionModel {
  List<Data>? data;

  OptionModel({this.data});

  OptionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? categoryId;
  String? inputLabel;
  String? inputType;
  String? inputName;
  List<String>? options;
  List<String>? optionsLabel;

  Data(
      {this.id,
        this.categoryId,
        this.inputLabel,
        this.inputType,
        this.inputName,
        this.options,
        this.optionsLabel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    inputLabel = json['input_label'];
    inputType = json['input_type'];
    inputName = json['input_name'];
    options = json['options'].cast<String>();
    optionsLabel = json['options_label'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['input_label'] = inputLabel;
    data['input_type'] = inputType;
    data['input_name'] = inputName;
    data['options'] = options;
    data['options_label'] = optionsLabel;
    return data;
  }
}
