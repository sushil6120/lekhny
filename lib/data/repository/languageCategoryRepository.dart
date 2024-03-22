import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LanguageCategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LanguageCategoryModelClass? languageCategoryModel;

  Future<LanguageCategoryModelClass?> languageCategoryApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.languageCategoryUrl, data, headers);
      print("this is resposne ${response}");
      languageCategoryModel = LanguageCategoryModelClass.fromJson(response);
      return languageCategoryModel;
    }catch(e){
      throw(e);
    }
  }
}