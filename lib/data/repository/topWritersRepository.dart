import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topWritersModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class TopWritersRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  TopWritersModelClass? topWritersModel;

  Future<TopWritersModelClass?> topWritersApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.topWritersUrl, data, headers);
      print("this is TopWriters resposne ${response}");
      topWritersModel = TopWritersModelClass.fromJson(response);
      return topWritersModel;

    }catch(e){
      print("this is TopWriters error $e");
      throw(e);
    }
  }
}