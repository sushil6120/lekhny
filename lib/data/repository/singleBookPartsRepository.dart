import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class SingleBookPartsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  SingleBookPartsModelClass? singleBookPartsModel;

  Future<SingleBookPartsModelClass?> singleBookPartsApi(String postId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.singleBookPartsUrl}${postId}', data, headers);
      print("this is resposne ${response}");
      singleBookPartsModel = SingleBookPartsModelClass.fromJson(response);
      return singleBookPartsModel;
    }catch(e){
      throw(e);
    }
  }
}