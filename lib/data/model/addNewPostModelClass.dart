class AddNewPostModelClass {
  int? status;
  Data? data;

  AddNewPostModelClass({this.status, this.data});

  AddNewPostModelClass.fromJson(Map<String, dynamic> json) {
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
  int? postID;

  Data({this.postID});

  Data.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    return data;
  }
}