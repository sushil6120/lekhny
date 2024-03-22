class PostsBySubCategoryModelClass {
  int? status;
  List<SubCategoryBookData>? data;

  PostsBySubCategoryModelClass({this.status, this.data});

  PostsBySubCategoryModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SubCategoryBookData>[];
      json['data'].forEach((v) {
        data!.add(new SubCategoryBookData.fromJson(v));
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

class SubCategoryBookData {
  int? postID;
  String? postTitle;
  String? postCoverImage;
  int? totalPart;
  int? totalViews;
  int? views;
  int? totalLikes;
  int? likes;
  String? autherName;
  int? authId;
  String? isVerifyAuther;

  SubCategoryBookData(
      {this.postID,
        this.postTitle,
        this.postCoverImage,
        this.totalPart,
        this.totalViews,
        this.views,
        this.totalLikes,
        this.likes,
        this.autherName,
        this.authId,
        this.isVerifyAuther});

  SubCategoryBookData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postTitle = json['postTitle'];
    postCoverImage = json['postCoverImage'];
    totalPart = json['totalPart'];
    totalViews = json['totalViews'];
    views = json['views'];
    totalLikes = json['totalLikes'];
    likes = json['likes'];
    autherName = json['autherName'];
    authId = json['authId'];
    isVerifyAuther = json['isVerifyAuther'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postTitle'] = this.postTitle;
    data['postCoverImage'] = this.postCoverImage;
    data['totalPart'] = this.totalPart;
    data['totalViews'] = this.totalViews;
    data['views'] = this.views;
    data['totalLikes'] = this.totalLikes;
    data['likes'] = this.likes;
    data['autherName'] = this.autherName;
    data['authId'] = this.authId;
    data['isVerifyAuther'] = this.isVerifyAuther;
    return data;
  }
}