class SignUpByEmailModelClass {
  int? status;
  String? message;
  Data? data;

  SignUpByEmailModelClass({this.status, this.message, this.data});

  SignUpByEmailModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? lekhnyToken;

  Data({this.lekhnyToken});

  Data.fromJson(Map<String, dynamic> json) {
    lekhnyToken = json['lekhnyToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lekhnyToken'] = this.lekhnyToken;
    return data;
  }
}