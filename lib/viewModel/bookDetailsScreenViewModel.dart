import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/likePostModelClass.dart';
import 'package:lekhny/data/model/postLikesListModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/singleBookDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/likePostRepository.dart';
import 'package:lekhny/data/repository/postLikesListRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class BookDetailsScreenViewModel with ChangeNotifier{

  final _singleBookDetailsRepository = SingleBookDetailsRepository();
  final _singleBookPartsRepository = SingleBookPartsRepository();
  final _postLikesListRepository = PostLikesListRepository();
  final _likePostRepository = LikePostRepository();

  SingleBookDetailsModelClass? singleBookDetailsModel;
  SingleBookPartsModelClass? singleBookPartsModel;
  PostLikesListModelClass? postLikesListModelClass;
  LikePostModelClass? likePostModelClass;

  bool? likeLoading;
  int? isLiked;
  int? likeValue;

  ApiResponse<List<dynamic>> singleBookDetailsData = ApiResponse.loading();

  setLikeLoading(value){
    likeLoading = value;
    notifyListeners();
  }

  setIsLiked(value){
    isLiked = value;
    notifyListeners();
  }

  setLikeValue(value){
    likeValue = value;
    notifyListeners();
  }

  setSingleBookDetailsData( ApiResponse<List<dynamic>> response){
    print('working');
    singleBookDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is singleBookDetailsData ${singleBookDetailsData}");
    notifyListeners();
  }

  Future<void> getSingleBookDetailsData(String postId, dynamic data, dynamic headers) async{

    setSingleBookDetailsData(ApiResponse.loading());

    Future.wait([
      _singleBookDetailsRepository.singleBookDetailsApi(postId, data, headers),
      _singleBookPartsRepository.singleBookPartsApi(postId, data, headers),
      _postLikesListRepository.postLikesListApi(postId, data, headers)

    ]).then((value){

      singleBookDetailsModel = value[0] as SingleBookDetailsModelClass;
      singleBookPartsModel = value[1] as SingleBookPartsModelClass;
      postLikesListModelClass = value[2] as PostLikesListModelClass;

      if(postLikesListModelClass!.status == 200 ){
        isLiked = postLikesListModelClass!.data!.isAuthLike;
        likeValue = postLikesListModelClass!.data!.totalLike;
      }


      print('this is future.wait value ${value}');

      setSingleBookDetailsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setSingleBookDetailsData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> likePostData(String postId, dynamic data, dynamic headers) async{

    setLikeLoading(true);

    _likePostRepository.likePostApi(postId, data, headers).then((value){
      setLikeLoading(false);

      if(value!.status == 200){

        if(value!.data == "post like"){
          setIsLiked(1);
        }else{
          setIsLiked(0);
        }

        setLikeValue(value.totalLike);


      }

    }).onError((error, stackTrace){
      setLikeLoading(false);


    });

  }


}