import 'package:lekhny/data/model/dailyCompetitionTopicPostsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class DailyCompetitionTopicPostsRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  DailyCompetitionTopicPostsModelClass? dailyCompetitonTopicPostsModel;

  Future<DailyCompetitionTopicPostsModelClass?> dailyCompetitonTopicPostsApi(dynamic data, dynamic headers, topicId, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.dailyCompetitionTopicPostsUrl}$topicId&postPageId=$page", data, headers);
      print("this is resposne ${response}");
      dailyCompetitonTopicPostsModel = DailyCompetitionTopicPostsModelClass.fromJson(response);
      return dailyCompetitonTopicPostsModel;

    }catch(e){
      throw(e);
    }
  }
}