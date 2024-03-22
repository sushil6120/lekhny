class TrendingSearchModelClass {
  int? status;
  List<Data>? data;

  TrendingSearchModelClass({this.status, this.data});

  TrendingSearchModelClass.fromJson(Map<String, dynamic> json) {
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
  String? trandigPost;
  int? postID;

  Data({this.trandigPost, this.postID});

  Data.fromJson(Map<String, dynamic> json) {
    trandigPost = json['trandigPost'];
    postID = json['postID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trandigPost'] = this.trandigPost;
    data['postID'] = this.postID;
    return data;
  }
}