import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/forgetPasswordSendOtpModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class ForgetPasswordSendOtpRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  ForgetPasswordSendOtpModelClass? forgetPasswordSendOtpModel;

  Future<ForgetPasswordSendOtpModelClass?> forgetPasswordSendOtpApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.forgetPasswordSendOtpUrl, data, headers);
      print("this is resposne ${response}");
      forgetPasswordSendOtpModel = ForgetPasswordSendOtpModelClass.fromJson(response);
      return forgetPasswordSendOtpModel;
    }catch(e){
      throw(e);
    }
  }
}