import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/followUnfollowModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/model/verifyEmailOtpModelClass.dart';
import 'package:lekhny/data/repository/followUnfollowRepository.dart';
import 'package:lekhny/data/repository/forgetPasswordSendOtpRepository.dart';
import 'package:lekhny/data/repository/forgetPasswordVerifyOtpRepository.dart';
import 'package:lekhny/data/repository/verifyEmailOtpRepository.dart';
import 'package:lekhny/data/repository/verifyEmailRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class FollowUnfollowViewModel with ChangeNotifier{

  final _followUnfollowRepository = FollowUnfollowRepository();
  FollowUnfollowModelClass? followUnfollowModel;

  int? tappedIndex;
  bool? loading = false;
  String? followStatus;

  setTappedIndex(value){
    tappedIndex = value;
    notifyListeners();
  }
  setFollowStatus(value){
    followStatus = value;
    notifyListeners();
  }

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  Future<void> followUnfollowData(dynamic data, dynamic headers, BuildContext context)async{
    setLoading(true);

    await _followUnfollowRepository.followUnfollowApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 200){
        setFollowStatus(value.data!.data.toString());
        Utils.toastMessage("Followed Successfully");

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