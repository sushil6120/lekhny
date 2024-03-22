import 'package:lekhny/data/model/deleteReplyModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DeleteReplyRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DeleteReplyModelClass? deleteReplyModel;

  Future<DeleteReplyModelClass?> deleteReplyApi(dynamic data, dynamic headers) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.deleteReplyUrl, data, headers);
      print("this is resposne ${response}");
      deleteReplyModel = DeleteReplyModelClass.fromJson(response);
      return deleteReplyModel;
    }catch(e){
      throw(e);
    }
  }
}