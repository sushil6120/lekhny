import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lekhny/data/model/redeemPointsModelClass.dart';
import 'package:lekhny/data/model/requestPointsModelClass.dart';
import 'package:lekhny/data/repository/redeemPointsRepository.dart';
import 'package:lekhny/data/repository/requestPointsRepository.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';

class RedeemPointsViewModel with ChangeNotifier{

  final _redeemPointsRepository = RedeemPointsRepository();
  final _requestPointsRepository = RequestPointsRepository();

  RedeemPointsModelClass? redeemPointsModelClass;
  RequestPointsModelClass? requestPointsModelClass;

  bool loading = false;
  String? sendMoneyTo;

  setLoading(value){
    loading = value;
    notifyListeners();
  }

  setSendMoneyTo(value){
    sendMoneyTo = value;
    notifyListeners();
  }

  File? selectedFile;

  getImage()async{
    XFile? image = await ImagePicker().pickImage(source : ImageSource.gallery);
    final File pickedFile = File(image!.path);
    if(image !=null){
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        //maxWidth: 700,
        //maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
      );
      final File croppedFile = File(cropped!.path);

      selectedFile = croppedFile;

      notifyListeners();

    }
  }

  Future<void> redeemPoints(dynamic data, BuildContext context, dynamic headers,imageDataKey, image )async{

    setLoading(true);

    _redeemPointsRepository.redeemPointsApi(data, headers, imageDataKey, image).then((value){
      print(value);
      setLoading(false);

      if(value!.status == 200){
         print('write post is working ${value}');
         Navigator.pop(context);
         Utils.flushBarErrorMessage('${value.data}', context, Icons.done, primaryColor);

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

  Future<void> requestPoints(dynamic data, dynamic headers, BuildContext context)async{
      setLoading(true);

    await _requestPointsRepository.requestPointsApi(data, headers).then((value){

      setLoading(false);

      if(value!.status == 200){
        Navigator.pop(context);
        Utils.flushBarErrorMessage('${value.data!.message}', context, Icons.done, primaryColor);

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