import 'package:lekhny/data/model/postLikesListModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/postLikesListModelClass.dart';
import 'package:lekhny/data/model/postLikesListModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PostLikesListRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  PostLikesListModelClass? postLikesListModel;

  Future<PostLikesListModelClass?> postLikesListApi(String postId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.postLikesListUrl}$postId', data, headers);
      print("this is response $response");
      postLikesListModel = PostLikesListModelClass.fromJson(response);
      return postLikesListModel;
    }catch(e){
      throw(e);
    }
  }
}