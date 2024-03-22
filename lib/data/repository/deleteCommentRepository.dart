import 'package:lekhny/data/model/deleteCommentModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DeleteCommentRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DeleteCommentModelClass? deleteCommentModel;

  Future<DeleteCommentModelClass?> deleteCommentApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.deleteCommentUrl, data, headers);
      print("this is resposne ${response}");
      deleteCommentModel = DeleteCommentModelClass.fromJson(response);
      return deleteCommentModel;
    }catch(e){
      throw(e);
    }
  }
}