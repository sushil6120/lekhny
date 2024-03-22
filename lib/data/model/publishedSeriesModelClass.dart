// class PublishedSeriesModelClass {
//   int? status;
//   List<PublishedSeriesData>? data;
//
//   PublishedSeriesModelClass({this.status, this.data});
//
//   PublishedSeriesModelClass.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <PublishedSeriesData>[];
//       json['data'].forEach((v) {
//         data!.add(new PublishedSeriesData.fromJson(v));
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
// class PublishedSeriesData {
//   int? postID;
//   String? bookCover;
//   String? title;
//   int? ttoalPart;
//   int? totalViwers;
//   int? totallikes;
//   int? mainpostid;
//
//   PublishedSeriesData(
//       {this.postID,
//         this.bookCover,
//         this.title,
//         this.ttoalPart,
//         this.totalViwers,
//         this.totallikes,
//         this.mainpostid});
//
//   PublishedSeriesData.fromJson(Map<String, dynamic> json) {
//     postID = json['postID'];
//     bookCover = json['bookCover'];
//     title = json['title'];
//     ttoalPart = json['ttoalPart'];
//     totalViwers = json['totalViwers'];
//     totallikes = json['totallikes'];
//     mainpostid = json['mainpostid'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['postID'] = this.postID;
//     data['bookCover'] = this.bookCover;
//     data['title'] = this.title;
//     data['ttoalPart'] = this.ttoalPart;
//     data['totalViwers'] = this.totalViwers;
//     data['totallikes'] = this.totallikes;
//     data['mainpostid'] = this.mainpostid;
//     return data;
//   }
// }

class PublishedSeriesModelClass {
  int? status;
  List<PublishedSeriesData>? data;

  PublishedSeriesModelClass({this.status, this.data});

  PublishedSeriesModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PublishedSeriesData>[];
      json['data'].forEach((v) {
        data!.add(new PublishedSeriesData.fromJson(v));
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

class PublishedSeriesData {
  int? postID;
  String? bookCover;
  String? title;
  int? ttoalPart;
  int? totalViwers;
  int? totallikes;
  int? mainpostid;
  String? bookLanguage;

  PublishedSeriesData(
      {this.postID,
        this.bookCover,
        this.title,
        this.ttoalPart,
        this.totalViwers,
        this.totallikes,
        this.mainpostid,
        this.bookLanguage});

  PublishedSeriesData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    bookCover = json['bookCover'];
    title = json['title'];
    ttoalPart = json['ttoalPart'];
    totalViwers = json['totalViwers'];
    totallikes = json['totallikes'];
    mainpostid = json['mainpostid'];
    bookLanguage = json['bookLanguage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['ttoalPart'] = this.ttoalPart;
    data['totalViwers'] = this.totalViwers;
    data['totallikes'] = this.totallikes;
    data['mainpostid'] = this.mainpostid;
    data['bookLanguage'] = this.bookLanguage;
    return data;
  }
}