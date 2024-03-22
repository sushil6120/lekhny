class RedeemedPointsModelClass {
  int? status;
  List<RedeemedPointsData>? data;

  RedeemedPointsModelClass({this.status, this.data});

  RedeemedPointsModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <RedeemedPointsData>[];
      json['data'].forEach((v) {
        data!.add(new RedeemedPointsData.fromJson(v));
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

class RedeemedPointsData {
  String? redeemrequestID;
  String? redeemRequestPoints;
  String? bankData;
  String? qRCode;
  String? uPIID;

  RedeemedPointsData(
      {this.redeemrequestID,
        this.redeemRequestPoints,
        this.bankData,
        this.qRCode,
        this.uPIID});

  RedeemedPointsData.fromJson(Map<String, dynamic> json) {
    redeemrequestID = json['redeemrequestID'];
    redeemRequestPoints = json['redeemRequestPoints'];
    bankData = json['bankData'];
    qRCode = json['QR Code'];
    uPIID = json['UPIID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redeemrequestID'] = this.redeemrequestID;
    data['redeemRequestPoints'] = this.redeemRequestPoints;
    data['bankData'] = this.bankData;
    data['QR Code'] = this.qRCode;
    data['UPIID'] = this.uPIID;
    return data;
  }
}