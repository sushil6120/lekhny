class WriterStatsModelClass {
  int? status;
  List<Data>? data;

  WriterStatsModelClass({this.status, this.data});

  WriterStatsModelClass.fromJson(Map<String, dynamic> json) {
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
  int? lekhnyCoins;
  int? lekhnyRank;
  int? totalPost;
  int? totalFollowers;
  int? totalFollowing;
  int? totalTrophy;

  Data(
      {this.lekhnyCoins,
        this.lekhnyRank,
        this.totalPost,
        this.totalFollowers,
        this.totalFollowing,
        this.totalTrophy});

  Data.fromJson(Map<String, dynamic> json) {
    lekhnyCoins = json['lekhnyCoins'];
    lekhnyRank = json['lekhnyRank'];
    totalPost = json['TotalPost'];
    totalFollowers = json['TotalFollowers'];
    totalFollowing = json['TotalFollowing'];
    totalTrophy = json['totalTrophy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lekhnyCoins'] = this.lekhnyCoins;
    data['lekhnyRank'] = this.lekhnyRank;
    data['TotalPost'] = this.totalPost;
    data['TotalFollowers'] = this.totalFollowers;
    data['TotalFollowing'] = this.totalFollowing;
    data['totalTrophy'] = this.totalTrophy;
    return data;
  }
}