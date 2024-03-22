import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/monthlyCompetitionResultModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/monthlyCompetitionResultRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class ContestsViewModel with ChangeNotifier{

  final _monthlyCompetitionResultRepository = MonthlyCompetitionResultRepository();

  MonthlyCompetitionResultModelClass? monthlyCompetitionResultModel;

  ApiResponse<List<dynamic>> contestData = ApiResponse.loading();

  setContestData( ApiResponse<List<dynamic>> response){
    print('working');
    contestData = response;
    print("this is responsePassed ${response}");
    print("this is contestData ${contestData}");
    notifyListeners();
  }

  Future<void> getContestData(dynamic data, dynamic headers) async{

    setContestData(ApiResponse.loading());
    Future.wait([
     _monthlyCompetitionResultRepository.monthlyCompetitonResultApi(data, headers)

    ]).then((value){

      monthlyCompetitionResultModel = value[0] as MonthlyCompetitionResultModelClass;
      print('this is future.wait value ${value}');
      setContestData(ApiResponse.completed(value));
      //print('apiresponse.completed working');
    }).onError((error, stackTrace){

      setContestData(ApiResponse.error(error.toString()));

    });
  }
}