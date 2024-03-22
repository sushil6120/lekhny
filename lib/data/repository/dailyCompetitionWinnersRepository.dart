import 'package:lekhny/data/model/dailyCompetitonWinnersModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/libraryCollectionModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DailyCompetitionWinnersRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DailyCompetitionWinnersModelClass? dailyCompetitionWinnersModel;

  Future<DailyCompetitionWinnersModelClass?> dailyCompetitionWinnersApi(dynamic data, dynamic headers, String? day) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.dailyCompetitionWinnersUrl}${day}", data, headers);
      print("this is DailyCompetitionWinners resposne ${response}");
      dailyCompetitionWinnersModel = DailyCompetitionWinnersModelClass.fromJson(response);
      return dailyCompetitionWinnersModel;
    }catch(e){
      print("this is DailyCompetitionWinners error $e");
      throw(e);
    }
  }
}