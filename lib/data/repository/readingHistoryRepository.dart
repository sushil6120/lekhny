import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class ReadingHistoryRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  ReadingHistoryModelClass? readingHistoryModel;

  Future<ReadingHistoryModelClass?> readingHistoryApi(dynamic data, dynamic headers, page) async{

    try{

      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.readingHistoryUrl}$page", data, headers);
      print("this is ReadingHistory resposne ${response}");
      readingHistoryModel = ReadingHistoryModelClass.fromJson(response);
      return readingHistoryModel;

    }catch(e){
      print("this is ReadingHistory error $e");
      throw(e);
    }
  }
}