class DailyCompetitionWinnersModelClass {
  int? status;
  Data? data;

  DailyCompetitionWinnersModelClass({this.status, this.data});

  DailyCompetitionWinnersModelClass.fromJson(Map<String, dynamic> json) {
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
  String? resultDay;
  List<Winners>? story;
  List<Winners>? poem;

  Data({this.resultDay, this.story, this.poem});

  Data.fromJson(Map<String, dynamic> json) {
    resultDay = json['resultDay'];
    if (json['story'] != null) {
      story = <Winners>[];
      json['story'].forEach((v) {
        story!.add(new Winners.fromJson(v));
      });
    }
    if (json['poem'] != null) {
      poem = <Winners>[];
      json['poem'].forEach((v) {
        poem!.add(new Winners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultDay'] = this.resultDay;
    if (this.story != null) {
      data['story'] = this.story!.map((v) => v.toJson()).toList();
    }
    if (this.poem != null) {
      data['poem'] = this.poem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Story {
  String? bookTitle;
  String? name;
  String? category;
  String? bookCoverImage;
  String? id;
  String? userid;
  String? totalViwers;

  Story(
      {this.bookTitle,
        this.name,
        this.category,
        this.bookCoverImage,
        this.id,
        this.userid,
        this.totalViwers});

  Story.fromJson(Map<String, dynamic> json) {
    bookTitle = json['BookTitle'];
    name = json['name'];
    category = json['category'];
    bookCoverImage = json['bookCoverImage'];
    id = json['id'];
    userid = json['userid'];
    totalViwers = json['totalViwers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookTitle'] = this.bookTitle;
    data['name'] = this.name;
    data['category'] = this.category;
    data['bookCoverImage'] = this.bookCoverImage;
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['totalViwers'] = this.totalViwers;
    return data;
  }
}

class Poem {
  String? bookTitle;
  String? name;
  String? category;
  String? bookCoverImage;
  String? id;
  String? userid;
  String? totalViwers;

  Poem(
      {this.bookTitle,
        this.name,
        this.category,
        this.bookCoverImage,
        this.id,
        this.userid,
        this.totalViwers});

  Poem.fromJson(Map<String, dynamic> json) {
    bookTitle = json['BookTitle'];
    name = json['name'];
    category = json['category'];
    bookCoverImage = json['bookCoverImage'];
    id = json['id'];
    userid = json['userid'];
    totalViwers = json['totalViwers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookTitle'] = this.bookTitle;
    data['name'] = this.name;
    data['category'] = this.category;
    data['bookCoverImage'] = this.bookCoverImage;
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['totalViwers'] = this.totalViwers;
    return data;
  }
}

class Winners {
  String? bookTitle;
  String? name;
  String? category;
  String? bookCoverImage;
  String? id;
  String? userid;
  String? totalViwers;

  Winners(
      {this.bookTitle,
        this.name,
        this.category,
        this.bookCoverImage,
        this.id,
        this.userid,
        this.totalViwers});

  Winners.fromJson(Map<String, dynamic> json) {
    bookTitle = json['BookTitle'];
    name = json['name'];
    category = json['category'];
    bookCoverImage = json['bookCoverImage'];
    id = json['id'];
    userid = json['userid'];
    totalViwers = json['totalViwers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookTitle'] = this.bookTitle;
    data['name'] = this.name;
    data['category'] = this.category;
    data['bookCoverImage'] = this.bookCoverImage;
    data['id'] = this.id;
    data['userid'] = this.userid;
    data['totalViwers'] = this.totalViwers;
    return data;
  }
}