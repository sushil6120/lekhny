class UpcomingBookModelClass {
  int? status;
  List<UpcomingBookData>? data;

  UpcomingBookModelClass({this.status, this.data});

  UpcomingBookModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <UpcomingBookData>[];
      json['data'].forEach((v) {
        data!.add(new UpcomingBookData.fromJson(v));
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

class UpcomingBookData {
  int? bookID;
  String? bookDetails;
  String? booktitle;
  String? writerDetails;
  String? writerName;
  String? bookImage;

  UpcomingBookData(
      {this.bookID,
        this.bookDetails,
        this.booktitle,
        this.writerDetails,
        this.writerName,
        this.bookImage});

  UpcomingBookData.fromJson(Map<String, dynamic> json) {
    bookID = json['bookID'];
    bookDetails = json['bookDetails'];
    booktitle = json['booktitle'];
    writerDetails = json['writerDetails'];
    writerName = json['writerName'];
    bookImage = json['BookImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookID'] = this.bookID;
    data['bookDetails'] = this.bookDetails;
    data['booktitle'] = this.booktitle;
    data['writerDetails'] = this.writerDetails;
    data['writerName'] = this.writerName;
    data['BookImage'] = this.bookImage;
    return data;
  }
}