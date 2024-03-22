import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/allPointsDetailsModelClass.dart';
import 'package:lekhny/data/model/allPointsDetailsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/allPointsDetailsRepository.dart';
import 'package:lekhny/data/repository/draftsRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class LekhnyPointsViewModel with ChangeNotifier{

  final _allPointsDetailsRepository = AllPointsDetailsRepository();

  AllPointsDetailsModelClass? allPointsDetailsModel;

  ApiResponse<dynamic> allPointsDetailsData = ApiResponse.loading();

  setAllPointsDetailsData( ApiResponse<dynamic> response){
    print('working');
    allPointsDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is allPointsDetailsData ${allPointsDetailsData}");
    notifyListeners();
  }

  Future<void> getAllPointsDetailsData(dynamic data, dynamic headers) async{

    setAllPointsDetailsData(ApiResponse.loading());
    _allPointsDetailsRepository.allPointsDetailsApi(data, headers).then((value){
      allPointsDetailsModel = value;
      print('this is future.wait value ${value}');
      setAllPointsDetailsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setAllPointsDetailsData(ApiResponse.error(error.toString()));

    });
  }
}