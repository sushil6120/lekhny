import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/signUpByEmailModelClass.dart';
import 'package:lekhny/data/repository/authRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lekhny/services/authServices/signUpWithGoogle.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  //UserModel userModel = UserModel();
  SignUpByEmailModelClass? signUpByEmailModelClass;

  bool _loading= false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  String? language;

  setLanguage(value){
    language = value;
    notifyListeners();
  }

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUpLoading = value;
    notifyListeners();
  }


  Future<void> loginByEmail(dynamic data, BuildContext context)async{

    final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);

    setLoading(true);

    _myRepo.loginByEmailApi(data).then((value){
      print(value);
      setLoading(false);

      if(value["status"] == 200){
        // Utils.snackBar('${value["data"]}', context);
        sharedPreferencesViewModel.saveToken(value["data"]["lekhnyToken"]);
        print('token ${value["data"]["lekhnyToken"]}');
        Navigator.pushNamed(context, RoutesName.bottomNavigationBarScreen);
      }
      else if(value["status"] == 305){
      Utils.flushBarErrorMessage('${value["data"]}', context, Icons.error_outline_rounded, colorLightWhite );
      }

      if(kDebugMode){
        print('value');
        print(value.toString());
      }
    }
    ).onError((error, stackTrace){
      setLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }
    });
  }

  Future<void> signUpByEmail(dynamic data, BuildContext context, String? email)async{

    final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);
    setSignUpLoading(true);
    _myRepo.SignUpEmailApi(data).then((value){
      setSignUpLoading(false);
      if(value["status"] == 305){
        Utils.flushBarErrorMessage('${value["data"]}', context, Icons.error_outline_rounded, colorLightWhite);

      }else if(value["status"] == 200){
        sharedPreferencesViewModel.saveToken(value["data"]["lekhnyToken"]);
        print('token ${value["data"]["lekhnyToken"]}');
        // Navigator.pushNamed(context, RoutesName.verifyEmailOTPScreen,
        //     arguments: {"email" : "${email}" }
        // );
        Navigator.pushNamedAndRemoveUntil(context,RoutesName.signupVerifyOTPScreen,
            arguments: {"email" : "$email" } , (route) => false);
      }

      if(kDebugMode){
        print('value');
        print(value.toString());
      }

    }).onError((error, stackTrace){
      setSignUpLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }

    });

  }

  Future<void> signUpByGoogle(dynamic data, BuildContext context)async{
    final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);
    setSignUpLoading(true);
    _myRepo.SignUpGoogleApi(data).then((value){
      setSignUpLoading(false);
      if(value["status"] == 305){
        SignUpWithGoogle().signOut();
        Utils.flushBarErrorMessage('${value["data"]}', context, Icons.error_outline_rounded, colorLightWhite);

      }else if(value["status"] == 200){
        sharedPreferencesViewModel.saveToken(value["data"]["lekhnyToken"]);
        print('token ${value["data"]["lekhnyToken"]}');
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.chooseLanguageScreen, (route) => false);
      }

      if(kDebugMode){
        print('value');
        print(value.toString());
      }

    }).onError((error, stackTrace){
      setSignUpLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }

    });

  }

  Future<void> loginByGoogle(dynamic data, BuildContext context)async{
    final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);
    setLoading(true);
    _myRepo.loginGoogleApi(data).then((value){
      setLoading(false);
      if(value["status"] == 305){
        SignUpWithGoogle().signOut();
        Utils.flushBarErrorMessage('${value["data"]}', context, Icons.error_outline_rounded, colorLightWhite);

      }else if(value["status"] == 200){
        sharedPreferencesViewModel.saveToken(value["data"]["lekhnyToken"]);
        print('token ${value["data"]["lekhnyToken"]}');
        Navigator.pushNamed(context, RoutesName.bottomNavigationBarScreen);
      }

      if(kDebugMode){
        print('value');
        print(value.toString());
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