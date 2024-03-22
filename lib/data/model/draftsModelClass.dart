class DraftsModelClass {
  int? status;
  List<Data>? data;

  DraftsModelClass({this.status, this.data});

  DraftsModelClass.fromJson(Map<String, dynamic> json) {
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
  String? bookCoverImage;
  String? bookTitle;
  int? totalViwers;
  int? isCompPost;

  Data(
      {this.id,
        this.bookCoverImage,
        this.bookTitle,
        this.totalViwers,
        this.isCompPost});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookCoverImage = json['bookCoverImage'];
    bookTitle = json['BookTitle'];
    totalViwers = json['totalViwers'];
    isCompPost = json['isCompPost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bookCoverImage'] = this.bookCoverImage;
    data['BookTitle'] = this.bookTitle;
    data['totalViwers'] = this.totalViwers;
    data['isCompPost'] = this.isCompPost;
    return data;
  }
}