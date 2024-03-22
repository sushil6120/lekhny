import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/monthlyCompetitionResultModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class MonthlyCompetitionResultRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  MonthlyCompetitionResultModelClass? monthlyCompetitionResultModel;

  Future<MonthlyCompetitionResultModelClass?> monthlyCompetitonResultApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.monthlyCompetitionResultUrl, data, headers);
      print("this is resposne ${response}");
      monthlyCompetitionResultModel = MonthlyCompetitionResultModelClass.fromJson(response);
      return monthlyCompetitionResultModel;
    }catch(e){
      throw(e);
    }
  }
}