import 'package:lekhny/data/model/leaderboardMostPostsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostPostsModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostPostsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LeaderboardMostPostsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LeaderboardMostPostsModelClass? leaderboardMostPostsModel;

  Future<LeaderboardMostPostsModelClass?> leaderboardMostPostsApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.leaderboardMostPostsUrl}$page", data, headers);
      print("this is LeaderboardMostPosts resposne ${response}");
      leaderboardMostPostsModel = LeaderboardMostPostsModelClass.fromJson(response);
      return leaderboardMostPostsModel;

    }catch(e){
      print("this is LeaderboardMostPosts error $e");
      throw(e);
    }
  }
}