class PointsEarnedModelClass {
  int? status;
  String? calculationON;
  List<PointsEarnedData>? data;

  PointsEarnedModelClass({this.status, this.calculationON, this.data});

  PointsEarnedModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    calculationON = json['calculationON'];
    if (json['data'] != null) {
      data = <PointsEarnedData>[];
      json['data'].forEach((v) {
        data!.add(new PointsEarnedData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['calculationON'] = this.calculationON;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PointsEarnedData {
  String? title;
  int? postID;
  int? likes;

  PointsEarnedData({this.title, this.postID, this.likes});

  PointsEarnedData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    postID = json['postID'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['postID'] = this.postID;
    data['likes'] = this.likes;
    return data;
  }
}