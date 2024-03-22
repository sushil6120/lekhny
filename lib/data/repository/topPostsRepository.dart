import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topPostsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class TopPostsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  TopPostsModelClass? topPostModel;

  Future<TopPostsModelClass?> topPostsApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.topPostsUrl}$page", data, headers);
      print("this is TopPosts resposne ${response}");
      topPostModel = TopPostsModelClass.fromJson(response);
      return topPostModel;

    }catch(e){
      print("this is TopPosts error $e");
      throw(e);
    }
  }
}