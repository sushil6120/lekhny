abstract class BaseApiServices{

  Future<dynamic> getGetApiResponse(String url, data, [dynamic headers]);

  Future<dynamic> getPostApiResponse(String url, data, [dynamic headers]);

  Future<dynamic> getPostMultipartResponse(String url, data,imageDataKey, image, [dynamic headers]);

}