import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostDetailsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PostDetailsModelClass? postDetailsModel;

  Future<PostDetailsModelClass?> postDetailsApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.postDetailsUrl, data, headers);
      print("this is resposne ${response}");
      postDetailsModel = PostDetailsModelClass.fromJson(response);
      return postDetailsModel;
    }catch(e){
      throw(e);
    }
  }
}