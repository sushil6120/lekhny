import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/trendingSearchModelClass.dart';
import 'package:lekhny/data/repository/mainSearchRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/trendingSearchRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class SearchScreenViewModel with ChangeNotifier{

  final _mainSearchRepository = MainSearchRepository();
  final _trendingSearchRepository = TrendingSearchRepository();

  MainSearchModelClass? mainSearchModel;
  TrendingSearchModelClass? trendingSearchModel;

  ApiResponse<dynamic> mainSearchData = ApiResponse.loading();

  int? textFieldLength = 0;

  bool mainSearchLoading = false;
  bool trendingSearchLoading = false;

  setTextFieldLength(String? value){
    if(value == null){
      textFieldLength = 0;
    }else{
      textFieldLength = value!.length;
    }

    notifyListeners();
  }

  setMainSearchLoading(value){
    mainSearchLoading = value;
    notifyListeners();
  }

  setTrendingSearchLoading(value){
    trendingSearchLoading = value;
    notifyListeners();
  }

  setMainSearchData( ApiResponse<dynamic> response){
    print('working');
    mainSearchData = response;
    print("this is responsePassed ${response}");
    print("this is mainSearchData ${mainSearchData}");
    notifyListeners();
  }

  Future<void> getMainSearchData(dynamic data, dynamic headers) async{

    setMainSearchLoading(true);

    _mainSearchRepository.mainSearchApi(data, headers).then((value){

      mainSearchModel = value;

      print('this is future.wait value ${value}');

      setMainSearchLoading(false);
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setMainSearchLoading(false);

    });
  }

  Future<void> getTrendingSearchData(dynamic data, dynamic headers) async{

    setTrendingSearchLoading(true);

    _trendingSearchRepository.trendingSearchApi(data, headers).then((value){

      trendingSearchModel = value;

      print('this is future.wait value ${value}');

      setTrendingSearchLoading(false);
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setTrendingSearchLoading(false);

    });
  }
}