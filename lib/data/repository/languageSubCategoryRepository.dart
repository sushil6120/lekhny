import 'package:lekhny/data/model/languageSubCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LanguageSubCategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LanguageSubCategoryModelClass? languageSubCategoryModel;

  Future<LanguageSubCategoryModelClass?> languageSubCategoryApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.languageSubCategoryUrl, data, headers);
      print("this is resposne ${response}");
      languageSubCategoryModel = LanguageSubCategoryModelClass.fromJson(response);
      return languageSubCategoryModel;
    }catch(e){
      throw(e);
    }
  }
}