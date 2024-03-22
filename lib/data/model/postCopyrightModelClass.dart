class PostCopyrightModelClass {
  int? status;
  List<Data>? data;

  PostCopyrightModelClass({this.status, this.data});

  PostCopyrightModelClass.fromJson(Map<String, dynamic> json) {
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
  int? copyrightID;
  String? copyWritetitle;

  Data({this.copyrightID, this.copyWritetitle});

  Data.fromJson(Map<String, dynamic> json) {
    copyrightID = json['copyrightID'];
    copyWritetitle = json['copyWritetitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['copyrightID'] = this.copyrightID;
    data['copyWritetitle'] = this.copyWritetitle;
    return data;
  }
}