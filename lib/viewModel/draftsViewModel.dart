import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/draftsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/draftsRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class DraftsViewModel with ChangeNotifier{

  final _draftsRepository = DraftsRepository();

  DraftsModelClass? draftsModel;

  ApiResponse<dynamic> draftsData = ApiResponse.loading();

  setDraftsData( ApiResponse<dynamic> response){
    print('working');
    draftsData = response;
    print("this is responsePassed ${response}");
    print("this is draftsData ${draftsData}");
    notifyListeners();
  }

  Future<void> getDraftsData(dynamic data, dynamic headers) async{

    setDraftsData(ApiResponse.loading());
      _draftsRepository.draftsApi(data, headers).then((value){

      draftsModel = value;
      print('this is future.wait value ${value}');
      setDraftsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setDraftsData(ApiResponse.error(error.toString()));

    });
  }
}