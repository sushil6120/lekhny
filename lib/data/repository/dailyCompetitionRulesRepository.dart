import 'package:lekhny/data/model/dailyCompetitionRulesModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DailyCompetitionRulesRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DailyCompetitionRulesModelClass? dailyCompetitionRulesModel;

  Future<DailyCompetitionRulesModelClass?> dailyCompetitionRulesApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.dailyCompetitionRulesUrl, data, headers);
      print("this is resposne ${response}");
      dailyCompetitionRulesModel = DailyCompetitionRulesModelClass.fromJson(response);
      return dailyCompetitionRulesModel;
    }catch(e){
      throw(e);
    }
  }
}