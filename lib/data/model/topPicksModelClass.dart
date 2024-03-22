class TopPicksModelClass {
  int? status;
  List<TopPicksData>? data;

  TopPicksModelClass({this.status, this.data});

  TopPicksModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TopPicksData>[];
      json['data'].forEach((v) {
        data!.add(new TopPicksData.fromJson(v));
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

class TopPicksData {
  int? totalViwers;
  int? totalLike;
  int? postID;
  String? bookCoverImage;
  String? bookTitle;
  String? sortDetails;
  String? writer;
  int? writerID;

  TopPicksData(
      {this.totalViwers,
        this.totalLike,
        this.postID,
        this.bookCoverImage,
        this.bookTitle,
        this.sortDetails,
        this.writer,
        this.writerID});

  TopPicksData.fromJson(Map<String, dynamic> json) {
    totalViwers = json['totalViwers'];
    totalLike = json['totalLike'];
    postID = json['postID'];
    bookCoverImage = json['bookCoverImage'];
    bookTitle = json['BookTitle'];
    sortDetails = json['sortDetails'];
    writer = json['writer'];
    writerID = json['writerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalViwers'] = this.totalViwers;
    data['totalLike'] = this.totalLike;
    data['postID'] = this.postID;
    data['bookCoverImage'] = this.bookCoverImage;
    data['BookTitle'] = this.bookTitle;
    data['sortDetails'] = this.sortDetails;
    data['writer'] = this.writer;
    data['writerID'] = this.writerID;
    return data;
  }
}