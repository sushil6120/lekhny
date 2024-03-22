class SubCategoryModelClass {
  int? status;
  List<Data>? data;

  SubCategoryModelClass({this.status, this.data});

  SubCategoryModelClass.fromJson(Map<String, dynamic> json) {
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
  int? subCatID;
  String? subCategory;

  Data({this.subCatID, this.subCategory});

  Data.fromJson(Map<String, dynamic> json) {
    subCatID = json['subCatID'];
    subCategory = json['subCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCatID'] = this.subCatID;
    data['subCategory'] = this.subCategory;
    return data;
  }
}