import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/upcomingBookModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class UpcomingBookRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  UpcomingBookModelClass? upcomingBookModel;

  Future<UpcomingBookModelClass?> upcomingBookApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.upcomingBookUrl, data, headers);
      print("this is UpcomingBook resposne ${response}");
      upcomingBookModel = UpcomingBookModelClass.fromJson(response);
      return upcomingBookModel;

    }catch(e){
      print("this is UpcomingBook error $e");
      throw(e);
    }
  }
}