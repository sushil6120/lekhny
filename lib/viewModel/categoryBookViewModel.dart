import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/model/postsBySubCategoryModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/PostsByCategoryRepository.dart';
import 'package:lekhny/data/repository/PostsBySubCategoryRepository.dart';
import 'package:lekhny/data/repository/categoryRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/subCategoryRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class CategoryBookViewModel with ChangeNotifier{

  final _subCategoryRepository = SubCategoryRepository();
  final _postsByCategoryRepository = PostsByCategoryRepository();
  final _postsBySubCategoryRepository = PostsBySubCategoryRepository();

  SubCategoryModelClass? subCategoryModel;
  PostsByCategoryModelClass? postsByCategoryModel;
  PostsBySubCategoryModelClass? postsBySubCategoryModel;

  ApiResponse<List<dynamic>> subCategoryData = ApiResponse.loading();

  bool? isAll;
  bool load = false;
  int? tappedIndex;
  //int page = 1;
  List<CategoryBookData> categoryBookData = [];
  List<SubCategoryBookData> subCategoryBookData = [];


  setIsAll(value) {
    isAll = value;
    notifyListeners();
  }

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setTappedIndex(value) {
    tappedIndex = value;
    notifyListeners();
  }

  // setPage() {
  //   page = page + 1;
  //   notifyListeners();
  // }

  setCategoryBookData(json) {
    categoryBookData = categoryBookData + json;
    notifyListeners();
  }
  setSubCategoryBookData(json) {
    subCategoryBookData = subCategoryBookData + json;
    notifyListeners();
  }


  setSubCategoryData( ApiResponse<List<dynamic>> response){
    print('working');
    subCategoryData = response;
    print("this is responsePassed ${response}");
    print("this is subCategoryData ${subCategoryData}");
    notifyListeners();
  }

  Future<void> getSubCategoryData(categoryId, dynamic data, dynamic headers) async{


    setSubCategoryData(ApiResponse.loading());

    Future.wait([
      _subCategoryRepository.subCategoryApi(categoryId, data, headers)
    ]).then((value){

      subCategoryModel = value[0] as SubCategoryModelClass;

      print('this is future.wait value ${value}');

      setSubCategoryData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setSubCategoryData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> getPostsByCategoryData(dynamic data, dynamic headers,categoryId,page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }

    _postsByCategoryRepository.postByCategoryApi(data, headers, categoryId, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }
      //setSubCategoryData(ApiResponse.completed(value));
      List<CategoryBookData>? list = [];

      list = value!.data;
      setCategoryBookData(list);
    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }
      //setFollowing(ApiResponse.error(error.toString()));
    });



  }

  Future<void> getPostsBySubCategoryData(dynamic data, dynamic headers,subCategoryId,page, setLoadMore) async{

    if (setLoadMore == true){
      setLoad(true);
    }

    _postsBySubCategoryRepository.postBySubCategoryApi(data, headers, subCategoryId, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }
      //setSubCategoryData(ApiResponse.completed(value));
      List<SubCategoryBookData>? list = [];


      list = value!.data;
      print("this is the list ${list}");
      setSubCategoryBookData(list);
    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }
      //setFollowing(ApiResponse.error(error.toString()));
    });



  }
}