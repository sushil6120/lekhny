import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/global%20widgets/textFieldLabelTextWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonBigWithIcon.dart';
import 'package:lekhny/ui/global%20widgets/dropdownWidget.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldLong.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/stickydemopage.dart';
import 'package:lekhny/ui/widget/write%20page%20widget/writePageOptionWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/enterBookDetailsScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class EnterBookDetailsScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  EnterBookDetailsScreen(this.args);

  @override
  State<EnterBookDetailsScreen> createState() => _EnterBookDetailsScreenState();
}

class _EnterBookDetailsScreenState extends State<EnterBookDetailsScreen> {
  //const EnterBookDetailsScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController bookTitleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController copyrightController = TextEditingController();
  TextEditingController descrptionController = TextEditingController();

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();



  String? copyrightId;
  String? appLanguage;
  String? imageBaseUrl;
  var headers;
  String? mainPostId;
  bool isBuild = false;


  @override
  void initState() {
    mainPostId = widget.args!["mainPostId"];

    final enterBookDetailsScreenViewModel = Provider.of<EnterBookDetailsScreenViewModel>(context, listen: false);

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();

    })().then((value){

      print('this is appLanguage ${appLanguage}');

      sharedPreferencesViewModel.getToken().then((value){
        final data = {
          'IsContest':  widget.args!["isContest"],
          'postID': (widget.args!["mainPostId"] != null)?widget.args!["mainPostId"]:widget.args!["postId"],
        };

        headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print(" this is token ${value.toString()}");
        enterBookDetailsScreenViewModel.getBookDetailsData(data, headers, context);
        print("init is working");
      });
    });


    // TODO: implement initState

    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            titleSpacing: 0,
            centerTitle: true,
            elevation: 0.5,
            leading: AppBarBackButton(),
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Book Details',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          body: Consumer<EnterBookDetailsScreenViewModel>(
              builder: (context,value,child){
                print('satus ${value.enterBookDetailsData.status}');
                //print('value ${value.homePageData.data![0]!.data!.length}');
                switch(value.enterBookDetailsData.status){
                  case Status.LOADING :
                    return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )
                    );

                  case Status.ERROR :
                    return Text('${value.enterBookDetailsData.message.toString()} this is the error');

                  case Status.COMPLETED :

                    if(isBuild == false){
                      bookTitleController.text = value.bookTitle??"${value.postDetailsModel!.data!.postTitle}";
                      descrptionController.text = value.description??"${value.postDetailsModel!.data!.postSortDetails??""}";

                      isBuild = true;
                    }

                    categoryController.text = value.category??"${value.postDetailsModel!.data!.languageCategory??""}";

                    subCategoryController.text = value.subCategory??"${value.postDetailsModel!.data!.postSubCategory??""}";
                    copyrightId = value.copyrightId??"${value.postDetailsModel!.data!.copyrightStatus??""}";
                    //copyrightController.text = value.copyright??"${value.postDetailsModel!.data!.copyrightStatus??""}";
                    print('this is copuright id $copyrightId');
                    String? copyrightTitle = (copyrightId == "1")?"All Rights Reserved":(copyrightId == "2")?"Public Domain":"";
                    print("this is copyriht title $copyrightTitle");
                    copyrightController.text= value.copyright??copyrightTitle;

                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: verticalSpaceMedium),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 145,
                                  height: 215,
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  alignment: Alignment.topCenter,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                      borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 0,
                                            blurRadius: 5,
                                            offset: Offset(2.5, 6)
                                        )
                                      ]
                                  ),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 1 /1.5,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          child: (value.selectedFile != null)?Image.file(value.selectedFile!):
                                          CachedNetworkImage(
                                            imageUrl: "${imageBaseUrl}${value.postDetailsModel!.data!.postCoverImage}",
                                            fit: BoxFit.cover,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                      (mainPostId == null)?
                                      AspectRatio(
                                          aspectRatio: 1 /1.5,
                                          child: Align(
                                            alignment: (context.locale == Locale('ur'))?
                                            Alignment.topLeft:
                                            Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: (){
                                                value.getImage();
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).canvasColor,
                                                    border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                                child: Icon(Icons.edit_outlined,
                                                  color: primaryColor,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          )
                                      ):Container(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: verticalSpaceExtraSmall),
                              TextFieldLabelTextWidget(labelText: (mainPostId ==null)?"Book Title":"Chapter Title"),
                              TextFormFieldBig(
                                controller: bookTitleController,
                                //focusNode: emailFocusNode,
                                obscureText: false,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'This field is required';
                                  }else{
                                    return null;
                                  }
                                },
                                onFieldSubmitted: (textFieldValue){
                                  value.setBookTitle(textFieldValue);

                                  //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                                },
                                keyboard: TextInputType.text,
                                hintText: (mainPostId ==null)?"Book Title":"Chapter Title",
                                height: bigButtonHeight,
                                prefixIcon: null,
                              ),
                              (mainPostId != null)?SizedBox(height: verticalSpaceSmall):Container(),
                              (mainPostId == null)?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldLabelTextWidget(labelText: "Category"),

                                  TextFormFieldBig(
                                      onTap: (){
                                        _showCategory(context,value, headers);
                                      },
                                      readOnly: true,
                                      controller: categoryController,
                                      //focusNode: emailFocusNode,
                                      obscureText: false,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'This field is required';
                                        }else{
                                          return null;
                                        }
                                      },
                                      onFieldSubmitted: (value){
                                        //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                                      },
                                      keyboard: TextInputType.text,
                                      hintText: 'Category',
                                      height: bigButtonHeight,
                                      prefixIcon: null,
                                      suffixIcon: Icon(Icons.arrow_drop_down_rounded,
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                      )
                                  ),


                                  //SizedBox(height: verticalSpaceSmall),
                                  TextFieldLabelTextWidget(labelText: "Sub Category"),
                                  TextFormFieldBig(
                                      onTap: (){
                                        print("tapped");

                                        if(value.subCategoryList == null){
                                          Utils.toastMessage("Select category first");
                                        }else{
                                          _showSubCategory(context, value);
                                        }

                                      },
                                      readOnly: true,
                                      controller: subCategoryController,
                                      //focusNode: emailFocusNode,
                                      obscureText: false,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'This field is required';
                                        }else{
                                          return null;
                                        }
                                      },
                                      onFieldSubmitted: (value){
                                        //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                                      },
                                      keyboard: TextInputType.text,
                                      hintText: 'Sub-Category',
                                      height: bigButtonHeight,
                                      prefixIcon: null,
                                      suffixIcon: Icon(Icons.arrow_drop_down_rounded,
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                      )
                                  ),
                                  //SizedBox(height: verticalSpaceSmall),
                                  TextFieldLabelTextWidget(labelText: "Copyright"),
                                  TextFormFieldBig(
                                      onTap: (){
                                        print("tapped");
                                        _showCopyright(context, value);
                                      },
                                      readOnly: true,
                                      controller: copyrightController,
                                      //focusNode: emailFocusNode,
                                      obscureText: false,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return 'This field is required';
                                        }else{
                                          return null;
                                        }
                                      },
                                      onFieldSubmitted: (value){
                                        //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                                      },
                                      keyboard: TextInputType.text,
                                      hintText: 'Copyright',
                                      height: bigButtonHeight,
                                      prefixIcon: null,
                                      suffixIcon: Icon(Icons.arrow_drop_down_rounded,
                                        color: Theme.of(context).textTheme.bodyText1!.color,
                                      )
                                  ),
                                  //SizedBox(height: verticalSpaceSmall),
                                  TextFieldLabelTextWidget(labelText: "Description"),
                                  TextFormFieldLong(
                                    onTap: (){},
                                    readOnly: false,
                                    controller: descrptionController,
                                    //focusNode: emailFocusNode,
                                    obscureText: false,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else{
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (textFieldValue){
                                      value.setDescription(textFieldValue);
                                      //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                                    },
                                    keyboard: TextInputType.text,
                                    hintText: 'Short Description',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                  SizedBox(height: verticalSpaceSmall),

                                ],
                              ):Container(),

                              (value.buttonLoading == true)?Align(
                                   alignment: Alignment.center,
                                  child: CircularProgressWidget(color: primaryColor, strokeWidth: 1.5)):
                              Row(
                                mainAxisAlignment: (value.postDetailsModel!.data!.isPostPublish != 1 || mainPostId != null
                                )?MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
                                children: [
                                  OutlineButtonBig(
                                    onTap: (){

                                      if(_formKey.currentState!.validate()){
                                        var data = {
                                          'postID': widget.args!["postId"].toString(),
                                          'posttitle': bookTitleController.text.toString(),
                                          'languageCategoryTitle': categoryController.text.toString(),
                                          'subCatgeoryTitles': subCategoryController.text.replaceAll(" ", ""),
                                          'postSortDetails': descrptionController.text.toString(),
                                          'copywriteid': copyrightId.toString()
                                        };
                                        print("this is mutipart data ${data}");
                                        value.updatePostDetails(data, context, headers, "coverImage", value.selectedFile, true);
                                      }
                                    },
                                    height: bigButtonHeight,
                                    width: context.deviceWidth*0.5-(28),
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    text: 'Save',
                                    showProgress: false,
                                    radius: radiusValue,
                                    fontSize: 14,
                                    letterspacing: 0.2,
                                    textColor: primaryColor,
                                    borderColor: primaryColor,
                                    borderWidth: 1,

                                  ),
                                  (value.postDetailsModel!.data!.isPostPublish != 1 || mainPostId != null)?
                                  ButtonBig(
                                    onTap: (){
                                      if(_formKey.currentState!.validate()){
                                        var data = {
                                          'postID': widget.args!["postId"].toString(),
                                          'posttitle': bookTitleController.text.toString(),
                                          'languageCategoryTitle': categoryController.text.toString(),
                                          'subCatgeoryTitles': subCategoryController.text.replaceAll(" ", ""),
                                          'postSortDetails': descrptionController.text.toString(),
                                          'copywriteid': copyrightId.toString()
                                        };
                                        var publishData = {
                                          'postID': widget.args!["postId"].toString(),
                                        };
                                        print("this is mutipart data ${data}");
                                        value.saveAndPublish(data, context, headers, "coverImage", value.selectedFile, publishData );
                                      }
                                    },
                                    height: bigButtonHeight,
                                    width: context.deviceWidth*0.5-(28),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    text: 'Publish',
                                    showProgress: false,
                                    radius: radiusValue,
                                    fontSize: 14,
                                    letterspacing: 0.2,
                                    textPadding: 0,
                                  ):Container(),
                                ],
                              ),
                              SizedBox(height: verticalSpaceMedium),
                            ],
                          ),
                        ),
                      ),
                    );
                }
                return Container();
              }
          ),
        ),
      )
    );
  }

  void _showCategory(context,EnterBookDetailsScreenViewModel value, headers) {

    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (context)=>Center(
          child: Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ),
            height: 400,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                  ),
                  child: Text("Category",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: value.languageCategoryModel!.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        return Consumer<EnterBookDetailsScreenViewModel>(
                            builder: (context,value,child){
                              return GestureDetector(
                                onTap: (){
                                  value.setSelectedCategory("${value.languageCategoryModel!.data![index].languageCategory}");

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),

                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children : [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              //borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                              border: Border.all(width: 1, color: primaryColor)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.circle,
                                              size: 14,
                                              color: (value.selectedCategory ==
                                                  value.languageCategoryModel!.data![index].languageCategory
                                              )?
                                              primaryColor:Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text("${value.languageCategoryModel!.data![index].languageCategory}",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              color: (value.selectedCategory ==
                                                  value.languageCategoryModel!.data![index].languageCategory
                                              )?
                                              Theme.of(context).textTheme.subtitle1!.color:
                                              Theme.of(context).textTheme.bodyText1!.color
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              );

                            }
                        );
                      }
                  ),
                ),
                Consumer<EnterBookDetailsScreenViewModel>(
                    builder: (context,value,child){
                      return Container(
                        height: 48,
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                        ),
                        child: (value.loading == true)?
                        SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressWidget(color: primaryColor, strokeWidth: 1.5)):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: (){
                                value.setSelectedCategory(value.category);
                                // if(value.category != null){
                                //   value.setCategory("${value.postDetailsModel!.data!.languageCategory??""}");
                                // }
                                Navigator.pop(context);
                              },
                              child: Text("CANCEL",
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: primaryColor
                                ),
                              ),
                            ),
                            SizedBox(width: 40),
                            GestureDetector(
                              onTap: (){

                                if( value.selectedCategory != null){
                                  value.setCategory("${value.selectedCategory}");

                                  final data = {
                                    'CategoryTitlle': "${value.selectedCategory}"
                                  };

                                  value.getLanguageSubCategory(data, headers, context, true);
                                  value.setSubCategory("");

                                }else{
                                  Utils.toastMessage("No categery selected");
                                }

                              },
                              child: Text("OK",
                                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                    color: primaryColor
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                    }
                ),


              ],
            ),
          ),
        ));
  }

  void _showSubCategory(context, EnterBookDetailsScreenViewModel value) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (context)=>Center(
          child: Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ),
            height: 400,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                  ),
                  child: Text("Sub-Category",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Consumer<EnterBookDetailsScreenViewModel>(
                    builder: (context,value,child){
                      return Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: value.subCategoryList!.length,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                onTap: (){
                                  if(value.selectedSubCategoryList!.contains(value.subCategoryList![index])){
                                    value.removeSelectedSubCategoryList(value.subCategoryList![index]);

                                  }else{
                                    value.addSelectedSubCategoryList(value.subCategoryList![index]);

                                  }

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:Theme.of(context).scaffoldBackgroundColor,
                                  ),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                            color: (value.selectedSubCategoryList!.contains(value.subCategoryList![index]))?primaryColor:Theme.of(context).scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                            border: Border.all(width: 1, color: primaryColor)
                                        ),
                                        child: (value.selectedSubCategoryList!.contains(value.subCategoryList![index]))?Center(
                                          child: Icon(Icons.check_rounded,
                                              size: 14,
                                              color: colorLightWhite
                                          ),
                                        ):Container(),
                                      ),
                                      SizedBox(width: 20),
                                      Text("${value.subCategoryList![index]}",
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                            color: (value.selectedSubCategoryList!.contains(value.subCategoryList![index]))?
                                            Theme.of(context).textTheme.subtitle1!.color:
                                            Theme.of(context).textTheme.bodyText1!.color

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        ),
                      );

                    }
                ),

                Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          value.setSelectedSubCategoryList([]);
                          //value.setSelectedSubCategoryList(value.mainSelectedSubCategoryList);
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      GestureDetector(
                        onTap: (){
                          String? subCategory = value.selectedSubCategoryList.toString().replaceAll("[", "").replaceAll("]", "");
                          value.setSubCategory(subCategory);
                          //
                          print("this is second value.mainSelectedSubCategoryList ${value.selectedSubCategoryList}");
                          Navigator.pop(context);

                        },
                        child: Text("OK",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }

  void _showCopyright(context,EnterBookDetailsScreenViewModel value) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black26,
        context: context,
        builder: (context)=>Center(
          child: Container(
            alignment: Alignment.center,
            //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(radiusValue))
            ),
            height: 350,
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                  ),
                  child: Text("Copyright",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index){
                        return Consumer<EnterBookDetailsScreenViewModel>(
                            builder: (context,value,child){
                              return GestureDetector(
                                onTap: (){
                                  value.setCopyright("${value.postCopyrightModel!.data![index].copyWritetitle}");
                                  value.setCopyrightId("${value.postCopyrightModel!.data![index].copyrightID}");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),

                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children : [
                                        Container(
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              //borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                              border: Border.all(width: 1, color: primaryColor)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.circle,
                                              size: 14,
                                              color: (value.copyright ==
                                                  value.postCopyrightModel!.data![index].copyWritetitle
                                              )?
                                              primaryColor:Theme.of(context).scaffoldBackgroundColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text("${value.postCopyrightModel!.data![index].copyWritetitle}",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                              color: (value.copyright ==
                                                  value.postCopyrightModel!.data![index].copyWritetitle
                                              )?
                                              Theme.of(context).textTheme.subtitle1!.color:
                                              Theme.of(context).textTheme.bodyText1!.color
                                          ),
                                        ),
                                      ]
                                  ),
                                ),
                              );

                            }
                        );
                      }
                  ),
                ),

                Container(
                  height: 48,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Text("CANCEL",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                      SizedBox(width: 40),
                      GestureDetector(
                        onTap: (){
                          copyrightId = value.copyrightId;
                          Navigator.pop(context);
                        },
                        child: Text("OK",
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: primaryColor
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ),
        ));
  }
}




