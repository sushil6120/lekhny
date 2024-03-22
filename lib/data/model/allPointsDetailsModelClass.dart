class AllPointsDetailsModelClass {
  int? status;
  Data? data;

  AllPointsDetailsModelClass({this.status, this.data});

  AllPointsDetailsModelClass.fromJson(Map<String, dynamic> json) {
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
  AllPointsData? allPointsData;
  List<DipositPoint>? dipositPoint;
  String? creditPointsForPostLike;
  String? minlimitOfPointredeem;
  List<PointBuyrequest>? pointBuyrequest;

  Data(
      {this.allPointsData,
        this.dipositPoint,
        this.creditPointsForPostLike,
        this.minlimitOfPointredeem,
        this.pointBuyrequest});

  Data.fromJson(Map<String, dynamic> json) {
    allPointsData = json['allPointsData'] != null
        ? new AllPointsData.fromJson(json['allPointsData'])
        : null;
    if (json['diposit_point'] != null) {
      dipositPoint = <DipositPoint>[];
      json['diposit_point'].forEach((v) {
        dipositPoint!.add(new DipositPoint.fromJson(v));
      });
    }
    creditPointsForPostLike = json['creditPointsForPostLike'];
    minlimitOfPointredeem = json['MinlimitOfPointredeem'];
    if (json['pointBuyrequest'] != null) {
      pointBuyrequest = <PointBuyrequest>[];
      json['pointBuyrequest'].forEach((v) {
        pointBuyrequest!.add(new PointBuyrequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allPointsData != null) {
      data['allPointsData'] = this.allPointsData!.toJson();
    }
    if (this.dipositPoint != null) {
      data['diposit_point'] =
          this.dipositPoint!.map((v) => v.toJson()).toList();
    }
    data['creditPointsForPostLike'] = this.creditPointsForPostLike;
    data['MinlimitOfPointredeem'] = this.minlimitOfPointredeem;
    if (this.pointBuyrequest != null) {
      data['pointBuyrequest'] =
          this.pointBuyrequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllPointsData {
  String? postLikePoints;
  int? joiningPoint;
  int? totalRedeem;
  int? debitOnPostPublish;
  int? dipositByLekhny;
  dynamic? availabelPoints;

  AllPointsData(
      {this.postLikePoints,
        this.joiningPoint,
        this.totalRedeem,
        this.debitOnPostPublish,
        this.dipositByLekhny,
        this.availabelPoints});

  AllPointsData.fromJson(Map<String, dynamic> json) {
    postLikePoints = json['postLikePoints'];
    joiningPoint = json['JoiningPoint'];
    totalRedeem = json['totalRedeem'];
    debitOnPostPublish = json['debitOnPostPublish'];
    dipositByLekhny = json['DipositByLekhny'];
    availabelPoints = json['availabelPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postLikePoints'] = this.postLikePoints;
    data['JoiningPoint'] = this.joiningPoint;
    data['totalRedeem'] = this.totalRedeem;
    data['debitOnPostPublish'] = this.debitOnPostPublish;
    data['DipositByLekhny'] = this.dipositByLekhny;
    data['availabelPoints'] = this.availabelPoints;
    return data;
  }
}

class DipositPoint {
  int? dipositPoint;
  String? dipositDate;

  DipositPoint({this.dipositPoint, this.dipositDate});

  DipositPoint.fromJson(Map<String, dynamic> json) {
    dipositPoint = json['dipositPoint'];
    dipositDate = json['dipositDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dipositPoint'] = this.dipositPoint;
    data['dipositDate'] = this.dipositDate;
    return data;
  }
}

class PointBuyrequest {
  String? requestPoints;
  String? requestTime;
  int? requestStatus;

  PointBuyrequest({this.requestPoints, this.requestTime, this.requestStatus});

  PointBuyrequest.fromJson(Map<String, dynamic> json) {
    requestPoints = json['requestPoints'];
    requestTime = json['requestTime'];
    requestStatus = json['requestStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestPoints'] = this.requestPoints;
    data['requestTime'] = this.requestTime;
    data['requestStatus'] = this.requestStatus;
    return data;
  }
}