class DailyCompetitionTopicModelClass {
  int? status;
  List<Data>? data;

  DailyCompetitionTopicModelClass({this.status, this.data});

  DailyCompetitionTopicModelClass.fromJson(Map<String, dynamic> json) {
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
  int? competitionID;
  String? competitionTitle;
  String? competitionCover;
  String? competitionType;
  String? competitionDate;

  Data(
      {this.competitionID,
        this.competitionTitle,
        this.competitionCover,
        this.competitionType,
        this.competitionDate});

  Data.fromJson(Map<String, dynamic> json) {
    competitionID = json['CompetitionID'];
    competitionTitle = json['CompetitionTitle'];
    competitionCover = json['CompetitionCover'];
    competitionType = json['CompetitionType'];
    competitionDate = json['CompetitionDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompetitionID'] = this.competitionID;
    data['CompetitionTitle'] = this.competitionTitle;
    data['CompetitionCover'] = this.competitionCover;
    data['CompetitionType'] = this.competitionType;
    data['CompetitionDate'] = this.competitionDate;
    return data;
  }
}