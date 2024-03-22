import 'package:lekhny/data/model/pastDailyTopicsModelClass.dart';
import 'package:lekhny/data/model/pastDailyTopicsModelClass.dart';
import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PastDailyTopicsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PastDailyTopicsModelClass? pastDailyTopicsModel;

  Future<PastDailyTopicsModelClass?> pastDailyTopicsApi(dynamic data, dynamic headers, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.pastDailyTopicsUrl}$page", data, headers);
      print("this is PastDailyTopics resposne ${response}");
      pastDailyTopicsModel = PastDailyTopicsModelClass.fromJson(response);
      return pastDailyTopicsModel;
    }catch(e){
      print("this is PastDailyTopics error $e");
      throw(e);
    }
  }
}