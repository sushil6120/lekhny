class MostReadPostsModelClass {
  int? status;
  List<MostReadPostsData>? data;

  MostReadPostsModelClass({this.status, this.data});

  MostReadPostsModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MostReadPostsData>[];
      json['data'].forEach((v) {
        data!.add(new MostReadPostsData.fromJson(v));
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

class MostReadPostsData {
  int? id;
  int? totalviewes;
  String? bookCover;
  String? title;
  String? author;
  int? totalPart;

  MostReadPostsData(
      {this.id,
        this.totalviewes,
        this.bookCover,
        this.title,
        this.author,
        this.totalPart});

  MostReadPostsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalviewes = json['totalviewes'];
    bookCover = json['bookCover'];
    title = json['title'];
    author = json['author'];
    totalPart = json['totalPart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalviewes'] = this.totalviewes;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['author'] = this.author;
    data['totalPart'] = this.totalPart;
    return data;
  }
}