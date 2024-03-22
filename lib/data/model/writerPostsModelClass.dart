class WriterPostsModelClass {
  int? status;
  List<WriterSinglePostsData>? data;

  WriterPostsModelClass({this.status, this.data});

  WriterPostsModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WriterSinglePostsData>[];
      json['data'].forEach((v) {
        data!.add(new WriterSinglePostsData.fromJson(v));
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

class WriterSinglePostsData {
  int? postID;
  int? totalViwers;
  String? bookCoverImage;
  String? bookTitle;
  String? name;

  WriterSinglePostsData(
      {this.postID,
        this.totalViwers,
        this.bookCoverImage,
        this.bookTitle,
        this.name});

  WriterSinglePostsData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    totalViwers = json['totalViwers'];
    bookCoverImage = json['bookCoverImage'];
    bookTitle = json['BookTitle'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['totalViwers'] = this.totalViwers;
    data['bookCoverImage'] = this.bookCoverImage;
    data['BookTitle'] = this.bookTitle;
    data['name'] = this.name;
    return data;
  }
}