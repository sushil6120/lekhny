import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class AddNewPostRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  AddNewPostModelClass? addNewPostModel;

  Future<AddNewPostModelClass?> addNewPostApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addNewPostUrl, data, headers);
      print("this is resposne ${response}");
      addNewPostModel = AddNewPostModelClass.fromJson(response);
      return addNewPostModel;
    }catch(e){
      throw(e);
    }
  }
}