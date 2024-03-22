import 'package:lekhny/data/model/SixDayStreakModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class SixDayStreakRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  SixDayStreakModelClass? sixDayStreakModel;

  Future<dynamic?> sixDayStreakApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.sixDayStreakUrl}', data, headers);
      print("this is SixDayStreak resposne ${response}");
      sixDayStreakModel = SixDayStreakModelClass.fromJson(response);
      return response;
    }catch(e){
      print("this is SixDayStreak error $e");
      throw(e);
    }
  }
}