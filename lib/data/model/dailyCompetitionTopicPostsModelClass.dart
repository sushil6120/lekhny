class DailyCompetitionTopicPostsModelClass {
  int? status;
  Data? data;

  DailyCompetitionTopicPostsModelClass({this.status, this.data});

  DailyCompetitionTopicPostsModelClass.fromJson(Map<String, dynamic> json) {
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
  int? totalPost;
  int? perPagePost;
  List<CompetitionPost>? competitionPost;

  Data({this.totalPost, this.perPagePost, this.competitionPost});

  Data.fromJson(Map<String, dynamic> json) {
    totalPost = json['totalPost'];
    perPagePost = json['perPagePost'];
    if (json['competitionPost'] != null) {
      competitionPost = <CompetitionPost>[];
      json['competitionPost'].forEach((v) {
        competitionPost!.add(new CompetitionPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPost'] = this.totalPost;
    data['perPagePost'] = this.perPagePost;
    if (this.competitionPost != null) {
      data['competitionPost'] =
          this.competitionPost!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompetitionPost {
  int? postID;
  int? views;
  String? bookCover;
  String? title;
  String? author;
  int? authorId;
  String? iSwriterVerified;

  CompetitionPost(
      {this.postID,
        this.views,
        this.bookCover,
        this.title,
        this.author,
        this.authorId,
        this.iSwriterVerified});

  CompetitionPost.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    views = json['views'];
    bookCover = json['bookCover'];
    title = json['title'];
    author = json['author'];
    authorId = json['authorId'];
    iSwriterVerified = json['ISwriterVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['views'] = this.views;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['author'] = this.author;
    data['authorId'] = this.authorId;
    data['ISwriterVerified'] = this.iSwriterVerified;
    return data;
  }
}