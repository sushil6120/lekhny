import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class TopSeriesRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  TopSeriesModelClass? topSeriesModel;

  Future<TopSeriesModelClass?> topSeriesApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.topSeriesUrl}$page", data, headers);
      print("this is TopSeries resposne ${response}");
      topSeriesModel = TopSeriesModelClass.fromJson(response);
      return topSeriesModel;

    }catch(e){
      print("this is TopSeries error ${e}");
      throw(e);
    }
  }
}