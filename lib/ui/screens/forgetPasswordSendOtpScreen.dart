import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/emailVerificationViewModel.dart';
import 'package:lekhny/viewModel/forgetPasswordViewModel.dart';
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

class ForgetPasswordSendOtpScreen extends StatefulWidget {

  @override
  State<ForgetPasswordSendOtpScreen> createState() => _ForgetPasswordSendOtpScreenState();
}

class _ForgetPasswordSendOtpScreenState extends State<ForgetPasswordSendOtpScreen> {
  //const ForgetPasswordSendOtpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

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
            appBar: AppBar(
              titleSpacing: 0,
              centerTitle: true,
              elevation: 0.5,
              leading: AppBarBackButton(),
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text('Step 1',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                    height: context.actualHeight - context.appBarHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: verticalSpaceSmall),
                            Text("Enter Your Email",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 5),
                            Text("Please enter your registered email address to recieve the OTP.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: verticalSpaceSmall),
                            Text("Email",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            SizedBox(height: verticalSpaceExtraSmall),
                            TextFormFieldBig(
                              focusNode: emailFocusNode,
                              controller: emailController,
                              //focusNode: emailFocusNode,
                              obscureText: false,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'This field is required';
                                }else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(value)){
                                  return 'Please enter a valid email';
                                }
                              },
                              onFieldSubmitted: (value){
                                //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                              },
                              keyboard: TextInputType.emailAddress,
                              hintText: 'Enter Your Email',
                              height: bigButtonHeight,
                              prefixIcon: null,
                            ),
                          ],
                        ),
                        Consumer<ForgetPasswordViewModel>(
                            builder: (context,value,child){
                              return Padding(
                                padding: EdgeInsets.only(bottom: verticalSpaceSmall),
                                child: ButtonBig(

                                  onTap: (){
                                    emailFocusNode.unfocus();
                                    if (_formKey.currentState!.validate()){
                                      var data = {
                                        'email': "${emailController.text}"
                                      };
                                      //value.verifyEmailData(data, null, context, emailController.text);
                                      value.forgetPasswordSendOtpData(data, null, context,emailController.text);

                                    }

                                  },
                                  height: bigButtonHeight,
                                  width: context.deviceWidth,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  text: 'SEND OTP',
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
          ),
        )
    );
  }
}