import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/redeemPointsModelClass.dart';
import 'package:lekhny/data/model/updatePostDetailsModelClass.dart';
import 'package:lekhny/data/model/writePostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class RedeemPointsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  RedeemPointsModelClass? redeemPointsModel;

  Future<RedeemPointsModelClass?> redeemPointsApi(dynamic data, dynamic headers, imageDataKey, image) async{
    try{
      dynamic response = await _apiServices.getPostMultipartResponse(AppUrl.redeemPointsUrl, data, imageDataKey, image, headers);
      print("this is resposne ${response}");
      redeemPointsModel = RedeemPointsModelClass.fromJson(response);
      return redeemPointsModel;
    }catch(e){
      throw(e);
    }
  }
}