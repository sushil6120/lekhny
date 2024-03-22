import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PointsEarnedRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PointsEarnedModelClass? pointsEarnedModel;

  Future<PointsEarnedModelClass?> pointsEarnedApi(dynamic data, dynamic headers, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.pointsEarnedUrl}${page}", data, headers);
      print("this is resposne ${response}");
      pointsEarnedModel = PointsEarnedModelClass.fromJson(response);
      return pointsEarnedModel;
    }catch(e){
      throw(e);
    }
  }
}