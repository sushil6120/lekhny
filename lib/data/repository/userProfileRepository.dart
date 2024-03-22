import 'package:lekhny/data/model/userProfileModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class UserProfileRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  UserProfileModelClass? userProfileModel;

  Future<UserProfileModelClass?> userProfileApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.userProfileUrl, data, headers);
      print("this is UserProfile resposne ${response}");
      userProfileModel = UserProfileModelClass.fromJson(response);
      return userProfileModel;
    }catch(e){
      print("this is UserProfile error $e");
      throw(e);
    }
  }
}