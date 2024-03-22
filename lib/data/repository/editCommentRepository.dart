import 'package:lekhny/data/model/editCommentModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class EditCommentRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  EditCommentModelClass? editCommentModel;

  Future<EditCommentModelClass?> editCommentApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.editCommentUrl, data, headers);
      print("this is resposne ${response}");
      editCommentModel = EditCommentModelClass.fromJson(response);
      return editCommentModel;
    }catch(e){
      throw(e);
    }
  }
}