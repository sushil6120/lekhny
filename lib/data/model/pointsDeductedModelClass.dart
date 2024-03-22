class PointsDeductedModelClass {
  int? status;
  List<PointsDeductedData>? data;

  PointsDeductedModelClass({this.status, this.data});

  PointsDeductedModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PointsDeductedData>[];
      json['data'].forEach((v) {
        data!.add(new PointsDeductedData.fromJson(v));
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

class PointsDeductedData {
  int? debitPoints;
  String? title;
  String? coverImage;
  String? publishTime;

  PointsDeductedData({this.debitPoints, this.title, this.coverImage, this.publishTime});

  PointsDeductedData.fromJson(Map<String, dynamic> json) {
    debitPoints = json['debitPoints'];
    title = json['title'];
    coverImage = json['CoverImage'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['debitPoints'] = this.debitPoints;
    data['title'] = this.title;
    data['CoverImage'] = this.coverImage;
    data['publishTime'] = this.publishTime;
    return data;
  }
}