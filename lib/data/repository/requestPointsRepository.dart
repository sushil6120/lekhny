import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/requestPointsModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/model/verifyEmailOtpModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class RequestPointsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  RequestPointsModelClass? requestPointsModel;

  Future<RequestPointsModelClass?> requestPointsApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.requestPointsUrl, data, headers);
      print("this is resposne ${response}");
      requestPointsModel = RequestPointsModelClass.fromJson(response);
      return requestPointsModel;
    }catch(e){
      throw(e);
    }
  }
}