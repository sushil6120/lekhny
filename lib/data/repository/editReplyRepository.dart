import 'package:lekhny/data/model/editReplyModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class EditReplyRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  EditReplyModelClass? editReplyModel;

  Future<EditReplyModelClass?> editReplyApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.editReplyUrl, data, headers);
      print("this is resposne ${response}");
      editReplyModel = EditReplyModelClass.fromJson(response);
      return editReplyModel;
    }catch(e){
      throw(e);
    }
  }
}