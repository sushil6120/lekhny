import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class TopPicksRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  TopPicksModelClass? topPicksModel;

  Future<TopPicksModelClass?> topPicksApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.topPicksUrl}$page", data, headers);
      print("this is TopPicks resposne ${response}");
      topPicksModel = TopPicksModelClass.fromJson(response);
      return topPicksModel;

    }catch(e){
      print("this is TopPicks error ${e}");
      throw(e);
    }
  }
}