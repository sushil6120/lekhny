import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDataModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDataRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:html2md/html2md.dart' as html2md;

class PublishedSeriesAllPartsViewModel with ChangeNotifier{

  final _singleBookPartsRepository = SingleBookPartsRepository();
  final _singleBookDataRepository = SingleBookDataRepository();

  SingleBookPartsModelClass? singleBookPartsModel;
  SingleBookDataModelClass? singleBookDataModel;

  ApiResponse<dynamic> publishedSeriesAllPartsData = ApiResponse.loading();

  int? tappedIndex;
  bool singleBookDataLoading = false;

  setTappedIndex(value){
    tappedIndex = value;
  }

  setSingleBookDataLoading(value) {
    singleBookDataLoading = value;
    notifyListeners();
  }

  setPublishedSeriesAllPartsData( ApiResponse<dynamic> response){
    print('working');
    publishedSeriesAllPartsData = response;
    print("this is responsePassed ${response}");
    print("this is publishedSeriesAllPartsData ${publishedSeriesAllPartsData}");
    notifyListeners();
  }

  Future<void> getPublishedSeriesAllPartsData(String postId, dynamic data, dynamic headers) async{


    setPublishedSeriesAllPartsData(ApiResponse.loading());



      _singleBookPartsRepository.singleBookPartsApi(postId, data, headers).then((value){

      singleBookPartsModel = value;


      print('this is future.wait value ${value}');

      setPublishedSeriesAllPartsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setPublishedSeriesAllPartsData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> getSingleBookData(String postId, dynamic data, dynamic headers, BuildContext context) async{

    setSingleBookDataLoading(true);

    _singleBookDataRepository.singleBookDataApi(postId, data, headers).then((value){
      //singleBookDataModel = value;
      print("this is data ${value!.data![0].postData}");

      String? text;

      if(value!.data![0].postData == null){
        text = "";
      }else{
        String? text1 = value!.data![0].postData;
        String? text2 = text1;
        text = html2md.convert(text2!);
      }

      Navigator.pushNamed(context, RoutesName.textEditorScreen,
          arguments: {"postId" : "${postId}", "isContest" : '2', "contestId": null, "data" : text,"mainPostId": null }
      );

      setTappedIndex(null);

      print('this is future.wait value ${value}');

      setSingleBookDataLoading(false);
      print('apiresponse.completed working');

    }).onError((error, stackTrace){
      setTappedIndex(null);
      setSingleBookDataLoading(false);

    });
  }
}