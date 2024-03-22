class PastDailyTopicsModelClass {
  int? status;
  PastDailyTopicsData? data;

  PastDailyTopicsModelClass({this.status, this.data});

  PastDailyTopicsModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new PastDailyTopicsData.fromJson(json['data']) : null;
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

class PastDailyTopicsData {
  int? totalTopic;
  int? perpageData;
  List<AllTopic>? allTopic;

  PastDailyTopicsData({this.totalTopic, this.perpageData, this.allTopic});

  PastDailyTopicsData.fromJson(Map<String, dynamic> json) {
    totalTopic = json['totalTopic'];
    perpageData = json['perpageData'];
    if (json['allTopic'] != null) {
      allTopic = <AllTopic>[];
      json['allTopic'].forEach((v) {
        allTopic!.add(new AllTopic.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalTopic'] = this.totalTopic;
    data['perpageData'] = this.perpageData;
    if (this.allTopic != null) {
      data['allTopic'] = this.allTopic!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllTopic {
  int? totalPost;
  String? topicTitle;
  String? topicCover;
  int? topicID;
  String? competitionDate;
  String? competitionType;

  AllTopic(
      {this.totalPost,
        this.topicTitle,
        this.topicCover,
        this.topicID,
        this.competitionDate,
        this.competitionType});

  AllTopic.fromJson(Map<String, dynamic> json) {
    totalPost = json['totalPost'];
    topicTitle = json['topicTitle'];
    topicCover = json['topicCover'];
    topicID = json['topicID'];
    competitionDate = json['CompetitionDate'];
    competitionType = json['CompetitionType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPost'] = this.totalPost;
    data['topicTitle'] = this.topicTitle;
    data['topicCover'] = this.topicCover;
    data['topicID'] = this.topicID;
    data['CompetitionDate'] = this.competitionDate;
    data['CompetitionType'] = this.competitionType;
    return data;
  }
}