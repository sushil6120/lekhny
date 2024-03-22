import 'package:lekhny/data/model/draftsModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DraftsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DraftsModelClass? draftsModel;

  Future<DraftsModelClass?> draftsApi(dynamic data, dynamic headers) async{

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.draftsUrl, data, headers);
      print("this is resposne ${response}");
      draftsModel = DraftsModelClass.fromJson(response);
      return draftsModel;

    }catch(e){
      throw(e);
    }
  }
}