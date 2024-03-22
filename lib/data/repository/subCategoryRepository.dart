import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class SubCategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  SubCategoryModelClass? subCategoryModel;

  Future<SubCategoryModelClass?> subCategoryApi(String categoryID, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.subCategoryUrl}${categoryID}', data, headers);
      print("this is resposne ${response}");
      subCategoryModel = SubCategoryModelClass.fromJson(response);
      return subCategoryModel;
    }catch(e){
      throw(e);
    }
  }
}