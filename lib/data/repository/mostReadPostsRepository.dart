import 'package:lekhny/data/model/mostReadPostModelClass.dart';
import 'package:lekhny/data/model/postCopyrightModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class MostReadPostsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  MostReadPostsModelClass? mostReadPostsModel;

  Future<MostReadPostsModelClass?> mostReadPostsApi(dynamic data, dynamic headers, page) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.mostReadPostsUrl}$page", data, headers);
      print("this is MostReadPosts resposne ${response}");
      mostReadPostsModel = MostReadPostsModelClass.fromJson(response);
      return mostReadPostsModel;
    }catch(e){
      print("this is MostReadPosts error $e");
      throw(e);
    }
  }
}