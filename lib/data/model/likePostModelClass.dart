class LikePostModelClass {
  int? status;
  String? data;
  int? totalLike;

  LikePostModelClass({this.status, this.data, this.totalLike});

  LikePostModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    totalLike = json['totalLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    data['totalLike'] = this.totalLike;
    return data;
  }
}