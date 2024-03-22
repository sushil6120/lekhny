class TopSeriesModelClass {
  int? status;
  List<TopSeriesData>? data;

  TopSeriesModelClass({this.status, this.data});

  TopSeriesModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TopSeriesData>[];
      json['data'].forEach((v) {
        data!.add(new TopSeriesData.fromJson(v));
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

class TopSeriesData {
  int? ttoalPart;
  int? totalViwers;
  int? postID;
  String? bookCoverImage;
  String? bookTitle;
  String? writer;
  int? writerID;

  TopSeriesData(
      {this.ttoalPart,
        this.totalViwers,
        this.postID,
        this.bookCoverImage,
        this.bookTitle,
        this.writer,
        this.writerID});

  TopSeriesData.fromJson(Map<String, dynamic> json) {
    ttoalPart = json['ttoalPart'];
    totalViwers = json['totalViwers'];
    postID = json['postID'];
    bookCoverImage = json['bookCoverImage'];
    bookTitle = json['BookTitle'];
    writer = json['writer'];
    writerID = json['writerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ttoalPart'] = this.ttoalPart;
    data['totalViwers'] = this.totalViwers;
    data['postID'] = this.postID;
    data['bookCoverImage'] = this.bookCoverImage;
    data['BookTitle'] = this.bookTitle;
    data['writer'] = this.writer;
    data['writerID'] = this.writerID;
    return data;
  }
}