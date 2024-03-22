import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lekhny/data/model/addNewPostModelClass.dart';
import 'package:lekhny/data/model/addNextPartModelClass.dart';
import 'package:lekhny/data/model/writePostModelClass.dart';
import 'package:lekhny/data/repository/addNewPostRepository.dart';
import 'package:lekhny/data/repository/addNextPartRepository.dart';
import 'package:lekhny/data/repository/writePostRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class TextEditorScreenViewModel with ChangeNotifier{
  
  final _addNewPostRepository = AddNewPostRepository();
  final _writePostRepository = WritePostRepository();
  final _addNextPartRepository = AddNextPartRepository();

  AddNewPostModelClass? addNewPostModelClass;
  WritePostModelClass? writePostModelClass;
  AddNextPartModelClass? addNextPartModelClass;

  bool _loading= false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> addNewPost(dynamic data, BuildContext context, dynamic headers, html, showFlushbar, back, isContest, contestId)async{

    //final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);

    setLoading(true);

    _addNewPostRepository.addNewPostApi(data, headers).then((value){
      print(value);

      if(value!.status == 200){

        String? postId = value.data!.postID.toString();


        var writePostData = {
          'postID': value.data!.postID.toString(),
          'podatData': "${html}"
        };



        writePost(writePostData, context, headers, html, showFlushbar, back, isContest, contestId, postId, null);
        setLoading(false);
        print('add new post is working ${value}');

      }
      else{
        Utils.flushBarErrorMessage('${value.data}', context, Icons.error_outline_rounded, colorLightWhite);
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

  Future<void> addNextPart(dynamic data, BuildContext context, dynamic headers, html, showFlushbar, back, isContest, contestId, mainPostId)async{

    //final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);

    setLoading(true);

    _addNextPartRepository.addNextPartApi(data, headers).then((value){
      print(value);
      setLoading(false);

      if(value!.status == 200){

        String? postId = value.postID.toString();


        var writePostData = {
          'postID': value.postID.toString(),
          'podatData': "${html}"
        };



        writePost(writePostData, context, headers, html, showFlushbar, back, isContest, contestId, postId, mainPostId);

        print('add new post is working ${value}');

      }
      else{

        Utils.flushBarErrorMessage('${value.data}', context, Icons.error_outline_rounded, colorLightWhite);
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

  Future<String?> writePost(dynamic data, BuildContext context, dynamic headers, html, showFlushbar, back, isContest, contestId, postId, mainPosId)async{

    setLoading(true);

    _writePostRepository.writePostApi(data, headers).then((value){
      print(value);
      setLoading(false);

      if(value!.status == 200){
        print('write post is working ${value}');
        if(back == true){
          Navigator.pop(context);
          Navigator.pop(context);
        }else{
          Navigator.pushReplacementNamed(context, RoutesName.enterBookDetailsScreen,
              arguments: {"postId" : postId, "isContest" : isContest, "contestId": contestId, "mainPostId" : mainPosId }
          );
        }

        if(showFlushbar == true){
          Utils.flushBarErrorMessageBottom("Changes Saved Succesfully", context);
        }

      }
      else{
        Utils.flushBarErrorMessage('${value.data}', context, Icons.error_outline_rounded, colorLightWhite);
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
  
}