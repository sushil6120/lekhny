import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/global%20widgets/otpWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/emailVerificationViewModel.dart';
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

class SignupVerifyEmailOTPScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  SignupVerifyEmailOTPScreen(this.args, {super.key});

  @override
  State<SignupVerifyEmailOTPScreen> createState() => _SignupVerifyEmailOTPScreenState();
}

class _SignupVerifyEmailOTPScreenState extends State<SignupVerifyEmailOTPScreen> {
  //const SignupVerifyEmailOTPScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  TextEditingController bookTitleController = TextEditingController();

  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();

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
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
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
                            Text("Enter OTP",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 5),
                            Text("Enter the one time password (OTP) sent to\n${widget.args!["email"]}.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: verticalSpaceLarge),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OtpWidget(first: true, last: false,inputController: one, borderColor: primaryColor),
                                OtpWidget(first: false, last: false, inputController: two, borderColor: primaryColor),
                                OtpWidget(first: false, last: false, inputController: three, borderColor: primaryColor),
                                OtpWidget(first: false, last: false, inputController: four, borderColor: primaryColor),
                                OtpWidget(first: false, last: true, inputController: five, borderColor: primaryColor),
                              ],
                            ),
                          ],
                        ),
                        Consumer<EmailVerificationViewModel>(
                            builder: (context,value,child){
                              return Padding(
                                padding: EdgeInsets.only(bottom: verticalSpaceSmall),
                                child: ButtonBig(
                                  onTap: (){
                                    final String otp = "${one.text}${two.text}${three.text}${four.text}${five.text}";
                                    if(otp.length == 5){
                                      var data = {
                                        'email': "${widget.args!["email"]}",
                                        'otp': otp
                                      };

                                      print(data);
                                      value.verifyEmailOtpData(data, null, context);

                                    }else{
                                      Utils.flushBarErrorMessage('Invalid OTP', context, Icons.error_outline_rounded, colorLightWhite);
                                    }

                                  },
                                  height: bigButtonHeight,
                                  width: context.deviceWidth,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  text: 'VERIFY',
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




