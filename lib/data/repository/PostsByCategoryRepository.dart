import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostsByCategoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PostsByCategoryModelClass? postsByCategoryModel;

  Future<PostsByCategoryModelClass?> postByCategoryApi(dynamic data, dynamic headers, categoryId, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.postsByCategoryUrl}${page}&categoryID=${categoryId}", data, headers);
      print("this is resposne ${response}");
      postsByCategoryModel = PostsByCategoryModelClass.fromJson(response);
      return postsByCategoryModel;
    }catch(e){
      throw(e);
    }
  }
}