class SingleBookDataModelClass {
  int? status;
  List<Data>? data;

  SingleBookDataModelClass({this.status, this.data});

  SingleBookDataModelClass.fromJson(Map<String, dynamic> json) {
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
  String? postData;

  Data({this.postData});

  Data.fromJson(Map<String, dynamic> json) {
    postData = json['postData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postData'] = this.postData;
    return data;
  }
}