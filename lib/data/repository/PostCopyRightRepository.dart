import 'package:lekhny/data/model/postCopyrightModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostCopyrightRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PostCopyrightModelClass? postCopyrightModel;

  Future<PostCopyrightModelClass?> postCopyrightApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.postCopyrightUrl, data, headers);
      print("this is resposne ${response}");
      postCopyrightModel = PostCopyrightModelClass.fromJson(response);
      return postCopyrightModel;
    }catch(e){
      throw(e);
    }
  }
}