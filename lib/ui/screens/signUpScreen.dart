import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/services/authServices/signUpWithGoogle.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonWithPrefixImage.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/authViewModel.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  //const SignUpScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  ValueNotifier<bool> _showPassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _showConfirmPassword = ValueNotifier<bool>(true);

  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

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
        child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: false,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title:  Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: AppBarBackButton(),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              titleSpacing: 0,
            ),
            body: Form(
              key: _formKey,
              child: Container(
                height: context.actualHeight,
                padding: EdgeInsets.only(left: 18, right: 18),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              // Container(
                              //   height: 150,
                              //   alignment: Alignment.center,
                              //   child: Image.asset(lekhnyLogoEnglish,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),

                              SizedBox(height: verticalSpaceExtraSmall),
                              Text('Sign Up',
                                  style: Theme.of(context).textTheme.headline4
                              ),
                              SizedBox(height: verticalSpaceExtraSmall),
                              Container(
                                child: Text("Create a new account",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: verticalSpaceMedium),
                              TextFormFieldBig(
                                obscureText: false,
                                controller: _nameController,
                                focusNode: nameFocusNode,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'This field is required';
                                  }else if(!RegExp(r'^[a-zA-Z ]*$').hasMatch(value)){
                                    return "Please enter a valid name";
                                  }else{
                                    return null;
                                  }
                                },
                                onFieldSubmitted: (value){
                                  Utils.fieldFocusChange(context, nameFocusNode, emailFocusNode);
                                },
                                keyboard: TextInputType.name,

                                hintText: 'Full Name',
                                height: bigButtonHeight,
                                prefixIcon: Icon(Icons.person_outline_outlined,
                                  color: secondaryColor,
                                  size: 20,
                                ),
                              ),
                              SizedBox(height: verticalSpaceSmall),
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
                                        }else if(value!.length < 6){
                                          return "Length must be greater than 6 characters";

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

                              SizedBox(height: verticalSpaceSmall),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.caption,
                                  children: <TextSpan>[
                                    TextSpan(text: "By signing, you agree to our "),
                                    TextSpan(
                                        text: 'Terms & Conditions',
                                        style: Theme.of(context).textTheme.caption!.copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Terms of Service"');
                                          }),
                                    TextSpan(text: "\nand "),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: Theme.of(context).textTheme.caption!.copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('Terms of Service"');
                                          }),
                                  ],
                                ),
                              ),
                              SizedBox(height: verticalSpaceLarge),
                              Consumer<AuthViewModel>(builder: (BuildContext context, value, Widget? child){
                                return GestureDetector(
                                  onTap: (){

                                    if(_formKey.currentState!.validate()){

                                      value.setLanguage("english");

                                      Map data = {
                                        "email" : _emailController.text.toString(),
                                        "password" : _passwordController.text.toString(),
                                        "name" : _nameController.text.toString(),
                                      };

                                      authViewModel.signUpByEmail(data, context, _emailController.text.toString(),);
                                    }
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                                  },
                                  child: ButtonBig(
                                    height: bigButtonHeight,
                                    width: double.infinity,
                                    backgroundColor: primaryColor,
                                    text: 'SIGN UP',
                                    showProgress: authViewModel.signUpLoading,
                                    radius: radiusValue,
                                    progressColor: colorLightWhite,
                                    progressStrokeWidth: 1.5,
                                    textPadding: 0,
                                  ),
                                );
                              }),
                              SizedBox(height: verticalSpaceSmall),
                              Consumer<AuthViewModel>(builder: (BuildContext context, value, Widget? child){
                                return  ButtonWithPrefixImage(
                                  onTap: (){
                                    value.setLanguage("english");
                                    SignUpWithGoogle().signInWithGoogle(context);
                                  },
                                  height: bigButtonHeight,
                                  width: double.infinity,
                                  radius: radiusValue,
                                  progressColor: colorLightWhite,
                                  progressStrokeWidth: 1.5,
                                  backgroundColor: Colors.transparent,
                                  text: 'Sign up with Google',
                                  showProgress: false,
                                  imgHeight:25,
                                  imgWidth:25,
                                  img: googleIcon,
                                  letterspacing: 0,
                                  imgSpace:10,
                                  borderWidth: 1,
                                  borderColor: Theme.of(context).textTheme.bodyText1!.color,
                                  textColor: Theme.of(context).textTheme.subtitle2!.color,

                                );
                              }),

                              // Text("Or Sign Up With",
                              //   style: Theme.of(context).textTheme.bodyText1,
                              //   textAlign: TextAlign.center,
                              // ),
                              // SizedBox(height: verticalSpaceSmall),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     IconCircle(
                              //         onTap: (){
                              //           SignUpWithGoogle().signInWithGoogle(context);
                              //           //print("hell no ${FirebaseAuth.instance.currentUser!.displayName}");
                              //
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
                              //         onTap: (){
                              //           Utils.toastMessage('This Feature will be added soon');
                              //         },
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
                              //         onTap: (){
                              //           Utils.toastMessage('This Feature will be added soon');
                              //         },
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
                              // ),
                              SizedBox(height: verticalSpaceExtraSmall),
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
                                  TextSpan(text: "Already have an account ? "),
                                  TextSpan(
                                      text: 'Login',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pop(context);
                                        }),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                    )
                  ],

                ),
              ),
            ),
          ),
        )
    );
  }
}
