import 'package:lekhny/data/model/latestPostsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/latestPostsModelClass.dart';
import 'package:lekhny/data/model/latestPostsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LatestPostsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LatestPostsModelClass? latestPostsModel;

  Future<LatestPostsModelClass?> latestPostsApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.latestPostsUrl}$page", data, headers);
      print("this is LatestPosts resposne ${response}");
      latestPostsModel = LatestPostsModelClass.fromJson(response);
      return latestPostsModel;

    }catch(e){
      print("this is LatestPosts error $e");
      throw(e);
    }
  }
}