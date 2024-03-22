import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/dailyCompetitionParticipateModelClass.dart';
import 'package:lekhny/data/model/dailyCompetitonTopicModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/dailyCompetitionParticipateRepository.dart';
import 'package:lekhny/data/repository/dailyCompetitionTopicRepository.dart';
import 'package:lekhny/data/repository/dailyCompetitionTopicRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class DailyCompetitionViewModel with ChangeNotifier{

  final _dailyCompetitionTopicRepository = DailyCompetitionTopicRepository();
  final _dailyCompetitionParticipateRepository = DailyCompetitionParticipateRepository();

  DailyCompetitionTopicModelClass? dailyCompetitionTopicModel;
  DailyCompetitionParticipateModelClass? dailyCompetitionParticipateModel;

  ApiResponse<dynamic> dailyCompetitionData = ApiResponse.loading();

  String? name;

  bool? load = false;
  int? tappedIndex = null;

  setTappedIndex(index){
    tappedIndex = index;
    notifyListeners();
  }

  setLoad(value){
    load = value;
    notifyListeners();
  }

  setDailyCompetitionData( ApiResponse<dynamic> response){
    print('working');
    dailyCompetitionData = response;
    print("this is responsePassed ${response}");
    print("this is dailyCompetitionData ${dailyCompetitionData}");
    notifyListeners();
  }

  Future<void> getDailyCompetitionTopicData(dynamic data, dynamic headers) async{

    setDailyCompetitionData(ApiResponse.loading());

      _dailyCompetitionTopicRepository.dailyCompetitonTopicApi(data, headers).then((value){

      dailyCompetitionTopicModel = value;
      print('this is future.wait value ${value}');
      setDailyCompetitionData(ApiResponse.completed(value));
      //print('apiresponse.completed working');
    }).onError((error, stackTrace){

      setDailyCompetitionData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> getDailyCompetitionParticipateData(dynamic data, dynamic headers, contestId, context) async{

    _dailyCompetitionParticipateRepository.dailyCompetitionParticipateApi(data, headers, contestId).then((value){

      setTappedIndex(null);
      print("this is value ${value}");

      if(value!.status == 200){

        print("working");

        String postId = value.data.toString();

        print("working 2");

        Navigator.pushNamed(context, RoutesName.textEditorScreen,
            arguments: {"postId" : postId, "isContest" : '1', "contestId": contestId, "data": "", "mainPostId": null }
        );

        print("working 3");
      }
      else if(value!.status == 203){
        Utils.flushBarErrorMessage('You have already participated.', context, Icons.error_outline_rounded, colorLightWhite);

      }

      dailyCompetitionParticipateModel = value;


      print('this is future.wait value ${value}');


      //print('apiresponse.completed working');
    }).onError((error, stackTrace){

      setTappedIndex(null);

    });
  }

}