import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/services/authServices/signUpWithGoogle.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonWithPrefixImage.dart';
import 'package:lekhny/ui/global%20widgets/iconCircle.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/bottomNavigationBarScreen.dart';
import 'package:lekhny/ui/screens/signUpScreen.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/authViewModel.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginScreen extends StatelessWidget {
  //const LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final themeManager = Provider.of<ThemeManager>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Theme.of(context).brightness,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Theme.of(context).brightness
        ),
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: context.actualHeight,
                  padding: EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                           SizedBox(height: 135),
                          Text('Welcome Back',
                              style: Theme.of(context).textTheme.headline4
                          ),
                          SizedBox(height: verticalSpaceExtraSmall),
                          Container(
                            child: Text("Login to your account",
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: verticalSpaceMedium),
                          TextFormFieldBig(
                            controller: _emailController,
                            focusNode: emailFocusNode,
                            obscureText: false,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'This field is required';
                              }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$").hasMatch(value)){
                                return "Please enter a valid email";
                              }else{
                                return null;
                              }
                            },
                            onFieldSubmitted: (value){
                              Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                            },
                            keyboard: TextInputType.emailAddress,
                            hintText: 'Email',
                            height: bigButtonHeight,
                            prefixIcon: Icon(Icons.email_outlined,
                              color: secondaryColor,
                              size: 20,
                            ),
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
                                    }
                                    else{
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: (value){

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
                          SizedBox(height: verticalSpaceExtraSmall),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, RoutesName.forgetPasswordSendOtpScreen);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text("Forget Password ?",
                                style: Theme.of(context).textTheme.caption!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpaceLarge),
                          GestureDetector(
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                Map data = {
                                  "email" : _emailController.text.toString(),
                                  "password" : _passwordController.text.toString(),
                                };

                                authViewModel.loginByEmail(data, context);
                              }
                            },
                            child: ButtonBig(
                                height: bigButtonHeight,
                                width: double.infinity,
                                backgroundColor: primaryColor,
                                text: 'LOGIN',
                                showProgress: authViewModel.loading,
                                radius: radiusValue,
                                progressColor: colorLightWhite,
                                progressStrokeWidth: 1.5,
                                textPadding: 0,
                            ),
                          ),
                          SizedBox(height: verticalSpaceSmall),
                          // Text("Or Login With",
                          //   style: Theme.of(context).textTheme.bodyText1,
                          //   textAlign: TextAlign.center,
                          // ),
                          // SizedBox(height: verticalSpaceSmall),
                          ButtonWithPrefixImage(
                            onTap: (){
                              SignUpWithGoogle().logInWithGoogle(context);
                            },
                            height: bigButtonHeight,
                            width: double.infinity,
                            radius: radiusValue,
                            progressColor: colorLightWhite,
                            progressStrokeWidth: 1.5,
                            backgroundColor: Colors.transparent,
                            text: 'Login with Google',
                            letterspacing: 0,
                            showProgress: false,
                            imgHeight:25,
                            imgWidth:25,
                            img: googleIcon,
                            imgSpace:10,
                            borderWidth: 1,
                            borderColor: Theme.of(context).textTheme.bodyText1!.color,
                            textColor: Theme.of(context).textTheme.subtitle2!.color,

                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     IconCircle(
                          //         onTap: (){
                          //           SignUpWithGoogle().logInWithGoogle(context);
                          //         },
                          //         parentHeight: 50,
                          //         parentWidth: 50,
                          //         parentBackgroundColor: Colors.transparent,
                          //         borderWidth: 1,
                          //         borderColor: Theme.of(context).textTheme.bodyText1!.color,
                          //         height: 25,
                          //         width: 25,
                          //         backgroundColor: Colors.transparent,
                          //         image: googleIcon
                          //     ),
                          //     SizedBox(width: 20),
                          //     IconCircle(
                          //         onTap: (){},
                          //         parentHeight: 50,
                          //         parentWidth: 50,
                          //         parentBackgroundColor: Colors.transparent,
                          //         borderWidth: 1,
                          //         borderColor: Theme.of(context).textTheme.bodyText1!.color,
                          //         height: 25,
                          //         width: 25,
                          //         backgroundColor: Colors.transparent,
                          //         image: facebookIcon
                          //     ),
                          //     SizedBox(width: 20),
                          //     IconCircle(
                          //         onTap: (){},
                          //         parentHeight: 50,
                          //         parentWidth: 50,
                          //         parentBackgroundColor: Colors.transparent,
                          //         borderWidth: 1,
                          //         borderColor: Theme.of(context).textTheme.bodyText1!.color,
                          //         height: 25,
                          //         width: 25,
                          //         backgroundColor: Colors.transparent,
                          //         image: (themeManager.themeMode== ThemeMode.dark)?appleGreyIcon:appleIcon
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: bottomMargin),
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(text: "Doesn't have an account ? "),
                            TextSpan(
                                text: 'Sign Up',
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, RoutesName.signUpScreen);
                                  }),
                          ],
                        ),
                       ),
                      )
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
