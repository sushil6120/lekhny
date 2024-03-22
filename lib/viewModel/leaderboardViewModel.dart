import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/leaderboardMostFollowersModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostLikesModelClass.dart';
import 'package:lekhny/data/model/leaderboardMostPostsModelClass.dart';
import 'package:lekhny/data/repository/leaderboardMostFollowersRepository.dart';
import 'package:lekhny/data/repository/leaderboardMostLikesRepository.dart';
import 'package:lekhny/data/repository/leaderboardMostPostsRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';

class LeaderboardViewModel with ChangeNotifier{

  final _leaderboardMostPostsRepository = LeaderboardMostPostsRepository();
  final _leaderboardMostLikesRepository = LeaderboardMostLikesRepository();
  final _leaderboardMostFollowersRepository = LeaderboardMostFollowersRepository();

  LeaderboardMostPostsModelClass? leaderboardMostPostsModel;
  LeaderboardMostLikesModelClass? leaderboardMostLikesModel;
  LeaderboardMostFollowersModelClass? leaderboardMostFollowersModel;

  ApiResponse<dynamic> leaderboardData = ApiResponse.loading();

  bool load = false;

  List<MostPostsTopRankers> mostPostsTopRankersData = [];
  List<MostLikesTopRankers> mostLikesTopRankersData = [];
  List<MostFollowersTopRankers> mostFollowersTopRankersData = [];

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setMostPostsTopRankersData(json) {
   mostPostsTopRankersData =mostPostsTopRankersData + json;
    notifyListeners();
  }

  setMostLikesTopRankersData(json) {
    mostLikesTopRankersData =mostLikesTopRankersData + json;
    notifyListeners();
  }

  setMostFollowersTopRankersData(json) {
    mostFollowersTopRankersData =mostFollowersTopRankersData + json;
    notifyListeners();
  }

  setLeaderboardData( ApiResponse<dynamic> response){
    print('working');
    leaderboardData = response;
    print("this is responsePassed ${response}");
    print("this is leaderboardData ${leaderboardData}");
    notifyListeners();
  }

  Future<void> getLeaderboardMostPostsData(dynamic headers, page, setLoadMore, setData) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setLeaderboardData(ApiResponse.loading());
    }

    _leaderboardMostPostsRepository.leaderboardMostPostsApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.completed(value));
      }

      if(setData == true){
        leaderboardMostPostsModel = value;
      }



      List<MostPostsTopRankers>? list = [];
      list = value!.data!.topRankers;
      setMostPostsTopRankersData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getLeaderboardMostLikesData(dynamic headers, page, setLoadMore, setData) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setLeaderboardData(ApiResponse.loading());
    }

    _leaderboardMostLikesRepository.leaderboardMostLikesApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.completed(value));
      }

      if(setData == true){
        leaderboardMostLikesModel = value;
      }



      List<MostLikesTopRankers>? list = [];
      list = value!.data!.topRankers;
      setMostLikesTopRankersData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.error(error.toString()));
      }
    });
  }

  Future<void> getLeaderboardMostFollowersData(dynamic headers, page, setLoadMore, setData) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setLeaderboardData(ApiResponse.loading());
    }

    _leaderboardMostFollowersRepository.leaderboardMostFollowersApi(null, headers, page).then((value) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.completed(value));
      }

      if(setData == true){
        leaderboardMostFollowersModel = value;
      }



      List<MostFollowersTopRankers>? list = [];
      list = value!.data!.topRankers;
      setMostFollowersTopRankersData(list);

    }).onError((error, stackTrace) {
      if (setLoadMore == true){
        setLoad(false);
      }else{
        setLeaderboardData(ApiResponse.error(error.toString()));
      }
    });
  }

}