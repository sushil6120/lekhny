import 'package:lekhny/data/model/changePasswordModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class ChangePasswordRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  ChangePasswordModelClass? changePasswordModel;

  Future<ChangePasswordModelClass?> changePasswordApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.changePasswordUrl, data, headers);
      print("this is resposne ${response}");
      changePasswordModel = ChangePasswordModelClass.fromJson(response);
      return changePasswordModel;

    }catch(e){
      throw(e);
    }
  }
}