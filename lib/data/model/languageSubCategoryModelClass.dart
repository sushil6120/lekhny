class LanguageSubCategoryModelClass {
  int? status;
  List<Data>? data;

  LanguageSubCategoryModelClass({this.status, this.data});

  LanguageSubCategoryModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? subCategory;

  Data({this.subCategory});

  Data.fromJson(Map<String, dynamic> json) {
    subCategory = json['subCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCategory'] = this.subCategory;
    return data;
  }
}