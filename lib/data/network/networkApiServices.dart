import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:lekhny/data/network/baseApiServices.dart';
import 'package:lekhny/data/response/appExceptions.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url, data, [dynamic headers]) async{

    dynamic responseJason;

    try{
      final response  = await http.get(
          Uri.parse(url),
          headers: headers
      );
      responseJason = returnResponse(response);

    }catch(e){
      print("this is the biggest error $e ");
      throw FetchDataException('No Internet Connection');
    }

    return responseJason;
  }

  @override
  Future getPostApiResponse(String url, data, [dynamic headers])async {
    dynamic responseJason;

    try{
      Response response  = await post(
          Uri.parse(url),
          body: data,
          headers: headers
      );

      responseJason = returnResponse(response);

    }catch (e){
      Utils.toastMessage('No Internet Connection');
      throw FetchDataException('No Internet Connection');
    }

    return responseJason;
  }

  @override
  Future getPostMultipartResponse(String url, data, imageDataKey, image, [dynamic headers])async {
    dynamic responseJason;

    try{
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri);

      if (image != null){
        File file = File(image!.path);
        var stream = http.ByteStream(file.openRead());
        stream.cast();
        var length = await file.length();
        var multipart = http.MultipartFile(
            imageDataKey,
            stream,
            length,
            filename: file.path.split('/').last
        );
        request.files.add(multipart);
      }

        request.headers.addAll(headers);
        request.fields.addAll(data);

      Response response  = await http.Response.fromStream(await request.send());
      responseJason = returnResponse(response);
    }on SocketException{
      Utils.toastMessage('No Internet Connection');
      throw FetchDataException('No Internet Connection');
    }

    return responseJason;
  }

  dynamic returnResponse (http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJason = jsonDecode(response.body);
        return responseJason;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException('Error occured while communicating with server with status code${response.statusCode}');
    }
  }
}