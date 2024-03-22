import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/subCategoryModelClass.dart';
import 'package:lekhny/data/model/unPublishedPostModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class UnPublishedPostRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  UnPublishedPostModelClass? unPublishedPostModel;

  Future<UnPublishedPostModelClass?> unPublishedPostsApi(dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.unPublishedPostsUrl, data, headers);
      print("this is resposne ${response}");
      unPublishedPostModel = UnPublishedPostModelClass.fromJson(response);
      return unPublishedPostModel;
    }catch(e){
      throw(e);
    }
  }
}