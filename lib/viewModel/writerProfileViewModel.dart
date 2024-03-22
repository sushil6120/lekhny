import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lekhny/data/model/followUnfollowModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/writerProfileDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/writerProfileDetailsModelClass.dart';
import 'package:lekhny/data/model/writerStatsModelClass.dart';
import 'package:lekhny/data/repository/followUnfollowRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/writerProfileDetailsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/writerProfileDetailsRepository.dart';
import 'package:lekhny/data/repository/writerProfileDetailsRepository.dart';
import 'package:lekhny/data/repository/writerStatsRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class WriterProfileViewModel with ChangeNotifier{

  final _writerProfileDetailsRepository = WriterProfileDetailsRepository();
  final _writerStatsRepository = WriterStatsRepository();
  final _followUnfollowRepository = FollowUnfollowRepository();

  WriterProfileDetailsModelClass? writerProfileDetailsModel;
  WriterStatsModelClass? writerStatsModel;
  FollowUnfollowModelClass? followUnfollowModel;

  ApiResponse<List<dynamic>> writerProfileDetailsData = ApiResponse.loading();

  int? isFollowing;
  bool? loading = false;

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  setIsFollowing(value){
    isFollowing = value;
    notifyListeners();
  }

  setWriterProfileDetailsData( ApiResponse<List<dynamic>> response){
    print('working');
    writerProfileDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is writerProfileDetailsData ${writerProfileDetailsData}");
    notifyListeners();
  }

  Future<void> getWriterProfileDetailsData(String writerId, dynamic data, dynamic headers) async{

    setWriterProfileDetailsData(ApiResponse.loading());

    Future.wait([
      _writerProfileDetailsRepository.writerProfileDetailsApi(writerId, data, headers),
      _writerStatsRepository.writerStatsApi(writerId, data, headers),

    ]).then((value){
      writerProfileDetailsModel = value[0] as WriterProfileDetailsModelClass;
      writerStatsModel = value[1] as WriterStatsModelClass;

      if(writerProfileDetailsModel!.status == 200){
        isFollowing = writerProfileDetailsModel!.data!.userIsFollowing;
      }

      print('this is future.wait value ${value}');
      setWriterProfileDetailsData(ApiResponse.completed(value));
      //print('apiresponse.completed working');
    }).onError((error, stackTrace){
      setWriterProfileDetailsData(ApiResponse.error(error.toString()));
    });
  }

  Future<void> followUnfollowData(dynamic data, dynamic headers, BuildContext context)async{
    setLoading(true);

    await _followUnfollowRepository.followUnfollowApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 200){

        print("this is value.data!.data.toString() ${value.data!.data.toString()}");
        if( value.data!.data.toString() == "follow"){
          setIsFollowing(0);
        }else{
          setIsFollowing(1);
        }
      }else{
        Utils.toastMessage("An error has occured.");
      }


    }).onError((error, stackTrace){
      setLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }
    });
  }
}