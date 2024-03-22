class CategoryModelClass {
  int? status;
  List<Data>? data;

  CategoryModelClass({this.status, this.data});

  CategoryModelClass.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;
  int? categoryID;
  int? isCompetition;
  String? categoryImg;

  Data(
      {this.categoryName,
        this.categoryID,
        this.isCompetition,
        this.categoryImg});

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryID = json['categoryID'];
    isCompetition = json['isCompetition'];
    categoryImg = json['categoryImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['categoryID'] = this.categoryID;
    data['isCompetition'] = this.isCompetition;
    data['categoryImg'] = this.categoryImg;
    return data;
  }
}