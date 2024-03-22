import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDataModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class SingleBookDataRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  SingleBookDataModelClass? singleBookDataModel;

  Future<SingleBookDataModelClass?> singleBookDataApi(String postId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.singleBookDataUrl}${postId}', data, headers);
      print("this is resposne ${response}");
      singleBookDataModel = SingleBookDataModelClass.fromJson(response);
      return singleBookDataModel;
    }catch(e){
      throw(e);
    }
  }
}