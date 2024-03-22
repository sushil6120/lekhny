import 'package:lekhny/data/model/commentListModelClass.dart';
import 'package:lekhny/data/model/topPicksModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class CommentsListRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  CommentsListModelClass? commentListModel;

  Future<CommentsListModelClass?> commentListApi(dynamic data, dynamic headers, postId) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.commentListUrl}$postId", data, headers);
      print("this is resposne ${response}");
      commentListModel = CommentsListModelClass.fromJson(response);
      return commentListModel;

    }catch(e){
      throw(e);
    }
  }
}