import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/mainSearchModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class MainSearchRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  MainSearchModelClass? mainSearchModel;

  Future<MainSearchModelClass?> mainSearchApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.mainSearchUrl, data, headers);
      print("this is resposne ${response}");
      mainSearchModel = MainSearchModelClass.fromJson(response);
      return mainSearchModel;
    }catch(e){
      throw(e);
    }
  }
}