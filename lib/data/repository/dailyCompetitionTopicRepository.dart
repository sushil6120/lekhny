import 'package:lekhny/data/model/dailyCompetitonTopicModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DailyCompetitionTopicRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DailyCompetitionTopicModelClass? dailyCompetitonTopicModel;

  Future<DailyCompetitionTopicModelClass?> dailyCompetitonTopicApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.dailyCompetitonTopicUrl, data, headers);
      print("this is resposne ${response}");
      dailyCompetitonTopicModel = DailyCompetitionTopicModelClass.fromJson(response);
      return dailyCompetitonTopicModel;

    }catch(e){
      throw(e);
    }
  }
}