import 'package:lekhny/data/model/likePostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/likePostModelClass.dart';
import 'package:lekhny/data/model/likePostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LikePostRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  LikePostModelClass? likePostModel;

  Future<LikePostModelClass?> likePostApi(String postId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.likePostUrl}$postId', data, headers);
      print("this is response $response");
      likePostModel = LikePostModelClass.fromJson(response);
      return likePostModel;
    }catch(e){
      throw(e);
    }
  }
}