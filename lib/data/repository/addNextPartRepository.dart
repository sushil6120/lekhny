import 'package:lekhny/data/model/addNextPartModelClass.dart';
import 'package:lekhny/data/model/addNextPartModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class AddNextPartRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  AddNextPartModelClass? addNextPartModel;

  Future<AddNextPartModelClass?> addNextPartApi(dynamic data, dynamic headers) async{
    try{

      dynamic response = await _apiServices.getPostApiResponse(AppUrl.addNextPartUrl, data, headers);
      print("this is resposne ${response}");
      addNextPartModel = AddNextPartModelClass.fromJson(response);
      return addNextPartModel;
    }catch(e){
      throw(e);
    }
  }
}