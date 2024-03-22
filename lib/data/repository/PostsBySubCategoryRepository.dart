import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/model/postsBySubCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostsBySubCategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PostsBySubCategoryModelClass? postsBySubCategoryModel;

  Future<PostsBySubCategoryModelClass?> postBySubCategoryApi(dynamic data, dynamic headers, subCategoryId, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.postsBySubCategoryUrl}${subCategoryId}&pegination=${page}", data, headers);
      print("this is resposne ${response}");
      postsBySubCategoryModel = PostsBySubCategoryModelClass.fromJson(response);
      return postsBySubCategoryModel;
    }catch(e){
      throw(e);
    }
  }
}