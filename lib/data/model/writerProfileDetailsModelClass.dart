class WriterProfileDetailsModelClass {
  int? status;
  Data? data;

  WriterProfileDetailsModelClass({this.status, this.data});

  WriterProfileDetailsModelClass.fromJson(Map<String, dynamic> json) {
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
  List<WritterProfile>? writterProfile;
  int? totalFollowers;
  int? totlaFollowing;
  int? userIsFollowing;

  Data(
      {this.writterProfile,
        this.totalFollowers,
        this.totlaFollowing,
        this.userIsFollowing});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['writterProfile'] != null) {
      writterProfile = <WritterProfile>[];
      json['writterProfile'].forEach((v) {
        writterProfile!.add(new WritterProfile.fromJson(v));
      });
    }
    totalFollowers = json['totalFollowers'];
    totlaFollowing = json['totlaFollowing'];
    userIsFollowing = json['userIsFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.writterProfile != null) {
      data['writterProfile'] =
          this.writterProfile!.map((v) => v.toJson()).toList();
    }
    data['totalFollowers'] = this.totalFollowers;
    data['totlaFollowing'] = this.totlaFollowing;
    data['userIsFollowing'] = this.userIsFollowing;
    return data;
  }
}

class WritterProfile {
  String? profileImage;
  String? backGroundImage;
  String? fbLink;
  int? totalProfileView;
  int? lekhnyrankTrophy;
  String? name;
  String? veryfyAt;
  String? lekhnyVerify;
  int? userStatus;
  String? writerType;
  String? referralCode;
  String? writterDOB;
  String? gender;

  WritterProfile(
      {this.profileImage,
        this.backGroundImage,
        this.fbLink,
        this.totalProfileView,
        this.lekhnyrankTrophy,
        this.name,
        this.veryfyAt,
        this.lekhnyVerify,
        this.userStatus,
        this.writerType,
        this.referralCode,
        this.writterDOB,
        this.gender});

  WritterProfile.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    backGroundImage = json['backGroundImage'];
    fbLink = json['fb_link'];
    totalProfileView = json['totalProfileView'];
    lekhnyrankTrophy = json['lekhnyrankTrophy'];
    name = json['name'];
    veryfyAt = json['veryfyAt'];
    lekhnyVerify = json['lekhnyVerify'];
    userStatus = json['userStatus'];
    writerType = json['writerType'];
    referralCode = json['referralCode'];
    writterDOB = json['writterDOB'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['backGroundImage'] = this.backGroundImage;
    data['fb_link'] = this.fbLink;
    data['totalProfileView'] = this.totalProfileView;
    data['lekhnyrankTrophy'] = this.lekhnyrankTrophy;
    data['name'] = this.name;
    data['veryfyAt'] = this.veryfyAt;
    data['lekhnyVerify'] = this.lekhnyVerify;
    data['userStatus'] = this.userStatus;
    data['writerType'] = this.writerType;
    data['referralCode'] = this.referralCode;
    data['writterDOB'] = this.writterDOB;
    data['gender'] = this.gender;
    return data;
  }
}