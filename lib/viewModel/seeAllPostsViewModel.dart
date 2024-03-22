import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/dailyCompetitionTopicPostsModelClass.dart';
import 'package:lekhny/data/model/latestPostsModelClass.dart';
import 'package:lekhny/data/model/mostReadPostModelClass.dart';
import 'package:lekhny/data/model/pastDailyTopicsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/model/postsBySubCategoryModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/categoryModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/model/topPostsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/topWritersModelClass.dart';
import 'package:lekhny/data/model/upcomingBookModelClass.dart';
import 'package:lekhny/data/model/userProfileModelClass.dart';
import 'package:lekhny/data/repository/PostsByCategoryRepository.dart';
import 'package:lekhny/data/repository/PostsBySubCategoryRepository.dart';
import 'package:lekhny/data/repository/categoryRepository.dart';
import 'package:lekhny/data/repository/dailyCompetitionTopicPostsRepository.dart';
import 'package:lekhny/data/repository/latestPostsRepository.dart';
import 'package:lekhny/data/repository/mostReadPostsRepository.dart';
import 'package:lekhny/data/repository/pastDailyTopicsRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/subCategoryRepository.dart';
import 'package:lekhny/data/repository/topPicksRepository.dart';
import 'package:lekhny/data/repository/topPostsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/topWritersRepository.dart';
import 'package:lekhny/data/repository/upcomingBookRepository.dart';
import 'package:lekhny/data/repository/userProfileRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class SeeAllPostsViewModel with ChangeNotifier{

  final _readingHistoryRepository = ReadingHistoryRepository();
  final _topPicksRepository = TopPicksRepository();
  final _topSeriesRepository = TopSeriesRepository();
  final _topPostsRepository = TopPostsRepository();
  final _topWritersRepository = TopWritersRepository();
  final _latestPostsRepository = LatestPostsRepository();
  final _mostReadPostsRepository = MostReadPostsRepository();
  final _pastDailyTopicsRepository = PastDailyTopicsRepository();
  final _dailyCompetitionTopicPostsRepository = DailyCompetitionTopicPostsRepository();

  TopSeriesModelClass? topSeriesModel;
  TopPicksModelClass? topPicksModel;
  ReadingHistoryModelClass? readingHistoryModel;
  TopPostsModelClass? topPostsModel;
  TopWritersModelClass? topWritersModel;
  UpcomingBookModelClass? upcomingBookModel;
  UserProfileModelClass? userProfileModel;
  LatestPostsModelClass? latestPostsModel;
  MostReadPostsModelClass? mostReadPostsModel;
  PastDailyTopicsModelClass? pastDailyTopicsModel;
  DailyCompetitionTopicPostsModelClass? dailyCompetitionTopicPostsModel;

  ApiResponse<dynamic> seeAllPostsData = ApiResponse.loading();

  bool load = false;

  List<ReadingHistoryData> readingHistoryData = [];
  List<LatestPostsData> latestPostsData = [];
  List<MostReadPostsData> mostReadPostsData = [];
  List<PastDailyTopicsData> pastDailyTopicsData = [];
  List<TopSeriesData> topSeriesData = [];
  List<TopPicksData> topPicksData = [];
  List<TopPostsData> topPostsData = [];
  List<AllTopic> allTopicData = [];
  List<CompetitionPost> competitionPostsData = [];

  setLoad(value) {
    load = value;
    notifyListeners();
  }

  setSeeAllPostsData( ApiResponse<dynamic> response){
    seeAllPostsData = response;
    notifyListeners();
  }

  setReadingHistoryData(json) {
    readingHistoryData = readingHistoryData + json;
    notifyListeners();
  }

  setTopPostsData(json) {
    topPostsData = topPostsData + json;
    notifyListeners();
  }

  setTopPicksData(json) {
    topPicksData = topPicksData + json;
    notifyListeners();
  }

  setTopSeriesData(json){
    topSeriesData = topSeriesData + json;
    notifyListeners();
  }

  setMostReadPostsData(json){
    mostReadPostsData = mostReadPostsData + json;
    notifyListeners();
  }

  setLatestPostsData(json){
    latestPostsData = latestPostsData + json;
    notifyListeners();
  }

  setPastDailyTopicsData(json){
    allTopicData = allTopicData + json;
    notifyListeners();
  }

  setCompetitonPostsData(json){
    competitionPostsData = competitionPostsData + json;
    notifyListeners();
  }


  Future<void> getSeeAllPostsData(dynamic data, dynamic headers,page, setLoadMore, id, topicId) async{

    if (setLoadMore == true){
      setLoad(true);
    }else{
      setSeeAllPostsData(ApiResponse.loading());

    }

    if (id == "1"){
      _readingHistoryRepository.readingHistoryApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }


        List<ReadingHistoryData>? list = [];
        list = value!.data;
        setReadingHistoryData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });
    }else if(id == "2"){
      _topPostsRepository.topPostsApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<TopPostsData>? list = [];
        list = value!.data!.topStory;
        setTopPostsData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "3"){
      _topPicksRepository.topPicksApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<TopPicksData>? list = [];
        list = value!.data;
        setTopPicksData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "4"){
      _topSeriesRepository.topSeriesApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<TopSeriesData>? list = [];
        list = value!.data;
        setTopSeriesData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "5"){
      _mostReadPostsRepository.mostReadPostsApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<MostReadPostsData>? list = [];
        list = value!.data;
        setMostReadPostsData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "6"){
      _latestPostsRepository.latestPostsApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<LatestPostsData>? list = [];
        list = value!.data;
        setLatestPostsData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "7"){
      _pastDailyTopicsRepository.pastDailyTopicsApi(data, headers, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<AllTopic>? list = [];
        list = value!.data!.allTopic;
        setPastDailyTopicsData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }else if(id == "8"){
      _dailyCompetitionTopicPostsRepository.dailyCompetitonTopicPostsApi(data, headers, topicId, page).then((value) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.completed(value));
        }

        List<CompetitionPost>? list = [];
        list = value!.data!.competitionPost;
        setCompetitonPostsData(list);

      }).onError((error, stackTrace) {
        if (setLoadMore == true){
          setLoad(false);
        }else{
          setSeeAllPostsData(ApiResponse.error(error.toString()));
        }
      });

    }

  }
}