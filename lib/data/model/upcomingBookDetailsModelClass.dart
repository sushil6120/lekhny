class UpcomingBookDetailsModelClass {
  int? status;
  Data? data;

  UpcomingBookDetailsModelClass({this.status, this.data});

  UpcomingBookDetailsModelClass.fromJson(Map<String, dynamic> json) {
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
  BookDetails? bookDetails;
  List<AnotherBooks>? anotherBooks;

  Data({this.bookDetails, this.anotherBooks});

  Data.fromJson(Map<String, dynamic> json) {
    bookDetails = json['bookDetails'] != null
        ? new BookDetails.fromJson(json['bookDetails'])
        : null;
    if (json['anotherBooks'] != null) {
      anotherBooks = <AnotherBooks>[];
      json['anotherBooks'].forEach((v) {
        anotherBooks!.add(new AnotherBooks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookDetails != null) {
      data['bookDetails'] = this.bookDetails!.toJson();
    }
    if (this.anotherBooks != null) {
      data['anotherBooks'] = this.anotherBooks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookDetails {
  int? bookID;
  String? bookDetails;
  String? booktitle;
  String? writerDetails;
  String? writerName;
  String? bookImage;
  String? bookSliderImageA;
  String? bookSliderImageB;
  String? bookSliderImageC;
  String? bookSliderImageD;
  String? buyLink;

  BookDetails(
      {this.bookID,
        this.bookDetails,
        this.booktitle,
        this.writerDetails,
        this.writerName,
        this.bookImage,
        this.bookSliderImageA,
        this.bookSliderImageB,
        this.bookSliderImageC,
        this.bookSliderImageD,
        this.buyLink});

  BookDetails.fromJson(Map<String, dynamic> json) {
    bookID = json['bookID'];
    bookDetails = json['bookDetails'];
    booktitle = json['booktitle'];
    writerDetails = json['writerDetails'];
    writerName = json['writerName'];
    bookImage = json['BookImage'];
    bookSliderImageA = json['bookSliderImageA'];
    bookSliderImageB = json['bookSliderImageB'];
    bookSliderImageC = json['bookSliderImageC'];
    bookSliderImageD = json['bookSliderImageD'];
    buyLink = json['buyLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookID'] = this.bookID;
    data['bookDetails'] = this.bookDetails;
    data['booktitle'] = this.booktitle;
    data['writerDetails'] = this.writerDetails;
    data['writerName'] = this.writerName;
    data['BookImage'] = this.bookImage;
    data['bookSliderImageA'] = this.bookSliderImageA;
    data['bookSliderImageB'] = this.bookSliderImageB;
    data['bookSliderImageC'] = this.bookSliderImageC;
    data['bookSliderImageD'] = this.bookSliderImageD;
    data['buyLink'] = this.buyLink;
    return data;
  }
}

class AnotherBooks {
  int? bookID;
  String? booktitle;
  String? writerName;
  String? bookImage;

  AnotherBooks({this.bookID, this.booktitle, this.writerName, this.bookImage});

  AnotherBooks.fromJson(Map<String, dynamic> json) {
    bookID = json['bookID'];
    booktitle = json['booktitle'];
    writerName = json['writerName'];
    bookImage = json['BookImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bookID'] = this.bookID;
    data['booktitle'] = this.booktitle;
    data['writerName'] = this.writerName;
    data['BookImage'] = this.bookImage;
    return data;
  }
}