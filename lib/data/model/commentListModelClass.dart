class CommentsListModelClass {
  int? status;
  List<Data>? data;

  CommentsListModelClass({this.status, this.data});

  CommentsListModelClass.fromJson(Map<String, dynamic> json) {
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
  int? commentID;
  int? commentBy;
  String? userName;
  String? comments;
  String? profile;
  String? commentOn;
  String? isVerify;
  List<CommentReply>? commentReply;

  Data(
      {this.commentID,
        this.commentBy,
        this.userName,
        this.comments,
        this.profile,
        this.commentOn,
        this.isVerify,
        this.commentReply});

  Data.fromJson(Map<String, dynamic> json) {
    commentID = json['commentID'];
    commentBy = json['commentBy'];
    userName = json['userName'];
    comments = json['comments'];
    profile = json['profile'];
    commentOn = json['commentOn'];
    isVerify = json['isVerify'];
    if (json['commentReply'] != null) {
      commentReply = <CommentReply>[];
      json['commentReply'].forEach((v) {
        commentReply!.add(new CommentReply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentID'] = this.commentID;
    data['commentBy'] = this.commentBy;
    data['userName'] = this.userName;
    data['comments'] = this.comments;
    data['profile'] = this.profile;
    data['commentOn'] = this.commentOn;
    data['isVerify'] = this.isVerify;
    if (this.commentReply != null) {
      data['commentReply'] = this.commentReply!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommentReply {
  int? replyID;
  int? replyBy;
  String? reply;
  String? name;
  String? userProfile;
  String? createdAt;
  String? isVerify;

  CommentReply(
      {this.replyID,
        this.replyBy,
        this.reply,
        this.name,
        this.userProfile,
        this.createdAt,
        this.isVerify});

  CommentReply.fromJson(Map<String, dynamic> json) {
    replyID = json['replyID'];
    replyBy = json['replyBy'];
    reply = json['reply'];
    name = json['name'];
    userProfile = json['userProfile'];
    createdAt = json['created_at'];
    isVerify = json['isVerify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['replyID'] = this.replyID;
    data['replyBy'] = this.replyBy;
    data['reply'] = this.reply;
    data['name'] = this.name;
    data['userProfile'] = this.userProfile;
    data['created_at'] = this.createdAt;
    data['isVerify'] = this.isVerify;
    return data;
  }
}