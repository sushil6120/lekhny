import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/upcomingBookDetailsModelClass.dart';
import 'package:lekhny/data/model/upcomingBookDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class UpcomingBookDetailsRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  UpcomingBookDetailsModelClass? upcomingBookDetailsModel;

  Future<UpcomingBookDetailsModelClass?> upcomingBookDetailsApi(String bookId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.upcomingBookDetailsUrl}$bookId', data, headers);
      print("this is resposne ${response}");
      upcomingBookDetailsModel = UpcomingBookDetailsModelClass.fromJson(response);
      return upcomingBookDetailsModel;
    }catch(e){
      throw(e);
    }
  }
}