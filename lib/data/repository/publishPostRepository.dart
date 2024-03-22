import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/publishPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/updatePostDetailsModelClass.dart';
import 'package:lekhny/data/model/writePostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PublishPostRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PublishPostModelClass? publishPostModel;

  Future<PublishPostModelClass?> publishPostApi(dynamic data, dynamic headers) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.publishPostUrl, data, headers);
      print("this is resposne ${response}");
      publishPostModel = PublishPostModelClass.fromJson(response);
      return publishPostModel;
    }catch(e){
      throw(e);
    }
  }
}