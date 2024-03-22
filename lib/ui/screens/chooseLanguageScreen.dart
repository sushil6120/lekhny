import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/global%20widgets/languageOptionWidget.dart';
import 'package:lekhny/ui/global%20widgets/redeemPointsOptionWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/authViewModel.dart';
import 'package:lekhny/viewModel/emailVerificationViewModel.dart';
import 'package:lekhny/viewModel/forgetPasswordViewModel.dart';
import 'package:lekhny/viewModel/redeemPointsViewModel.dart';
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

class ChooseLanguageScreen extends StatefulWidget {

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  //const ChooseLanguageScreen({Key? key}) : super(key: key);

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  @override

  Widget build(BuildContext context) {

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
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  height: context.actualHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: context.appBarHeight),

                          Text("Choose Your Language",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          SizedBox(height: 5),
                          Text("Read and write books in the language you love.",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: 240,
                            child: Consumer<AuthViewModel>(
                                builder: (context,value,child){
                                  return Align(
                                    alignment: Alignment.center,
                                    child: Text((value.language == "english")?"Hello":(value.language == "hindi")?"नमस्ते":(value.language == "urdu")?"ہیلو":"",
                                      style: Theme.of(context).textTheme.headline4,
                                      textAlign: TextAlign.center,
                                    ),
                                  );

                                }
                            ),
                          ),
                          Consumer<AuthViewModel>(
                              builder: (context,value,child){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    LanguageOptionWidget(
                                      onTap: (){
                                        value.setLanguage("english");
                                      },
                                      height: 75,
                                      width: context.deviceWidth*.3-10,
                                      borderColor: (value.language == "english")? primaryColor: Theme.of(context).textTheme.subtitle2!.color,
                                      text : "English",
                                      textColor: (value.language == "english")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                      boxColor: (value.language == "english")? primaryColor: Colors.transparent,
                                      languageText: "English",
                                      languageTextColor: (value.language == "english")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                    ),
                                    LanguageOptionWidget(
                                      onTap: (){
                                        value.setLanguage("hindi");
                                      },
                                      height: 75,
                                      width: context.deviceWidth*.3-10,
                                      borderColor: (value.language == "hindi")? primaryColor: Theme.of(context).textTheme.subtitle2!.color,
                                      text : "Hindi",
                                      textColor: (value.language == "hindi")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                      boxColor: (value.language == "hindi")? primaryColor: Colors.transparent,
                                      languageText: "हिन्दी",
                                      languageTextColor: (value.language == "hindi")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                    ),
                                    LanguageOptionWidget(
                                      onTap: (){
                                        value.setLanguage("urdu");
                                      },
                                      height: 75,
                                      width: context.deviceWidth*.3-10,
                                      borderColor: (value.language == "urdu")? primaryColor: Theme.of(context).textTheme.subtitle2!.color,
                                      text : "Urdu",
                                      textColor: (value.language == "urdu")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                      boxColor: (value.language == "urdu")? primaryColor: Colors.transparent,
                                      languageText:  'اردو',
                                      languageTextColor: (value.language == "urdu")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                    ),
                                  ],
                                );

                              }
                          ),

                        ],
                      ),
                      Consumer<AuthViewModel>(
                          builder: (context,value,child){
                            return Padding(
                              padding: EdgeInsets.only(bottom: verticalSpaceSmall),
                              child: ButtonBig(

                                onTap: (){

                                  if(value.language == 'english'){
                                    context.locale = Locale('en');
                                    sharedPreferencesViewModel.saveLanguage('3');

                                  }else if(value.language == 'hindi'){
                                    context.locale = Locale('hi');
                                    sharedPreferencesViewModel.saveLanguage('2');

                                  }else if(value.language == 'urdu'){
                                    context.locale = Locale('ur');
                                    sharedPreferencesViewModel.saveLanguage('4');
                                  }

                                  Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false);

                                },
                                height: bigButtonHeight,
                                width: context.deviceWidth,
                                backgroundColor: Theme.of(context).primaryColor,
                                text: 'NEXT',
                                showProgress: (value.loading == true)?true:false,
                                radius: radiusValue,
                                fontSize: 14,
                                letterspacing: 0.2,
                                progressColor: colorLightWhite,
                                progressStrokeWidth: 1.5,
                                textPadding: 0,
                              ),
                            );

                          }
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}