import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SixDayStreakModelClass.dart';
import 'package:lekhny/data/model/dailyCompetitionRulesModelClass.dart';
import 'package:lekhny/data/model/dailyCompetitonWinnersModelClass.dart';
import 'package:lekhny/data/model/latestPostsModelClass.dart';
import 'package:lekhny/data/model/mostReadPostModelClass.dart';
import 'package:lekhny/data/model/pastDailyTopicsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/model/topPostsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/topWritersModelClass.dart';
import 'package:lekhny/data/model/upcomingBookModelClass.dart';
import 'package:lekhny/data/model/userProfileModelClass.dart';
import 'package:lekhny/data/repository/dailyCompetitionRulesRepository.dart';
import 'package:lekhny/data/repository/dailyCompetitionWinnersRepository.dart';
import 'package:lekhny/data/repository/latestPostsRepository.dart';
import 'package:lekhny/data/repository/mostReadPostsRepository.dart';
import 'package:lekhny/data/repository/pastDailyTopicsRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/sixDayStreakRepository.dart';
import 'package:lekhny/data/repository/topPicksRepository.dart';
import 'package:lekhny/data/repository/topPostsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/topWritersRepository.dart';
import 'package:lekhny/data/repository/upcomingBookRepository.dart';
import 'package:lekhny/data/repository/userProfileRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class HomePageViewModel with ChangeNotifier{

  final _readingHistoryRepo = ReadingHistoryRepository();
  final _topPicksRepository = TopPicksRepository();
  final _topSeriesRepository = TopSeriesRepository();
  final _topPostsRepository = TopPostsRepository();
  final _topWritersRepository = TopWritersRepository();
  final _upcomingBookRepository = UpcomingBookRepository();
  final _userProfileRepsitory = UserProfileRepository();
  final _latestPostsRepository = LatestPostsRepository();
  final _mostReadPostsRepository = MostReadPostsRepository();
  final _pastDailyTopicsRepository = PastDailyTopicsRepository();
  final _dailyCompetitionWinnersRepository = DailyCompetitionWinnersRepository();
  final _sixDayStreakRepository = SixDayStreakRepository();
  final _dailyCompetitionRulesRepository = DailyCompetitionRulesRepository();

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
  DailyCompetitionRulesModelClass? dailyCompetitionRulesModel;

  DailyCompetitionWinnersModelClass? dailyCompetitionWinnersModel;
  SixDayStreakModelClass? sixDayStreakModel;
  dynamic sixDayStreakResponse;

  ApiResponse<List<dynamic>> homePageData = ApiResponse.loading();

  int? dailyWinnerTappedIndex;
  bool? dailyWinnerLoading;
  List<Winners> winnersList = [];

  setDailyWinnerTappedIndex(value) {
    dailyWinnerTappedIndex = value;
    notifyListeners();
  }

  setDailyWinnerLoading(value){
    dailyWinnerLoading = value;
    notifyListeners();
  }

  setHomePageData( ApiResponse<List<dynamic>> response){
    print('working');
    homePageData = response;
    print("this is responsePassed ${response}");
    print("this is homePageData ${homePageData}");
    notifyListeners();
  }

  //
  // bool _loading = false;
  //
  // bool get loading => _loading;
  //
  // setLoading(bool value){
  //   _loading = value;
  //   notifyListeners();
  // }
  

  gethomePageData(dynamic data, dynamic headers, page){


    setHomePageData(ApiResponse.loading());
    
    Future.wait([

      _readingHistoryRepo.readingHistoryApi(data, headers, page),
      _topPicksRepository.topPicksApi(data, headers, page),
      _topSeriesRepository.topSeriesApi(data, headers, page),
      _topPostsRepository.topPostsApi(data, headers, page),
      _topWritersRepository.topWritersApi(data, headers),
      _upcomingBookRepository.upcomingBookApi(data, headers),
      _userProfileRepsitory.userProfileApi(null, headers),
      _latestPostsRepository.latestPostsApi(null, headers, page),
      _mostReadPostsRepository.mostReadPostsApi(data, headers, page),
      _pastDailyTopicsRepository.pastDailyTopicsApi(data, headers, page),
      _sixDayStreakRepository.sixDayStreakApi(data, headers),
      _dailyCompetitionRulesRepository.dailyCompetitionRulesApi(data, headers)

    ]).then((value){

      readingHistoryModel = value[0] as ReadingHistoryModelClass;
      topPicksModel = value[1] as TopPicksModelClass;
      topSeriesModel = value[2] as TopSeriesModelClass;
      topPostsModel = value[3] as TopPostsModelClass;
      topWritersModel = value[4] as TopWritersModelClass;
      upcomingBookModel = value[5] as UpcomingBookModelClass;
      userProfileModel = value[6] as UserProfileModelClass;
      latestPostsModel = value[7] as LatestPostsModelClass;
      mostReadPostsModel = value[8] as MostReadPostsModelClass;
      pastDailyTopicsModel = value[9] as PastDailyTopicsModelClass;
      sixDayStreakResponse = value[10];
      dailyCompetitionRulesModel = value[11] as DailyCompetitionRulesModelClass;

      print('this is future.wait value ${value}');

      setHomePageData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setHomePageData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> getDailyCompetitionWinnersData(dynamic data, dynamic headers, String day) async{

    setDailyWinnerLoading(true);
    _dailyCompetitionWinnersRepository.dailyCompetitionWinnersApi(data, headers, day).then((value){

      dailyCompetitionWinnersModel = value;
      winnersList = dailyCompetitionWinnersModel!.data!.poem! + dailyCompetitionWinnersModel!.data!.story!;
      print('this is future.wait value ${value}');
      setDailyWinnerLoading(false);
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setDailyWinnerLoading(false);

    });
  }
}