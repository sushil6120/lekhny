class ReadingHistoryModelClass {
  int? status;
  List<ReadingHistoryData>? data;

  ReadingHistoryModelClass({this.status, this.data});

  ReadingHistoryModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ReadingHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new ReadingHistoryData.fromJson(v));
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

class ReadingHistoryData {
  String? title;
  String? bookCover;
  String? author;
  int? authorID;
  int? postID;
  int? views;

  ReadingHistoryData(
      {this.title,
        this.bookCover,
        this.author,
        this.authorID,
        this.postID,
        this.views});

  ReadingHistoryData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    bookCover = json['bookCover'];
    author = json['author'];
    authorID = json['authorID'];
    postID = json['postID'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['bookCover'] = this.bookCover;
    data['author'] = this.author;
    data['authorID'] = this.authorID;
    data['postID'] = this.postID;
    data['views'] = this.views;
    return data;
  }
}