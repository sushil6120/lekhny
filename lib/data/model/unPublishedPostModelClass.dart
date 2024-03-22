// class UnPublishedPostModelClass {
//   int? status;
//   List<UnPublishedPostData>? data;
//
//   UnPublishedPostModelClass({this.status, this.data});
//
//   UnPublishedPostModelClass.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <UnPublishedPostData>[];
//       json['data'].forEach((v) {
//         data!.add(new UnPublishedPostData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UnPublishedPostData {
//   String? title;
//   String? bookCover;
//   int? postID;
//
//   UnPublishedPostData({this.title, this.bookCover, this.postID});
//
//   UnPublishedPostData.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     bookCover = json['bookCover'];
//     postID = json['postID'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['bookCover'] = this.bookCover;
//     data['postID'] = this.postID;
//     return data;
//   }
// }

class UnPublishedPostModelClass {
  int? status;
  List<UnPublishedPostData>? data;

  UnPublishedPostModelClass({this.status, this.data});

  UnPublishedPostModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UnPublishedPostData>[];
      json['data'].forEach((v) {
        data!.add(new UnPublishedPostData.fromJson(v));
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

class UnPublishedPostData {
  String? title;
  String? bookCover;
  int? postID;
  String? bookLanguage;

  UnPublishedPostData({this.title, this.bookCover, this.postID, this.bookLanguage});

  UnPublishedPostData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    bookCover = json['bookCover'];
    postID = json['postID'];
    bookLanguage = json['bookLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['bookCover'] = this.bookCover;
    data['postID'] = this.postID;
    data['bookLanguage'] = this.bookLanguage;
    return data;
  }
}