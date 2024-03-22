class SingleBookDetailsModelClass {
  int? status;
  List<Data>? data;

  SingleBookDetailsModelClass({this.status, this.data});

  SingleBookDetailsModelClass.fromJson(Map<String, dynamic> json) {
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
  int? postID;
  int? views;
  String? bookCover;
  String? title;
  String? author;
  int? authorID;
  int? totalPart;
  int? alliViewser;
  String? sortDetails;
  String? languageID;
  String? languageCategory;
  int? publishStatus;
  int? totalLikes;

  Data(
      {this.postID,
        this.views,
        this.bookCover,
        this.title,
        this.author,
        this.authorID,
        this.totalPart,
        this.alliViewser,
        this.sortDetails,
        this.languageID,
        this.languageCategory,
        this.publishStatus,
        this.totalLikes});

  Data.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    views = json['views'];
    bookCover = json['bookCover'];
    title = json['title'];
    author = json['author'];
    authorID = json['authorID'];
    totalPart = json['totalPart'];
    alliViewser = json['alliViewser'];
    sortDetails = json['sortDetails'];
    languageID = json['languageID'];
    languageCategory = json['LanguageCategory'];
    publishStatus = json['publishStatus'];
    totalLikes = json['totalLikes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['views'] = this.views;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['author'] = this.author;
    data['authorID'] = this.authorID;
    data['totalPart'] = this.totalPart;
    data['alliViewser'] = this.alliViewser;
    data['sortDetails'] = this.sortDetails;
    data['languageID'] = this.languageID;
    data['LanguageCategory'] = this.languageCategory;
    data['publishStatus'] = this.publishStatus;
    data['totalLikes'] = this.totalLikes;
    return data;
  }
}