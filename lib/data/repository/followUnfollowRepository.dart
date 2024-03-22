import 'package:lekhny/data/model/followUnfollowModelClass.dart';
import 'package:lekhny/data/model/followUnfollowModelClass.dart';
import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class FollowUnfollowRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  FollowUnfollowModelClass? followUnfollowModel;

  Future<FollowUnfollowModelClass?> followUnfollowApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.followUnfollowUrl}", data, headers);
      print("this is resposne ${response}");
      followUnfollowModel = FollowUnfollowModelClass.fromJson(response);
      return followUnfollowModel;
    }catch(e){
      throw(e);
    }
  }
}