class TopWritersModelClass {
  int? status;
  List<TopWritersData>? data;

  TopWritersModelClass({this.status, this.data});

  TopWritersModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TopWritersData>[];
      json['data'].forEach((v) {
        data!.add(new TopWritersData.fromJson(v));
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

class TopWritersData {
  String? name;
  int? id;
  String? userProfile;
  String? verifiedUser;
  int? lekhnyrank;

  TopWritersData(
      {this.name,
        this.id,
        this.userProfile,
        this.verifiedUser,
        this.lekhnyrank});

  TopWritersData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    userProfile = json['userProfile'];
    verifiedUser = json['verifiedUser'];
    lekhnyrank = json['lekhnyrank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['userProfile'] = this.userProfile;
    data['verifiedUser'] = this.verifiedUser;
    data['lekhnyrank'] = this.lekhnyrank;
    return data;
  }
}