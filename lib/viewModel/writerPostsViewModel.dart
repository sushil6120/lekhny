import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lekhny/data/model/publishedSeriesModelClass.dart';
import 'package:lekhny/data/model/singleBookDataModelClass.dart';
import 'package:lekhny/data/model/writerPostsModelClass.dart';
import 'package:lekhny/data/model/writerSeriesModelClass.dart';
import 'package:lekhny/data/repository/publishPostRepository.dart';
import 'package:lekhny/data/repository/writerPostsRepository.dart';
import 'package:lekhny/data/repository/publishedSeriesRepository.dart';
import 'package:lekhny/data/repository/singleBookDataRepository.dart';
import 'package:lekhny/data/repository/writerPostsRepository.dart';
import 'package:lekhny/data/repository/writerSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:html2md/html2md.dart' as html2md;

class WriterPostsViewModel with ChangeNotifier{

  final _writerPostsRepository = WriterPostsRepository();
  final _writerSeriesRepository = WriterSeriesRepository();

  WriterPostsModelClass? writerPostsModel;
  WriterSeriesModelClass? writerSeriesModel;

  ApiResponse<dynamic> writerPostsData = ApiResponse.loading();

  int? tappedIndex;
  bool load = false;

  List<WriterSinglePostsData> writerSinglePostsData = [];
  List<WriterSeriesData> writerSeriesData = [];

  setTappedIndex(value){
    tappedIndex = value;
  }

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setWriterPostsData( ApiResponse<dynamic> response){
    print('working');
    writerPostsData = response;
    print("this is responsePassed ${response}");
    print("this is writerPostsData ${writerPostsData}");
    notifyListeners();
  }

  setWriterSinglePostsData(json) {
    writerSinglePostsData = writerSinglePostsData + json;
    notifyListeners();
  }

  setWriterSeriesData(json) {
    writerSeriesData = writerSeriesData + json;
    notifyListeners();
  }

  Future<void> getWriterSinglePostsData(dynamic data, dynamic headers,  writerId, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setWriterPostsData(ApiResponse.loading());
    }

    _writerPostsRepository.writerPostsApi(writerId, page, data, headers).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setWriterPostsData(ApiResponse.completed(value));
      }

      List<WriterSinglePostsData>? list = [];
      list = value!.data;
      setWriterSinglePostsData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setWriterPostsData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getWriterSeriesData(dynamic data, dynamic headers,  writerId, page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setWriterPostsData(ApiResponse.loading());
    }

    _writerSeriesRepository.writerSeriesApi(writerId, page, data, headers).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setWriterPostsData(ApiResponse.completed(value));
      }

      List<WriterSeriesData>? list = [];
      list = value!.data;
      setWriterSeriesData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setWriterPostsData(ApiResponse.error(error.toString()));
      }
    });
  }

}
