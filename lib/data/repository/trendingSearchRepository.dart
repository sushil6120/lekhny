import 'package:lekhny/data/model/trendingSearchModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class TrendingSearchRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  TrendingSearchModelClass? trendingSearchModel;

  Future<TrendingSearchModelClass?> trendingSearchApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.trendingSearchUrl, data, headers);
      print("this is resposne ${response}");
      trendingSearchModel = TrendingSearchModelClass.fromJson(response);
      return trendingSearchModel;

    }catch(e){
      throw(e);
    }
  }
}