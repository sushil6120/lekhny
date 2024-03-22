class TopPostsModelClass {
  int? status;
  Data? data;

  TopPostsModelClass({this.status, this.data});

  TopPostsModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<TopPostsData>? topStory;

  Data({this.topStory});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['topStory'] != null) {
      topStory = <TopPostsData>[];
      json['topStory'].forEach((v) {
        topStory!.add(new TopPostsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topStory != null) {
      data['topStory'] = this.topStory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopPostsData {
  int? postID;
  int? views;
  String? bookCover;
  String? title;
  String? author;
  int? totalPart;
  int? alliViewser;

  TopPostsData(
      {this.postID,
        this.views,
        this.bookCover,
        this.title,
        this.author,
        this.totalPart,
        this.alliViewser});

  TopPostsData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    views = json['views'];
    bookCover = json['bookCover'];
    title = json['title'];
    author = json['author'];
    totalPart = json['totalPart'];
    alliViewser = json['alliViewser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['views'] = this.views;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['author'] = this.author;
    data['totalPart'] = this.totalPart;
    data['alliViewser'] = this.alliViewser;
    return data;
  }
}