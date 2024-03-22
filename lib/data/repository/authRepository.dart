import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class AuthRepository{
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginByEmailApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      print("this is resposne ${response}");
      return response;

    }catch(e){
      throw e;
    }
  }

  Future<dynamic> SignUpEmailApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.signUpByEmailUrl, data);
      print("this is resposne ${response}");
      return response;

    }catch(e){
      throw e;
    }
  }

  Future<dynamic> SignUpGoogleApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.signUpByGoogleUrl, data);
      print("this is resposne ${response}");
      return response;

    }catch(e){
      throw e;
    }
  }

  Future<dynamic> loginGoogleApi(dynamic data)async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginByGoogleUrl, data);
      print("this is resposne ${response}");
      return response;

    }catch(e){
      throw e;
    }
  }

}