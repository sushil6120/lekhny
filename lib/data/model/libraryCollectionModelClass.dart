class LibraryCollectionModelClass {
  int? status;
  List<Data>? data;

  LibraryCollectionModelClass({this.status, this.data});

  LibraryCollectionModelClass.fromJson(Map<String, dynamic> json) {
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
  int? postID;
  String? postTitle;
  String? postCover;
  String? authName;
  String? iSwriterVerified;
  int? totalviewes;

  Data(
      {this.postID,
        this.postTitle,
        this.postCover,
        this.authName,
        this.iSwriterVerified,
        this.totalviewes});

  Data.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postTitle = json['postTitle'];
    postCover = json['postCover'];
    authName = json['authName'];
    iSwriterVerified = json['ISwriterVerified'];
    totalviewes = json['totalviewes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postTitle'] = this.postTitle;
    data['postCover'] = this.postCover;
    data['authName'] = this.authName;
    data['ISwriterVerified'] = this.iSwriterVerified;
    data['totalviewes'] = this.totalviewes;
    return data;
  }
}