import 'package:lekhny/data/model/leaderboardMostFollowersModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostFollowersModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostFollowersModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LeaderboardMostFollowersRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LeaderboardMostFollowersModelClass? leaderboardMostFollowersModel;

  Future<LeaderboardMostFollowersModelClass?> leaderboardMostFollowersApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.leaderboardMostFollowersUrl}$page", data, headers);
      print("this is LeaderboardMostFollowers resposne ${response}");
      leaderboardMostFollowersModel = LeaderboardMostFollowersModelClass.fromJson(response);
      return leaderboardMostFollowersModel;

    }catch(e){
      print("this is LeaderboardMostFollowers error $e");
      throw(e);
    }
  }
}