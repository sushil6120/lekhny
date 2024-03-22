class WritePostModelClass {
  int? status;
  Data? data;

  WritePostModelClass({this.status, this.data});

  WritePostModelClass.fromJson(Map<String, dynamic> json) {
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
  String? postID;
  String? preWrite;

  Data({this.postID, this.preWrite});

  Data.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    preWrite = json['preWrite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['preWrite'] = this.preWrite;
    return data;
  }
}