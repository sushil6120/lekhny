import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lekhny/data/model/publishedPostModelClass.dart';
import 'package:lekhny/data/model/publishedSeriesModelClass.dart';
import 'package:lekhny/data/model/singleBookDataModelClass.dart';
import 'package:lekhny/data/model/unPublishedPostModelClass.dart';
import 'package:lekhny/data/repository/publishPostRepository.dart';
import 'package:lekhny/data/repository/publishedPostsRepository.dart';
import 'package:lekhny/data/repository/publishedSeriesRepository.dart';
import 'package:lekhny/data/repository/singleBookDataRepository.dart';
import 'package:lekhny/data/repository/unPublishedPostRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:html2md/html2md.dart' as html2md;

class ProfilePostsViewModel with ChangeNotifier{

  final _publishedPostsRepository = PublishedPostRepository();
  final _unPublishedPostsRepository = UnPublishedPostRepository();
  final _publishedSeriesRepository = PublishedSeriesRepository();
  final _singleBookDataRepository = SingleBookDataRepository();

  PublishedPostModelClass? publishedPostModelClass;
  UnPublishedPostModelClass? unPublishedPostModelClass;
  PublishedSeriesModelClass? publishedSeriesModelClass;
  SingleBookDataModelClass? singleBookDataModel;

  ApiResponse<dynamic> profilePostsData = ApiResponse.loading();

  int? tappedIndex;
  bool load = false;
  bool singleBookDataLoading = false;
  String? selectedValue = 'Published';

  List<PublishedPostData> publishedPostData = [];
  List<UnPublishedPostData> unPublishedPostData = [];
  List<PublishedSeriesData> publishedSeriesData = [];

  setTappedIndex(value){
    tappedIndex = value;
  }

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setSingleBookDataLoading(value) {
    singleBookDataLoading = value;
    notifyListeners();
  }

  setSelectedValue(value){
    selectedValue = value as String;
    notifyListeners();
  }

  setProfilePostsData( ApiResponse<dynamic> response){
    print('working');
    profilePostsData = response;
    print("this is responsePassed ${response}");
    print("this is profilePostsData ${profilePostsData}");
    notifyListeners();
  }

  setPublishedPostData(json) {
    publishedPostData = publishedPostData + json;
    notifyListeners();
  }

  setUnPublishedPostData(json) {
    unPublishedPostData = unPublishedPostData + json;
    notifyListeners();
  }

  setPublishedSeriesData(json) {
    publishedSeriesData = publishedSeriesData + json;
    notifyListeners();
  }

  Future<void> getPublishedPostData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setProfilePostsData(ApiResponse.loading());
    }

    var body = {
      "pegination": page
    };

    var data = jsonEncode(body);

    _publishedPostsRepository.publishedPostsApi(data, headers).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.completed(value));
      }

      List<PublishedPostData>? list = [];
      list = value!.data;
      setPublishedPostData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getUnPublishedPostData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setProfilePostsData(ApiResponse.loading());
    }

    var body = {
      "pegination": page
    };

    var data = jsonEncode(body);

    _unPublishedPostsRepository.unPublishedPostsApi(data, headers).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.completed(value));
      }

      List<UnPublishedPostData>? list = [];
      list = value!.data;
      setUnPublishedPostData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getPublishedSeriesData(dynamic headers, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setProfilePostsData(ApiResponse.loading());
    }

    var body = {
      "pegination": page
    };

    var data = jsonEncode(body);

    _publishedSeriesRepository.publishedSeriesApi(data, headers).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.completed(value));
      }

      List<PublishedSeriesData>? list = [];
      list = value!.data;
      setPublishedSeriesData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setProfilePostsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getSingleBookData(String postId, dynamic data, dynamic headers, BuildContext context) async{

     setSingleBookDataLoading(true);

    _singleBookDataRepository.singleBookDataApi(postId, data, headers).then((value){
      //singleBookDataModel = value;
      print("this is data ${value!.data![0].postData}");

      String? text;

      if(value!.data![0].postData == null){
        text = "";
      }else{
        String? text1 = value!.data![0].postData;
        String? text2 = text1;
        text = html2md.convert(text2!);
      }

      Navigator.pushNamed(context, RoutesName.textEditorScreen,
          arguments: {"postId" : "${postId}", "isContest" : '2', "contestId": null, "data" : text,"mainPostId": null }
      );

      setTappedIndex(null);

      print('this is future.wait value ${value}');

      setSingleBookDataLoading(false);
      print('apiresponse.completed working');

    }).onError((error, stackTrace){
      setTappedIndex(null);
      setSingleBookDataLoading(false);

    });
  }

}
