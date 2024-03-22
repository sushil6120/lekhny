import 'package:lekhny/data/model/publishedPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class PublishedPostRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  PublishedPostModelClass? publishedPostModel;

  Future<PublishedPostModelClass?> publishedPostsApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.publishedPostUrl, data, headers);
      print("this is resposne ${response}");
      publishedPostModel = PublishedPostModelClass.fromJson(response);
      return publishedPostModel;
    }catch(e){
      throw(e);
    }
  }
}