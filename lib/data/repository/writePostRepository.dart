import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/writePostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class WritePostRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  WritePostModelClass? writePostModel;

  Future<WritePostModelClass?> writePostApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.writePostUrl, data, headers);
      print("this is resposne ${response}");
      writePostModel = WritePostModelClass.fromJson(response);
      return writePostModel;
    }catch(e){
      throw(e);
    }
  }
}