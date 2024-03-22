import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/forgetPasswordVerifyOtpModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class ForgetPasswordVerifyOtpRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  ForgetPasswordVerifyOtpModelClass? forgetPasswordVerifyOtpModel;

  Future<ForgetPasswordVerifyOtpModelClass?> forgetPasswordVerifyOtpApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.forgetPasswordVerifyOtpUrl, data, headers);
      print("this is resposne ${response}");
      forgetPasswordVerifyOtpModel = ForgetPasswordVerifyOtpModelClass.fromJson(response);
      return forgetPasswordVerifyOtpModel;
    }catch(e){
      throw(e);
    }
  }
}