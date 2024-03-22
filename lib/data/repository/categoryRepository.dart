import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class CategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  CategoryModelClass? categoryModel;

  Future<CategoryModelClass?> categoryApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.categoryUrl, data, headers);
      print("this is resposne ${response}");
      categoryModel = CategoryModelClass.fromJson(response);
      return categoryModel;

    }catch(e){
      throw(e);
    }
  }
}