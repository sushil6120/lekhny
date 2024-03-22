class ForgetPasswordSendOtpModelClass {
  int? status;
  String? data;
  String? email;

  ForgetPasswordSendOtpModelClass({this.status, this.data, this.email});

  ForgetPasswordSendOtpModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['email'] = this.email;
    return data;
  }
}