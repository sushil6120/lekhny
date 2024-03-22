class DailyCompetitionRulesModelClass {
  int? status;
  List<Data>? data;

  DailyCompetitionRulesModelClass({this.status, this.data});

  DailyCompetitionRulesModelClass.fromJson(Map<String, dynamic> json) {
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
  String? rule;

  Data({this.rule});

  Data.fromJson(Map<String, dynamic> json) {
    rule = json['Rule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Rule'] = this.rule;
    return data;
  }
}