import 'package:lekhny/data/model/publishedPostModelClass.dart';
import 'package:lekhny/data/model/publishedSeriesModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PublishedSeriesRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PublishedSeriesModelClass? publishedSeriesModel;

  Future<PublishedSeriesModelClass?> publishedSeriesApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.publishedSeriesUrl, data, headers);
      print("this is resposne ${response}");
      publishedSeriesModel = PublishedSeriesModelClass.fromJson(response);
      return publishedSeriesModel;
    }catch(e){
      throw(e);
    }
  }
}