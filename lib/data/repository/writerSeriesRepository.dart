import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/writerSeriesModelClass.dart';
import 'package:lekhny/data/model/writerSeriesModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class WriterSeriesRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  WriterSeriesModelClass? writerSeriesModel;

  Future<WriterSeriesModelClass?> writerSeriesApi(String writerId, page, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.writerSeriesUrl}$writerId&pageId=$page', data, headers);
      print("this is resposne ${response}");
      writerSeriesModel = WriterSeriesModelClass.fromJson(response);
      return writerSeriesModel;
    }catch(e){
      throw(e);
    }
  }
}