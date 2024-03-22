import 'package:lekhny/data/model/pointsDeductedModelClass.dart';
import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PointsDeductedRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PointsDeductedModelClass? pointsDeductedModel;

  Future<PointsDeductedModelClass?> pointsDeductedApi(dynamic data, dynamic headers,page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.pointsDeductedUrl}${page}", data, headers);
      print("this is resposne ${response}");
      pointsDeductedModel = PointsDeductedModelClass.fromJson(response);
      return pointsDeductedModel;
    }catch(e){
      throw(e);
    }
  }
}