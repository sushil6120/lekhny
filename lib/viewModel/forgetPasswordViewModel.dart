import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/changePasswordModelClass.dart';
import 'package:lekhny/data/model/verifyEmailModelClass.dart';
import 'package:lekhny/data/model/verifyEmailOtpModelClass.dart';
import 'package:lekhny/data/repository/changePasswordRepository.dart';
import 'package:lekhny/data/repository/forgetPasswordSendOtpRepository.dart';
import 'package:lekhny/data/repository/forgetPasswordVerifyOtpRepository.dart';
import 'package:lekhny/data/repository/verifyEmailOtpRepository.dart';
import 'package:lekhny/data/repository/verifyEmailRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class ForgetPasswordViewModel with ChangeNotifier{

 final _forgetPasswordSendOtpRepository = ForgetPasswordSendOtpRepository();
 final _forgetPasswordVerifyOtpRepository = ForgetPasswordVerifyOtpRepository();
 final _changePasswordRepository = ChangePasswordRepository();

 ChangePasswordModelClass? changePasswordModelClass;

  bool? loading = false;

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  Future<void> forgetPasswordSendOtpData(dynamic data, dynamic headers, BuildContext context,  String? email)async{
    setLoading(true);

    await _forgetPasswordSendOtpRepository.forgetPasswordSendOtpApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 200){
        // Utils.snackBar('${value.data}', context);
        Navigator.pushNamed(context, RoutesName.forgetPasswordEnterOtpScreen,
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

 Future<void> forgetPasswordVerifyOtpData(dynamic data, dynamic headers, BuildContext context)async{
   setLoading(true);

   await _forgetPasswordVerifyOtpRepository.forgetPasswordVerifyOtpApi(data, headers).then((value){

     setLoading(false);

     if(value!.status == 200){
       // Utils.snackBar('${value.data}', context);

     Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
     Utils.flushBarErrorMessage('Password changed successfully', context, Icons.done, primaryColor);

     }else{
       Navigator.pop(context);
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

 Future<void> changePassword(dynamic data, dynamic headers, BuildContext context)async{
   setLoading(true);

   await _changePasswordRepository.changePasswordApi(data, headers).then((value){

     setLoading(false);

     if(value!.status == 200){
       // Utils.snackBar('${value.data}', context);

       Navigator.pop(context);
       Utils.flushBarErrorMessage('Password changed successfully', context, Icons.done, primaryColor);

     }else{
       Navigator.pop(context);
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

  // Future<void> verifyEmailOtpData(dynamic data, dynamic headers, BuildContext context)async{
  //   setLoading(true);
  //
  //   await _verifyEmailOtpRepository.verifyEmailOtpApi(data, headers).then((value){
  //
  //     setLoading(false);
  //
  //     if(value!.status == 400){
  //       Utils.toastMessage("Your email has been verified.");
  //       Utils.flushBarErrorMessage("Your email has been verified.", context, Icons.done, primaryColor);
  //       Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen,
  //               (Route route) => route.isFirst
  //       );
  //
  //     }else{
  //       Utils.flushBarErrorMessage('${value!.data}', context, Icons.error_outline_rounded, colorLightWhite);
  //     }
  //
  //   }).onError((error, stackTrace){
  //     setLoading(false);
  //
  //     if(kDebugMode){
  //       print('error');
  //       print(error.toString());
  //     }
  //   });
  // }


}