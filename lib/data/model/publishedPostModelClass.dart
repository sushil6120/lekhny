// class PublishedPostModelClass {
//   int? status;
//   List<PublishedPostData>? data;
//
//   PublishedPostModelClass({this.status, this.data});
//
//   PublishedPostModelClass.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <PublishedPostData>[];
//       json['data'].forEach((v) {
//         data!.add(new PublishedPostData.fromJson(v));
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
// class PublishedPostData {
//   int? postID;
//   int? views;
//   String? bookCover;
//   String? title;
//
//   PublishedPostData({this.postID, this.views, this.bookCover, this.title});
//
//   PublishedPostData.fromJson(Map<String, dynamic> json) {
//     postID = json['postID'];
//     views = json['views'];
//     bookCover = json['bookCover'];
//     title = json['title'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['postID'] = this.postID;
//     data['views'] = this.views;
//     data['bookCover'] = this.bookCover;
//     data['title'] = this.title;
//     return data;
//   }
// }

class PublishedPostModelClass {
  int? status;
  List<PublishedPostData>? data;

  PublishedPostModelClass({this.status, this.data});

  PublishedPostModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PublishedPostData>[];
      json['data'].forEach((v) {
        data!.add(new PublishedPostData.fromJson(v));
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

class PublishedPostData {
  int? postID;
  int? views;
  String? bookCover;
  String? title;
  String? bookLanguage;

  PublishedPostData(
      {this.postID, this.views, this.bookCover, this.title, this.bookLanguage});

  PublishedPostData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    views = json['views'];
    bookCover = json['bookCover'];
    title = json['title'];
    bookLanguage = json['bookLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['views'] = this.views;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['bookLanguage'] = this.bookLanguage;
    return data;
  }
}