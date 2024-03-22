import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/categoryRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class CategoryViewModel with ChangeNotifier{

  final _categoryRepository = CategoryRepository();

  CategoryModelClass? categoryModel;
  
  ApiResponse<List<dynamic>> categoryData = ApiResponse.loading();

  setCategoryData( ApiResponse<List<dynamic>> response){
    print('working');
    categoryData = response;
    print("this is responsePassed ${response}");
    print("this is categoryData ${categoryData}");
    notifyListeners();
  }

  Future<void> getCategoryData(dynamic data, dynamic headers) async{


    setCategoryData(ApiResponse.loading());

    Future.wait([
     _categoryRepository.categoryApi(data, headers)
    ]).then((value){

      categoryModel = value[0] as CategoryModelClass;
      
      print('this is future.wait value ${value}');

      setCategoryData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setCategoryData(ApiResponse.error(error.toString()));

    });
  }
}