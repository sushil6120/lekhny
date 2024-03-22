import 'package:lekhny/data/model/pointsDeductedModelClass.dart';
import 'package:lekhny/data/model/pointsEarnedModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/postsByCategoryModelClass.dart';
import 'package:lekhny/data/model/redeemedPointsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class RedeemedPointsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  RedeemedPointsModelClass? redeemedPointsModel;

  Future<RedeemedPointsModelClass?> redeemedPointsApi(dynamic data, dynamic headers, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.redeemedPointsUrl}${page}", data, headers);
      print("this is resposne ${response}");
      redeemedPointsModel = RedeemedPointsModelClass.fromJson(response);
      return redeemedPointsModel;
    }catch(e){
      throw(e);
    }
  }
}