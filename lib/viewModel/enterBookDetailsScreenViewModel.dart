import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/model/languageSubCategoryModelClass.dart';
import 'package:lekhny/data/model/postCopyrightModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/publishPostModelClass.dart';
import 'package:lekhny/data/model/readingHistoryModelClass.dart';
import 'package:lekhny/data/model/postDetailsModelClass.dart';
import 'package:lekhny/data/model/topSeriesModelClass.dart';
import 'package:lekhny/data/model/updatePostDetailsModelClass.dart';
import 'package:lekhny/data/repository/PostCopyRightRepository.dart';
import 'package:lekhny/data/repository/UpdatePostDetailsRepository.dart';
import 'package:lekhny/data/repository/languageCategoryRepository.dart';
import 'package:lekhny/data/repository/languageSubCategoryRepository.dart';
import 'package:lekhny/data/repository/postDetailsRepository.dart';
import 'package:lekhny/data/repository/publishPostRepository.dart';
import 'package:lekhny/data/repository/readingHistoryRepository.dart';
import 'package:lekhny/data/repository/singleBookDetailsRepository.dart';
import 'package:lekhny/data/repository/singleBookPartsRepository.dart';
import 'package:lekhny/data/repository/topSeriesRepository.dart';
import 'package:lekhny/data/response/apiResponse.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EnterBookDetailsScreenViewModel with ChangeNotifier{

  final _postDetailsRepository = PostDetailsRepository();
  final _languageCategoryRepository = LanguageCategoryRepository();
  final _languageSubCategoryRepository = LanguageSubCategoryRepository();
  final _postCopyrightRepository = PostCopyrightRepository();
  final _updatePostDetailsRepository = UpdatePostDetailsRepository();
  final _publishPostRepository = PublishPostRepository();

  PostDetailsModelClass? postDetailsModel;
  LanguageCategoryModelClass? languageCategoryModel;
  LanguageSubCategoryModelClass? languageSubCategoryModel;
  PostCopyrightModelClass? postCopyrightModel;
  UpdatePostDetailsModelClass? updatePostDetailsModel;
  PublishPostModelClass? publishPostModel;

  ApiResponse<List<dynamic>> enterBookDetailsData = ApiResponse.loading();

  String? _bookTitle;
  String? get bookTitle => _bookTitle;

  setBookTitle(String? value){
    _bookTitle = value;
    notifyListeners();
  }

  String? _description;
  String? get description => _description;

  setDescription(String? value){
    _description = value;
    notifyListeners();
  }

 String? _category;
 String? get category => _category;

  setCategory(String? value){
    _category = value;
    notifyListeners();
  }

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  setSelectedCategory(String? value){
    _selectedCategory = value;
    notifyListeners();
  }

  List<String?>? _subCategoryList;
  List<String?>? get subCategoryList => _subCategoryList;

  setSubCategoryList(List<String?>? value){
    _subCategoryList = value;
    notifyListeners();
  }

  List<String?>? _selectedSubCategoryList = [];
  List<String?>? get selectedSubCategoryList => _selectedSubCategoryList;

  setSelectedSubCategoryList(List<String?>? value){
    _selectedSubCategoryList = value;
    notifyListeners();
  }

  addSelectedSubCategoryList(value){
    _selectedSubCategoryList!.add(value);
    notifyListeners();
  }
  removeSelectedSubCategoryList(value){
    _selectedSubCategoryList!.remove(value);
    notifyListeners();
  }

  String? _subCategory;
  String? get subCategory => _subCategory;

  setSubCategory(String? value){
    _subCategory = value;
    notifyListeners();
  }

  String? _copyright;
  String? get copyright => _copyright;

  setCopyright(String? value){
    _copyright = value;
    notifyListeners();
  }

  String? _copyrightId;
  String? get copyrightId => _copyrightId;

  setCopyrightId(String? value){
    _copyrightId = value;
    notifyListeners();
  }

  bool _loading= false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _buttonLoading= false;
  bool get buttonLoading => _buttonLoading;

  setButtonLoading(bool value){
    _buttonLoading = value;
    notifyListeners();
  }

  
  setEnterBookDetailsData( ApiResponse<List<dynamic>> response){
    print('setEnterBookDetailsData working');
    enterBookDetailsData = response;
    print("this is responsePassed ${response}");
    print("this is enterBookDetailsData ${enterBookDetailsData}");
    notifyListeners();
  }

  Future<void> getBookDetailsData(dynamic data, dynamic headers, BuildContext context) async{


    setEnterBookDetailsData(ApiResponse.loading());

    Future.wait([
      _postDetailsRepository.postDetailsApi(data, headers),
      _languageCategoryRepository.languageCategoryApi(null, headers),
      _postCopyrightRepository.postCopyrightApi(null, headers)

    ]).then((value){

      postDetailsModel = value[0] as PostDetailsModelClass;
      languageCategoryModel = value[1] as LanguageCategoryModelClass;
      postCopyrightModel = value[2] as PostCopyrightModelClass;

      if(postDetailsModel!.data!.languageCategory.toString() != "null" &&
          postDetailsModel!.data!.languageCategory.toString() != null  ){

        print("categoryValue ${postDetailsModel!.data!.languageCategory}");
        final subCategoryData = {
          'CategoryTitlle': "${postDetailsModel!.data!.languageCategory}"
        };

        getLanguageSubCategory(subCategoryData, headers, context, false);
      }



      print('this is future.wait value ${value}');

      setEnterBookDetailsData(ApiResponse.completed(value));
      print('apiresponse.completed working');

    }).onError((error, stackTrace){

      setEnterBookDetailsData(ApiResponse.error(error.toString()));

    });
  }

  Future<void> getLanguageSubCategory(dynamic data, headers, BuildContext context,bool back)async{

    setLoading(true);
    if(selectedSubCategoryList != null){
      selectedSubCategoryList!.clear();
    }
    _languageSubCategoryRepository.languageSubCategoryApi(data, headers).then((value){
      print(value);
      setLoading(false);

      if(value!.status == 200){
        List<String?>? list = [];
        for( var item in value.data!){
          list.add(item.subCategory);
        }
        print("this is list ${list}");
        setSubCategoryList(list);

        if (back == true){
          Navigator.pop(context);
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

  File? selectedFile;

  getImage()async{
    XFile? image = await ImagePicker().pickImage(source : ImageSource.gallery);
    final File pickedFile = File(image!.path);
    if(image !=null){
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
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

  Future<void> updatePostDetails(dynamic data, BuildContext context, dynamic headers,imageDataKey, image, showFlushbar)async{

    setButtonLoading(true);

    _updatePostDetailsRepository.updatePostDetailsApi(data, headers, imageDataKey, image).then((value){
      print(value);
      setButtonLoading(false);

      if(value!.status == 200){
        print('write post is working ${value}');

        if(showFlushbar == true){
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false);
          Utils.flushBarErrorMessage("Changes Saved Succesfully", context, Icons.done, primaryColor);
          //Utils.toastMessage("Changes Saved Succesfully");
          //Utils.snackBar("Changes Saved Succesfully", context);
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
      setButtonLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }
    });

  }

  Future<void> saveAndPublish(dynamic data, BuildContext context, dynamic headers,imageDataKey, image, publishData)async{

    setButtonLoading(true);

    _updatePostDetailsRepository.updatePostDetailsApi(data, headers, imageDataKey, image).then((value){
      print(value);

      if(value!.status == 200){
        print('write post is working ${value}');

        _publishPostRepository.publishPostApi(publishData, headers).then((value){
          setButtonLoading(false);
          if(value!.status == 401){
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false);
            Utils.flushBarErrorMessage("Book Published Succesfully", context, Icons.done, primaryColor);
            //Utils.toastMessage("Book Published Succesfully");
            //Utils.snackBar("Book Published Succesfully", context);
            print("it worked");
          }else{
            Utils.flushBarErrorMessage("${value.data}", context, Icons.error_outline_rounded, colorLightWhite);
          }
        });
      }
      else{
        setButtonLoading(false);
        Utils.flushBarErrorMessage('${value.data}', context, Icons.error_outline_rounded, colorLightWhite);
      }

      if(kDebugMode){
        print('value');
        print(value.toString());
      }
    }
    ).onError((error, stackTrace){
      setButtonLoading(false);

      if(kDebugMode){
        print('error');
        print(error.toString());
      }
    });

  }
}