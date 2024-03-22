import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/writerProfileDetailsModelClass.dart';
import 'package:lekhny/data/model/writerProfileDetailsModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class WriterProfileDetailsRepository{

  final BaseApiServices _apiServices = NetworkApiServices();
  WriterProfileDetailsModelClass? writerProfileDetailsModel;

  Future<WriterProfileDetailsModelClass?> writerProfileDetailsApi(String writerId, dynamic data, dynamic headers) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse('${AppUrl.writerProfileDetailsUrl}$writerId', data, headers);
      print("this is resposne ${response}");
      writerProfileDetailsModel = WriterProfileDetailsModelClass.fromJson(response);
      return writerProfileDetailsModel;
    }catch(e){
      throw(e);
    }
  }
}