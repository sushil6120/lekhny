class AddNextPartModelClass {
  int? status;
  String? data;
  int? postID;

  AddNextPartModelClass({this.status, this.data, this.postID});

  AddNextPartModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    postID = json['postID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['postID'] = this.postID;
    return data;
  }
}