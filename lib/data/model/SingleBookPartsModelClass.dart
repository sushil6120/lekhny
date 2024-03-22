class SingleBookPartsModelClass {
  int? status;
  List<Data>? data;

  SingleBookPartsModelClass({this.status, this.data});

  SingleBookPartsModelClass.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? totalViwers;
  String? publishDate;
  int? totalLikes;
  String? bookTitle;
  int? publishStatus;

  Data(
      {this.id,
        this.totalViwers,
        this.publishDate,
        this.totalLikes,
        this.bookTitle,
        this.publishStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalViwers = json['totalViwers'];
    publishDate = json['publishDate'];
    totalLikes = json['totalLikes'];
    bookTitle = json['BookTitle'];
    publishStatus = json['publishStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalViwers'] = this.totalViwers;
    data['publishDate'] = this.publishDate;
    data['totalLikes'] = this.totalLikes;
    data['BookTitle'] = this.bookTitle;
    data['publishStatus'] = this.publishStatus;
    return data;
  }
}