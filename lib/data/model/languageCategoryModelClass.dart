class LanguageCategoryModelClass {
  int? status;
  List<Data>? data;

  LanguageCategoryModelClass({this.status, this.data});

  LanguageCategoryModelClass.fromJson(Map<String, dynamic> json) {
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
  String? languageCategory;
  int? isMothalyComp;
  int? categoryId;

  Data({this.languageCategory, this.isMothalyComp, this.categoryId});

  Data.fromJson(Map<String, dynamic> json) {
    languageCategory = json['languageCategory'];
    isMothalyComp = json['isMothalyComp'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['languageCategory'] = this.languageCategory;
    data['isMothalyComp'] = this.isMothalyComp;
    data['categoryId'] = this.categoryId;
    return data;
  }
}