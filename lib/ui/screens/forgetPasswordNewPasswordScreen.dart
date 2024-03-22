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

class ForgetPasswordNewPasswordScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  ForgetPasswordNewPasswordScreen(this.args);

  @override
  State<ForgetPasswordNewPasswordScreen> createState() => _ForgetPasswordNewPasswordScreenState();
}

class _ForgetPasswordNewPasswordScreenState extends State<ForgetPasswordNewPasswordScreen> {
  //const ForgetPasswordNewPasswordScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _showConfirmPassword = ValueNotifier<bool>(true);

  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

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
              title: Text('Final Step',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                            Text("Create New Password",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 5),
                            Text("Choose a strong password for better security.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: verticalSpaceSmall),
                            ValueListenableBuilder(
                                valueListenable: _showPassword,
                                builder: (BuildContext context, value, child){
                                  return TextFormFieldBig(
                                    controller: _passwordController,
                                    focusNode: passwordFocusNode,
                                    obscureText: _showPassword.value,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else if(value!.length < 6){
                                        return "Must contain at least 6 characters";

                                      } else{
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (value){
                                      Utils.fieldFocusChange(context, passwordFocusNode, confirmPasswordFocusNode);
                                    },
                                    hintText: 'Password',
                                    height: bigButtonHeight,
                                    suffixIcon: GestureDetector(
                                        onTap: (){
                                          _showPassword.value = !_showPassword.value;
                                        },
                                        child: (_showPassword.value)?
                                        Icon(Icons.visibility_off_outlined,
                                          color: Theme.of(context).disabledColor,
                                          size: 20,
                                        ):
                                        Icon(Icons.visibility,
                                          color: Theme.of(context).disabledColor,
                                          size: 20,
                                        )
                                    ),

                                    prefixIcon: Icon(Icons.lock_outline_rounded,
                                      color: secondaryColor,
                                      size: 20,
                                    ),
                                  );
                                }
                            ),
                            SizedBox(height: verticalSpaceSmall),
                            ValueListenableBuilder(
                                valueListenable: _showConfirmPassword,
                                builder: (BuildContext context, value, child){
                                  return TextFormFieldBig(
                                    controller: _confirmPasswordController,
                                    focusNode: confirmPasswordFocusNode,
                                    obscureText: _showConfirmPassword.value,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else if(_passwordController.text != _confirmPasswordController.text){
                                        return 'Password does not match';
                                      }
                                      else{
                                        return null;
                                      }
                                    },

                                    onFieldSubmitted: (value){

                                    },
                                    hintText: 'Confirm Password',
                                    height: bigButtonHeight,
                                    suffixIcon: GestureDetector(
                                        onTap: (){
                                          _showConfirmPassword.value = !_showConfirmPassword.value;
                                        },
                                        child: (_showConfirmPassword.value)?
                                        Icon(Icons.visibility_off_outlined,
                                          color: Theme.of(context).disabledColor,
                                          size: 20,
                                        ):
                                        Icon(Icons.visibility,
                                          color: Theme.of(context).disabledColor,
                                          size: 20,
                                        )
                                    ),
                                    prefixIcon: Icon(Icons.lock_outline_rounded,
                                      color: secondaryColor,
                                      size: 20,
                                    ),
                                  );
                                }
                            ),

                          ],
                        ),
                        Consumer<ForgetPasswordViewModel>(
                            builder: (context,value,child){
                              return Padding(
                                padding: EdgeInsets.only(bottom: verticalSpaceSmall),
                                child: ButtonBig(
                                  onTap: (){
                                    if (_formKey.currentState!.validate()){
                                      var data = {
                                        'email': "${widget.args!["email"]}",
                                        'otp': "${widget.args!["otp"]}",
                                        'newpassword': _confirmPasswordController.text.toString()
                                      };

                                      print("this is data ${data}");
                                      //value.verifyEmailData(data, null, context, emailController.text);
                                      value.forgetPasswordVerifyOtpData(data, null, context);

                                    }

                                  },
                                  height: bigButtonHeight,
                                  width: context.deviceWidth,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  text: 'CONFIRM',
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