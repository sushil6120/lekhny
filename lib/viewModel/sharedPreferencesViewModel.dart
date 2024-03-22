import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesViewModel with ChangeNotifier{

  saveIsInstalled(bool? isInstalled)async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setBool('isInstalled', isInstalled!);
    notifyListeners();
  }

  Future<bool?> getIsInstalled()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    final bool? isInstalled = sp.getBool('isInstalled');
    return isInstalled;
  }

  saveToken(String? token)async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString('token', token!);
    notifyListeners();
  }

  saveUserId(String? userId)async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString('userId', userId!);
    notifyListeners();
  }

  saveProfilePic(String? profilePic)async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString('profilePic', profilePic!);
    notifyListeners();
  }

  Future<String?> getToken()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    return token;
  }

  Future<String?> getUserId()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    final String? userId = sp.getString('userId');
    return userId;
  }

  Future<String?> getProfilePic()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    final String? profilePic = sp.getString('profilePic');
    return profilePic;
  }

  saveLanguage(String? language)async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    sp.setString('language', language!);
    notifyListeners();
  }

  Future<String?> getLanguage()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    final String? language = sp.getString('language');
    return language;
  }

  Future<bool> remove()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    return sp.clear();
  }

  Future<bool> removeToken()async{
    final SharedPreferences sp =  await SharedPreferences.getInstance();
    return sp.remove("token");
  }

}