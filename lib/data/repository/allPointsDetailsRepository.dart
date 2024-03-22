import 'package:lekhny/data/model/allPointsDetailsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class AllPointsDetailsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  AllPointsDetailsModelClass? allPointsDetailsModel;

  Future<AllPointsDetailsModelClass?> allPointsDetailsApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.allPointsDetaislUrl, data, headers);
      print("this is resposne ${response}");
      allPointsDetailsModel = AllPointsDetailsModelClass.fromJson(response);
      return allPointsDetailsModel;

    }catch(e){
      throw(e);
    }
  }
}