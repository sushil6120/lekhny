class MainSearchModelClass {
  int? status;
  Data? data;

  MainSearchModelClass({this.status, this.data});

  MainSearchModelClass.fromJson(Map<String, dynamic> json) {
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
  String? searchKey;
  List<Writters>? writters;
  List<PostBytitle>? postBytitle;
  List<PostBycategory>? postBycategory;
  List<MainCategory>? mainCategory;

  Data(
      {this.searchKey,
        this.writters,
        this.postBytitle,
        this.postBycategory,
        this.mainCategory});

  Data.fromJson(Map<String, dynamic> json) {
    searchKey = json['searchKey'];
    if (json['writters'] != null) {
      writters = <Writters>[];
      json['writters'].forEach((v) {
        writters!.add(new Writters.fromJson(v));
      });
    }
    if (json['postBytitle'] != null) {
      postBytitle = <PostBytitle>[];
      json['postBytitle'].forEach((v) {
        postBytitle!.add(new PostBytitle.fromJson(v));
      });
    }
    if (json['postBycategory'] != null) {
      postBycategory = <PostBycategory>[];
      json['postBycategory'].forEach((v) {
        postBycategory!.add(new PostBycategory.fromJson(v));
      });
    }
    if (json['mainCategory'] != null) {
      mainCategory = <MainCategory>[];
      json['mainCategory'].forEach((v) {
        mainCategory!.add(new MainCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchKey'] = this.searchKey;
    if (this.writters != null) {
      data['writters'] = this.writters!.map((v) => v.toJson()).toList();
    }
    if (this.postBytitle != null) {
      data['postBytitle'] = this.postBytitle!.map((v) => v.toJson()).toList();
    }
    if (this.postBycategory != null) {
      data['postBycategory'] =
          this.postBycategory!.map((v) => v.toJson()).toList();
    }
    if (this.mainCategory != null) {
      data['mainCategory'] = this.mainCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Writters {
  String? authName;
  int? authID;
  String? authProfile;
  String? iSwriterVerified;

  Writters(
      {this.authName, this.authID, this.authProfile, this.iSwriterVerified});

  Writters.fromJson(Map<String, dynamic> json) {
    authName = json['authName'];
    authID = json['authID'];
    authProfile = json['authProfile'];
    iSwriterVerified = json['ISwriterVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authName'] = this.authName;
    data['authID'] = this.authID;
    data['authProfile'] = this.authProfile;
    data['ISwriterVerified'] = this.iSwriterVerified;
    return data;
  }
}

class PostBytitle {
  int? postID;
  String? postTitle;
  String? authName;
  int? totalviewes;
  String? postCover;
  int? autherID;

  PostBytitle(
      {this.postID,
        this.postTitle,
        this.authName,
        this.totalviewes,
        this.postCover,
        this.autherID});

  PostBytitle.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postTitle = json['postTitle'];
    authName = json['authName'];
    totalviewes = json['totalviewes'];
    postCover = json['postCover'];
    autherID = json['autherID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postTitle'] = this.postTitle;
    data['authName'] = this.authName;
    data['totalviewes'] = this.totalviewes;
    data['postCover'] = this.postCover;
    data['autherID'] = this.autherID;
    return data;
  }
}

class PostBycategory {
  int? postID;
  String? postTitle;
  String? authName;
  int? totalviewes;
  String? postCover;
  int? autherID;
  int? totalallviewes;
  int? allParts;

  PostBycategory(
      {this.postID,
        this.postTitle,
        this.authName,
        this.totalviewes,
        this.postCover,
        this.autherID,
        this.totalallviewes,
        this.allParts});

  PostBycategory.fromJson(Map<String, dynamic> json) {
    postID = json['postID'];
    postTitle = json['postTitle'];
    authName = json['authName'];
    totalviewes = json['totalviewes'];
    postCover = json['postCover'];
    autherID = json['autherID'];
    totalallviewes = json['totalallviewes'];
    allParts = json['allParts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postID'] = this.postID;
    data['postTitle'] = this.postTitle;
    data['authName'] = this.authName;
    data['totalviewes'] = this.totalviewes;
    data['postCover'] = this.postCover;
    data['autherID'] = this.autherID;
    data['totalallviewes'] = this.totalallviewes;
    data['allParts'] = this.allParts;
    return data;
  }
}

class MainCategory {
  String? category;
  int? categoryID;

  MainCategory({this.category, this.categoryID});

  MainCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    categoryID = json['categoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['categoryID'] = this.categoryID;
    return data;
  }
}