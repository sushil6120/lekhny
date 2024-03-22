class VerifyEmailOtpModelClass {
  int? status;
  String? data;

  VerifyEmailOtpModelClass({this.status, this.data});

  VerifyEmailOtpModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}