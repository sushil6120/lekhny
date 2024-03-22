import 'package:flutter/cupertino.dart';
import 'package:lekhny/data/model/SingleBookPartsModelClass.dart';
import 'package:lekhny/data/model/libraryCollectionModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/userProfileModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/repository/libraryCollectionRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/repository/userProfileRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';

class ProfileViewModel with ChangeNotifier{

  final _userProfileRepsitory = UserProfileRepository();
  final _libraryCollectionRepository = LibraryCollectionRepository();

  UserProfileModelClass? userProfileModel;
  LibraryCollectionModelClass? libraryCollectionModel;

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  ApiResponse<dynamic> profileData = ApiResponse.loading();

  setProfileData( ApiResponse<dynamic> response){
    print('working');
    profileData = response;
    print("this is responsePassed ${response}");
    print("this is profileData ${profileData}");
    notifyListeners();
  }

  Future<void> getProfileData(dynamic headers, dynamic headers2) async{


    setProfileData(ApiResponse.loading());

    Future.wait([
      _userProfileRepsitory.userProfileApi(null, headers)

    ]).then((value){

      userProfileModel = value[0] as UserProfileModelClass;

      sharedPreferencesViewModel.saveUserId("${userProfileModel!.data![0].userID}");
      sharedPreferencesViewModel.saveProfilePic("${userProfileModel!.data![0].profile}");


      _libraryCollectionRepository.libraryCollectionApi(null, headers2, "${userProfileModel!.data![0].userID}").then((value){
        libraryCollectionModel = value;
        setProfileData(ApiResponse.completed(value));
      });


      print('this is future.wait value ${value}');


      //print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setProfileData(ApiResponse.error(error.toString()));

    });
  }


}