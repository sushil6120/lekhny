import 'package:lekhny/data/model/leaderboardMostLikesModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostLikesModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostLikesModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LeaderboardMostLikesRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LeaderboardMostLikesModelClass? leaderboardMostLikesModel;

  Future<LeaderboardMostLikesModelClass?> leaderboardMostLikesApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.leaderboardMostLikesUrl}$page", data, headers);
      print("this is LeaderboardMostLikes resposne ${response}");
      leaderboardMostLikesModel = LeaderboardMostLikesModelClass.fromJson(response);
      return leaderboardMostLikesModel;

    }catch(e){
      print("this is LeaderboardMostLikes error $e");
      throw(e);
    }
  }
}