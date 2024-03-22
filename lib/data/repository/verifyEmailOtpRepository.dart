import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/model/verifyEmailOtpModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class VerifyEmailOtpRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  VerifyEmailOtpModelClass? verifyEmailOtpModel;

  Future<VerifyEmailOtpModelClass?> verifyEmailOtpApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.verifyEmailOTPUrl, data, headers);
      print("this is resposne ${response}");
      verifyEmailOtpModel = VerifyEmailOtpModelClass.fromJson(response);
      return verifyEmailOtpModel;
    }catch(e){
      throw(e);
    }
  }
}