import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class VerifyEmailRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  VerifyEmailModelClass? verifyEmailModel;

  Future<VerifyEmailModelClass?> verifyEmailApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.verifyEmailUrl, data, headers);
      print("this is resposne ${response}");
      verifyEmailModel = VerifyEmailModelClass.fromJson(response);
      return verifyEmailModel;
    }catch(e){
      throw(e);
    }
  }
}