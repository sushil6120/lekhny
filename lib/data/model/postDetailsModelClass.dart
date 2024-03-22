class PostDetailsModelClass {
  int? status;
  Data? data;

  PostDetailsModelClass({this.status, this.data});

  PostDetailsModelClass.fromJson(Map<String, dynamic> json) {
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
  int? postID;
  String? postTitle;
  String? postLanguage;
  String? languageCategory;
  String? copyrightStatus;
  String? postCoverImage;
  int? isPostPublish;
  String? postSortDetails;
  String? postCreateDate;
  String? postSubCategory;

  Data(
      {this.postID,
        this.postTitle,
        this.postLanguage,
        this.languageCategory,
        this.copyrightStatus,
        this.postCoverImage,
        this.isPostPublish,
        this.postSortDetails,
        this.postCreateDate,
        this.postSubCategory});

  Data.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postTitle = json['postTitle'];
    postLanguage = json['postLanguage'];
    languageCategory = json['languageCategory'];
    copyrightStatus = json['copyrightStatus'];
    postCoverImage = json['postCoverImage'];
    isPostPublish = json['isPostPublish'];
    postSortDetails = json['postSortDetails'];
    postCreateDate = json['postCreateDate'];
    postSubCategory = json['postSubCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postTitle'] = this.postTitle;
    data['postLanguage'] = this.postLanguage;
    data['languageCategory'] = this.languageCategory;
    data['copyrightStatus'] = this.copyrightStatus;
    data['postCoverImage'] = this.postCoverImage;
    data['isPostPublish'] = this.isPostPublish;
    data['postSortDetails'] = this.postSortDetails;
    data['postCreateDate'] = this.postCreateDate;
    data['postSubCategory'] = this.postSubCategory;
    return data;
  }
}