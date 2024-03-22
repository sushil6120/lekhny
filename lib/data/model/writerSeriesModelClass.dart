class WriterSeriesModelClass {
  int? status;
  List<WriterSeriesData>? data;

  WriterSeriesModelClass({this.status, this.data});

  WriterSeriesModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WriterSeriesData>[];
      json['data'].forEach((v) {
        data!.add(new WriterSeriesData.fromJson(v));
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

class WriterSeriesData {
  int? id;
  int? totalViwers;
  String? bookCoverImage;
  String? bookTitle;
  String? name;
  int? totalPart;
  int? totalviewes;

  WriterSeriesData(
      {this.id,
        this.totalViwers,
        this.bookCoverImage,
        this.bookTitle,
        this.name,
        this.totalPart,
        this.totalviewes});

  WriterSeriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalViwers = json['totalViwers'];
    bookCoverImage = json['bookCoverImage'];
    bookTitle = json['BookTitle'];
    name = json['name'];
    totalPart = json['totalPart'];
    totalviewes = json['totalviewes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalViwers'] = this.totalViwers;
    data['bookCoverImage'] = this.bookCoverImage;
    data['BookTitle'] = this.bookTitle;
    data['name'] = this.name;
    data['totalPart'] = this.totalPart;
    data['totalviewes'] = this.totalviewes;
    return data;
  }
}