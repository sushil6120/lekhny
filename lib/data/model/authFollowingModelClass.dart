class AuthFollowingModelClass {
  int? status;
  List<FollowingsData>? data;

  AuthFollowingModelClass({this.status, this.data});

  AuthFollowingModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <FollowingsData>[];
      json['data'].forEach((v) {
        data!.add(new FollowingsData.fromJson(v));
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

class FollowingsData {
  String? name;
  int? id;
  String? verifiedUser;
  String? userBackGround;
  String? userProfile;

  FollowingsData(
      {this.name,
        this.id,
        this.verifiedUser,
        this.userBackGround,
        this.userProfile});

  FollowingsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    verifiedUser = json['verifiedUser'];
    userBackGround = json['userBackGround'];
    userProfile = json['userProfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['verifiedUser'] = this.verifiedUser;
    data['userBackGround'] = this.userBackGround;
    data['userProfile'] = this.userProfile;
    return data;
  }
}