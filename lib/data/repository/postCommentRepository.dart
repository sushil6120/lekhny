import 'package:lekhny/data/model/postCommentModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostCommentRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PostCommentModelClass? postCommentModel;

  Future<PostCommentModelClass?> postCommentApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.postCommentUrl, data, headers);
      print("this is resposne ${response}");
      postCommentModel = PostCommentModelClass.fromJson(response);
      return postCommentModel;
    }catch(e){
      throw(e);
    }
  }
}