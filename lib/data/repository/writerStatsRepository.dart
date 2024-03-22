import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/writerStatsModelClass.dart';
import 'package:lekhny/data/model/writerStatsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class WriterStatsRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  WriterStatsModelClass? writerStatsModel;

  Future<WriterStatsModelClass?> writerStatsApi(String writerId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getGetApiResponse('${AppUrl.writerStatsUrl}$writerId', data, headers);
      print("this is resposne ${response}");
      writerStatsModel = WriterStatsModelClass.fromJson(response);
      return writerStatsModel;
    }catch(e){
      throw(e);
    }
  }
}