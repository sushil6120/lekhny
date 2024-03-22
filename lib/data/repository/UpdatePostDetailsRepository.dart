import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/updatePostDetailsModelClass.dart';
import 'package:lekhny/data/model/writePostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class UpdatePostDetailsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  UpdatePostDetailsModelClass? updatePostDetailsModel;

  Future<UpdatePostDetailsModelClass?> updatePostDetailsApi(dynamic data, dynamic headers, imageDataKey, image) async{
    try{

      dynamic response = await _apiServices.getPostMultipartResponse(AppUrl.updatePostDetailsUrl, data, imageDataKey, image, headers);
      print("this is resposne ${response}");
      updatePostDetailsModel = UpdatePostDetailsModelClass.fromJson(response);
      return updatePostDetailsModel;
    }catch(e){
      throw(e);
    }
  }
}