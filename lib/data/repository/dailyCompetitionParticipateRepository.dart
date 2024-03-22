import 'package:lekhny/data/model/dailyCompetitionParticipateModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/libraryCollectionModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DailyCompetitionParticipateRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DailyCompetitionParticipateModelClass? dailyCompetitionParticipateModel;

  Future<DailyCompetitionParticipateModelClass?> dailyCompetitionParticipateApi(dynamic data, dynamic headers, String? contestId) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.dailyCompetitionParticipateUrl}${contestId}", data, headers);
      print("this is resposne ${response}");
      dailyCompetitionParticipateModel = DailyCompetitionParticipateModelClass.fromJson(response);
      return dailyCompetitionParticipateModel;
    }catch(e){
      throw(e);
    }
  }
}