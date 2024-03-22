class UserProfileModelClass {
  int? status;
  List<Data>? data;

  UserProfileModelClass({this.status, this.data});

  UserProfileModelClass.fromJson(Map<String, dynamic> json) {
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
  int? userID;
  String? name;
  String? phoneNumber;
  String? userDOB;
  String? gender;
  String? facebookLink;
  String? address;
  String? profile;
  String? backGroundImage;
  int? lekhnyCoins;
  int? lekhnyRank;
  String? lekhnyExclusie;
  String? verifyDate;
  int? userType;
  int? totalPost;
  int? totalFollowers;
  int? totalFollowing;
  int? totalTrophy;

  Data(
      {this.userID,
        this.name,
        this.phoneNumber,
        this.userDOB,
        this.gender,
        this.facebookLink,
        this.address,
        this.profile,
        this.backGroundImage,
        this.lekhnyCoins,
        this.lekhnyRank,
        this.lekhnyExclusie,
        this.verifyDate,
        this.userType,
        this.totalPost,
        this.totalFollowers,
        this.totalFollowing,
        this.totalTrophy});

  Data.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    userDOB = json['UserDOB'];
    gender = json['gender'];
    facebookLink = json['FacebookLink'];
    address = json['address'];
    profile = json['profile'];
    backGroundImage = json['backGroundImage'];
    lekhnyCoins = json['lekhnyCoins'];
    lekhnyRank = json['lekhnyRank'];
    lekhnyExclusie = json['lekhnyExclusie'];
    verifyDate = json['verifyDate'];
    userType = json['userType'];
    totalPost = json['TotalPost'];
    totalFollowers = json['TotalFollowers'];
    totalFollowing = json['TotalFollowing'];
    totalTrophy = json['totalTrophy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['UserDOB'] = this.userDOB;
    data['gender'] = this.gender;
    data['FacebookLink'] = this.facebookLink;
    data['address'] = this.address;
    data['profile'] = this.profile;
    data['backGroundImage'] = this.backGroundImage;
    data['lekhnyCoins'] = this.lekhnyCoins;
    data['lekhnyRank'] = this.lekhnyRank;
    data['lekhnyExclusie'] = this.lekhnyExclusie;
    data['verifyDate'] = this.verifyDate;
    data['userType'] = this.userType;
    data['TotalPost'] = this.totalPost;
    data['TotalFollowers'] = this.totalFollowers;
    data['TotalFollowing'] = this.totalFollowing;
    data['totalTrophy'] = this.totalTrophy;
    return data;
  }
}