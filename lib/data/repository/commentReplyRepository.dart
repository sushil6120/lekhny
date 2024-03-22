import 'package:lekhny/data/model/commentReplyModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class CommentReplyRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  CommentReplyModelClass? commentReplyModel;

  Future<CommentReplyModelClass?> commentReplyApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.commentReplyUrl, data, headers);
      print("this is resposne ${response}");
      commentReplyModel = CommentReplyModelClass.fromJson(response);
      return commentReplyModel;
    }catch(e){
      throw(e);
    }
  }
}