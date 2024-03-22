import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/global%20widgets/textFieldLabelTextWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
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

class RequestPointsScreen extends StatefulWidget {

  @override
  State<RequestPointsScreen> createState() => _RequestPointsScreenState();
}

class _RequestPointsScreenState extends State<RequestPointsScreen> {
  //const RequestPointsScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  TextEditingController pointsController = TextEditingController();

  String? appLanguage;
  var headers;


  @override
  void initState() {

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();

    })().then((value){

      print('this is appLanguage ${appLanguage}');

      sharedPreferencesViewModel.getToken().then((value){
        headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };
      });
    });


    // TODO: implement initState

    super.initState();
  }

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
              title: Text('Request Points',
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
                            Text("Enter Points",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 5),
                            Text("You can request upto 25 points at one time.",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            TextFieldLabelTextWidget(labelText: "Points To Request"),
                            TextFormFieldBig(
                              controller: pointsController,
                              //focusNode: emailFocusNode,
                              obscureText: false,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'This field is required';
                                }else if ( double.parse(pointsController.text) > 25){
                                  return 'Maximum request limit is 25';
                                }
                              },
                              onFieldSubmitted: (value){
                                //Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                              },
                              keyboard: TextInputType.number,
                              hintText: 'Enter Points',
                              height: bigButtonHeight,
                              prefixIcon: null,
                            ),
                          ],
                        ),
                        Consumer<RedeemPointsViewModel>(
                            builder: (context,value,child){
                              return Padding(
                                padding: EdgeInsets.only(bottom: verticalSpaceSmall),
                                child: ButtonBig(
                                  onTap: (){
                                    if(_formKey.currentState!.validate()){
                                      var data = {
                                        'pointsRequest': pointsController.text.toString()
                                      };

                                      value.requestPoints(data, headers, context);
                                    }
                                  },
                                  height: bigButtonHeight,
                                  width: context.deviceWidth,
                                  backgroundColor: Theme.of(context).primaryColor,
                                  text: 'SEND',
                                  showProgress: value.loading,
                                  radius: radiusValue,
                                  fontSize: 14,
                                  letterspacing: 0.2,
                                  textPadding: 0,
                                  progressColor: colorLightWhite,
                                  progressStrokeWidth: 1.5,
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




