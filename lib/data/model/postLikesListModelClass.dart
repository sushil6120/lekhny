class PostLikesListModelClass {
  int? status;
  Data? data;

  PostLikesListModelClass({this.status, this.data});

  PostLikesListModelClass.fromJson(Map<String, dynamic> json) {
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
  List<LikeBy>? likeBy;
  int? totalLike;
  int? isAuthLike;

  Data({this.likeBy, this.totalLike, this.isAuthLike});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['likeBy'] != null) {
      likeBy = <LikeBy>[];
      json['likeBy'].forEach((v) {
        likeBy!.add(new LikeBy.fromJson(v));
      });
    }
    totalLike = json['totalLike'];
    isAuthLike = json['isAuthLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.likeBy != null) {
      data['likeBy'] = this.likeBy!.map((v) => v.toJson()).toList();
    }
    data['totalLike'] = this.totalLike;
    data['isAuthLike'] = this.isAuthLike;
    return data;
  }
}

class LikeBy {
  int? userID;
  String? userName;
  String? userProfile;
  String? isVerify;
  int? isAuthFollowing;

  LikeBy(
      {this.userID,
        this.userName,
        this.userProfile,
        this.isVerify,
        this.isAuthFollowing});

  LikeBy.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    userProfile = json['userProfile'];
    isVerify = json['isVerify'];
    isAuthFollowing = json['isAuthFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['userProfile'] = this.userProfile;
    data['isVerify'] = this.isVerify;
    data['isAuthFollowing'] = this.isAuthFollowing;
    return data;
  }
}