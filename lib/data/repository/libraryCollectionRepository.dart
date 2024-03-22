import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/libraryCollectionModelClass.dart';
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/network/networkApiServices.dart';
import 'package:lekhny/utils/appUrl.dart';

class LibraryCollectionRepository{

  BaseApiServices _apiServices = NetworkApiServices();
  LibraryCollectionModelClass? libraryCollectionModel;

  Future<LibraryCollectionModelClass?> libraryCollectionApi(dynamic data, dynamic headers, String? authId) async{

    try{
      dynamic response = await _apiServices.getPostApiResponse("${AppUrl.libraryCollectionUrl}${authId}", data, headers);
      print("this is resposne ${response}");
      libraryCollectionModel = LibraryCollectionModelClass.fromJson(response);
      return libraryCollectionModel;
    }catch(e){
      throw(e);
    }
  }
}