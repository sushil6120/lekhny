class PostsByCategoryModelClass {
  int? status;
  List<CategoryBookData>? data;

  PostsByCategoryModelClass({this.status, this.data});

  PostsByCategoryModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoryBookData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryBookData.fromJson(v));
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

class CategoryBookData {
  int? postID;
  String? postSubCategory;
  int? views;
  String? bookCover;
  String? title;
  int? totalPart;
  int? alliViewser;
  String? author;
  int? authorId;
  String? iSwriterVerified;

  CategoryBookData(
      {this.postID,
        this.postSubCategory,
        this.views,
        this.bookCover,
        this.title,
        this.totalPart,
        this.alliViewser,
        this.author,
        this.authorId,
        this.iSwriterVerified});

  CategoryBookData.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postSubCategory = json['postSubCategory'];
    views = json['views'];
    bookCover = json['bookCover'];
    title = json['title'];
    totalPart = json['totalPart'];
    alliViewser = json['alliViewser'];
    author = json['author'];
    authorId = json['authorId'];
    iSwriterVerified = json['ISwriterVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postSubCategory'] = this.postSubCategory;
    data['views'] = this.views;
    data['bookCover'] = this.bookCover;
    data['title'] = this.title;
    data['totalPart'] = this.totalPart;
    data['alliViewser'] = this.alliViewser;
    data['author'] = this.author;
    data['authorId'] = this.authorId;
    data['ISwriterVerified'] = this.iSwriterVerified;
    return data;
  }
}