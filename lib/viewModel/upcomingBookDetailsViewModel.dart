import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/upcomingBookDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/upcomingBookDetailsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/upcomingBookDetailsRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class UpcomingBookDetailsViewModel with ChangeNotifier{

  final _upcomingBookDetailsRepository = UpcomingBookDetailsRepository();
  UpcomingBookDetailsModelClass? upcomingBookDetailsModel;

  ApiResponse<dynamic> upcomingBookDetailsData = ApiResponse.loading();

  setUpcomingBookDetailsData( ApiResponse<dynamic> response){
    print('working');
    upcomingBookDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is upcomingBookDetailsData ${upcomingBookDetailsData}");
    notifyListeners();
  }

  Future<void> getUpcomingBookDetailsData(String bookId, dynamic data, dynamic headers) async{

    setUpcomingBookDetailsData(ApiResponse.loading());
      _upcomingBookDetailsRepository.upcomingBookDetailsApi(bookId, data, headers).then((value){
      upcomingBookDetailsModel = value;
      print('this is future.wait value ${value}');
      setUpcomingBookDetailsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');
    }).onError((error, stackTrace){
      setUpcomingBookDetailsData(ApiResponse.error(error.toString()));
    });
  }
}