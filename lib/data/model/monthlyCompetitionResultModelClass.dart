class MonthlyCompetitionResultModelClass {
  int? status;
  List<Data>? data;

  MonthlyCompetitionResultModelClass({this.status, this.data});

  MonthlyCompetitionResultModelClass.fromJson(Map<String, dynamic> json) {
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
  int? compID;
  String? compTitle;
  String? animationImage;
  String? comLayoutBackgroundColor;
  String? compSortDesc;
  String? comLayoutTopImage;
  String? comLayoutBtmImage;
  List<CompWinnerPostAsRank>? compWinnerPostAsRank;

  Data(
      {this.compID,
        this.compTitle,
        this.animationImage,
        this.comLayoutBackgroundColor,
        this.compSortDesc,
        this.comLayoutTopImage,
        this.comLayoutBtmImage,
        this.compWinnerPostAsRank});

  Data.fromJson(Map<String, dynamic> json) {
    compID = json['compID'];
    compTitle = json['compTitle'];
    animationImage = json['animationImage'];
    comLayoutBackgroundColor = json['ComLayoutBackgroundColor'];
    compSortDesc = json['compSortDesc'];
    comLayoutTopImage = json['ComLayoutTopImage'];
    comLayoutBtmImage = json['ComLayoutBtmImage'];
    if (json['compWinnerPostAsRank'] != null) {
      compWinnerPostAsRank = <CompWinnerPostAsRank>[];
      json['compWinnerPostAsRank'].forEach((v) {
        compWinnerPostAsRank!.add(new CompWinnerPostAsRank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compID'] = this.compID;
    data['compTitle'] = this.compTitle;
    data['animationImage'] = this.animationImage;
    data['ComLayoutBackgroundColor'] = this.comLayoutBackgroundColor;
    data['compSortDesc'] = this.compSortDesc;
    data['ComLayoutTopImage'] = this.comLayoutTopImage;
    data['ComLayoutBtmImage'] = this.comLayoutBtmImage;
    if (this.compWinnerPostAsRank != null) {
      data['compWinnerPostAsRank'] =
          this.compWinnerPostAsRank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompWinnerPostAsRank {
  int? postId;
  int? autherId;
  String? postTitle;
  String? postCoverImage;
  String? authorName;

  CompWinnerPostAsRank(
      {this.postId,
        this.autherId,
        this.postTitle,
        this.postCoverImage,
        this.authorName});

  CompWinnerPostAsRank.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    autherId = json['autherId'];
    postTitle = json['postTitle'];
    postCoverImage = json['postCoverImage'];
    authorName = json['authorName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postId'] = this.postId;
    data['autherId'] = this.autherId;
    data['postTitle'] = this.postTitle;
    data['postCoverImage'] = this.postCoverImage;
    data['authorName'] = this.authorName;
    return data;
  }
}