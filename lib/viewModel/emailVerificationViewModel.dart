import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/model/verifyEmailOtpModelClass.dart';
import 'package:lekhny/data/repository/verifyEmailOtpRepository.dart';
import 'package:lekhny/data/repository/verifyEmailRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class EmailVerificationViewModel with ChangeNotifier{

  final _verifyEmailRepository = VerifyEmailRepository();
  final _verifyEmailOtpRepository = VerifyEmailOtpRepository();

  VerifyEmailModelClass? verifyEmailModel;
  VerifyEmailOtpModelClass? verifyEmailOtpModel;

  bool? loading = false;

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  Future<void> verifyEmailData(dynamic data, dynamic headers, BuildContext context,  String? email)async{
    setLoading(true);

    await _verifyEmailRepository.verifyEmailApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 200){
        // Utils.snackBar('${value.data}', context);
        Navigator.pushNamed(context, RoutesName.verifyEmailOTPScreen,
            arguments: {"email" : "${email}" }
        );

      }else{
        Utils.flushBarErrorMessage('${value!.data}', context, Icons.error_outline_rounded, colorLightWhite);
      }


    }).onError((error, stackTrace){
      setLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }
    });
  }

  Future<void> verifyEmailOtpData(dynamic data, dynamic headers, BuildContext context)async{
    setLoading(true);

    await _verifyEmailOtpRepository.verifyEmailOtpApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 400){
        //Utils.toastMessage("Your email has been verified.");
        //Utils.flushBarErrorMessage("Your email has been verified.", context, Icons.done, primaryColor);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.chooseLanguageScreen, (route) => false);
        // Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen,
        //         (Route route) => route.isFirst
        // );

      }else{
        Utils.flushBarErrorMessage('${value!.data}', context, Icons.error_outline_rounded, colorLightWhite);
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