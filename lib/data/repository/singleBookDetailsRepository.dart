import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class SingleBookDetailsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  SingleBookDetailsModelClass? singleBookDetailsModel;

  Future<SingleBookDetailsModelClass?> singleBookDetailsApi(String postId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.singleBookDetailsUrl}${postId}', data, headers);
      print("this is resposne ${response}");
      singleBookDetailsModel = SingleBookDetailsModelClass.fromJson(response);
      return singleBookDetailsModel;
    }catch(e){
      throw(e);
    }
  }
}