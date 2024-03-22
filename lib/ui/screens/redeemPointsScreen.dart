import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/redeemPointsOptionWidget.dart';
import 'package:lekhny/ui/global%20widgets/textFieldLabelTextWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/redeemPointsViewModel.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';

class RedeemPointsScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  RedeemPointsScreen(this.args);

  @override
  State<RedeemPointsScreen> createState() => _RedeemPointsScreenState();
}

class _RedeemPointsScreenState extends State<RedeemPointsScreen> {
  //const RedeemPointsScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  TextEditingController pointsController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountNumberController = TextEditingController();
  TextEditingController upiController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscController = TextEditingController();

  FocusNode pointsFocusNode = FocusNode();
  FocusNode accountNumberFocusNode = FocusNode();
  FocusNode confirmAccountNumberFocusNode = FocusNode();
  FocusNode upiFocusNode = FocusNode();
  FocusNode bankNameFocusNode = FocusNode();
  FocusNode ifscFocusNode = FocusNode();

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
              title: Text('Redeem Points',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: verticalSpaceSmall, bottom: 5),
                        child: Text("Enter Account Details",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Text("Please check all the details carefully before submitting.",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      TextFieldLabelTextWidget(labelText: "Points To Redeem"),
                      TextFormFieldBig(
                        controller: pointsController,
                        focusNode: pointsFocusNode,
                        obscureText: false,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'This field is required';
                          }else if (double.parse(pointsController.text) > double.parse(widget.args!["availablePoints"])) {
                            return 'Not enough balance';
                          }else if (double.parse(pointsController.text) < 150){
                            return 'Minimun withdrawl limit is 150';
                          }
                        },
                        onFieldSubmitted: (value){

                        },
                        keyboard: TextInputType.number,
                        hintText: 'Enter Points',
                        height: bigButtonHeight,
                        prefixIcon: null,
                      ),
                      TextFieldLabelTextWidget(labelText: "Send Money To"),
                      Consumer<RedeemPointsViewModel>(
                          builder: (context,value,child){
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                RedeemPointsOptionWidget(
                                  onTap: (){
                                    value.setSendMoneyTo("bank");
                                  },
                                  height: 80,
                                  width: 140,
                                  borderColor: (value.sendMoneyTo == "bank")? primaryColor: Theme.of(context).textTheme.subtitle2!.color,
                                  text : "Bank Account",
                                  textColor: (value.sendMoneyTo == "bank")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                  boxColor: (value.sendMoneyTo == "bank")? primaryColor: Colors.transparent,
                                  icon: Icons.account_balance_rounded,
                                  iconColor: (value.sendMoneyTo == "bank")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                ),
                                RedeemPointsOptionWidget(
                                  onTap: (){
                                    value.setSendMoneyTo("upi");
                                  },
                                  height: 80,
                                  width: 140,
                                  borderColor: (value.sendMoneyTo == "upi")? primaryColor: Theme.of(context).textTheme.subtitle2!.color,
                                  text : "UPI ID/QR Code",
                                  textColor: (value.sendMoneyTo == "upi")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                  boxColor: (value.sendMoneyTo == "upi")? primaryColor: Colors.transparent,
                                  icon: Icons.qr_code_2_rounded,
                                  iconColor: (value.sendMoneyTo == "upi")? colorLightWhite: Theme.of(context).textTheme.subtitle2!.color,
                                ),
                              ],
                            );

                          }
                      ),
                      Consumer<RedeemPointsViewModel>(
                          builder: (context,value,child){
                            if(value.sendMoneyTo == "bank"){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldLabelTextWidget(labelText: "Bank Name"),
                                  TextFormFieldBig(
                                    controller: bankNameController,
                                    focusNode: bankNameFocusNode,
                                    obscureText: false,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else{
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (value){
                                      Utils.fieldFocusChange(context, bankNameFocusNode, accountNumberFocusNode);
                                    },
                                    keyboard: TextInputType.text,
                                    hintText: 'Enter Bank Name',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                  TextFieldLabelTextWidget(labelText: "Account Number"),
                                  TextFormFieldBig(
                                    controller: accountNumberController,
                                    focusNode: accountNumberFocusNode,
                                    obscureText: false,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else{
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (value){
                                      Utils.fieldFocusChange(context, accountNumberFocusNode, confirmAccountNumberFocusNode);
                                    },
                                    keyboard: TextInputType.number,
                                    hintText: 'Enter Account Number',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                  TextFieldLabelTextWidget(labelText: "Confirm Account Number"),
                                  TextFormFieldBig(
                                    controller: confirmAccountNumberController,
                                    focusNode: confirmAccountNumberFocusNode,
                                    obscureText: false,
                                    validator: (value){

                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else if (accountNumberController.text != confirmAccountNumberController.text) {
                                        return "Account number does not match";
                                      }

                                    },
                                    onFieldSubmitted: (value){
                                      Utils.fieldFocusChange(context, confirmAccountNumberFocusNode, ifscFocusNode);
                                    },
                                    keyboard: TextInputType.number,
                                    hintText: 'Confirm Account Number',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                  TextFieldLabelTextWidget(labelText: "IFSC Code"),
                                  TextFormFieldBig(
                                    controller: ifscController,
                                    focusNode: ifscFocusNode,
                                    obscureText: false,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'This field is required';
                                      }else{
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (value){
                                    },
                                    keyboard: TextInputType.number,
                                    hintText: 'Enter IFSC Code',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                ],
                              );
                            }else if (value.sendMoneyTo == "upi"){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldLabelTextWidget(labelText: "UPI ID"),
                                  TextFormFieldBig(
                                    controller: upiController,
                                    focusNode: upiFocusNode,
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
                                    keyboard: TextInputType.emailAddress,
                                    hintText: 'Enter UPI ID',
                                    height: bigButtonHeight,
                                    prefixIcon: null,
                                  ),
                                  TextFieldLabelTextWidget(labelText: "Upload QR Code"),
                                  Consumer<RedeemPointsViewModel>(
                                      builder: (context,value,child){
                                        return Container(
                                          width: 125,
                                          height: 125,
                                          //margin: EdgeInsets.symmetric(horizontal: 15),
                                          alignment: Alignment.topCenter,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).scaffoldBackgroundColor,
                                            border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          ),
                                          child: Stack(
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 1 /1,
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                    child: (value.selectedFile != null)?
                                                    Image.file(value.selectedFile!,
                                                      fit: BoxFit.cover,
                                                    ):
                                                    Container()
                                                ),
                                              ),
                                              AspectRatio(
                                                  aspectRatio: 1 /1,
                                                  child: Align(
                                                    alignment: (context.locale == Locale('ur'))?
                                                    Alignment.center:
                                                    Alignment.center,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        value.getImage();
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(context).canvasColor,
                                                            border: Border.all(width: 1, color: Theme.of(context).textTheme.caption!.color!),
                                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                                        ),
                                                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                                        child: Icon((value.selectedFile == null)?Icons.add:Icons.edit,
                                                          color: Theme.of(context).textTheme.caption!.color,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),
                                        );

                                      }
                                  ),
                                ],
                              );
                            }else{
                              return Container();
                            }


                          }
                      ),

                      SizedBox(height: verticalSpaceMedium),
                      Consumer<RedeemPointsViewModel>(
                          builder: (context,value,child){
                            if(value.sendMoneyTo != null){
                              return ButtonBig(
                                onTap: (){

                                  if(_formKey.currentState!.validate()){
                                    String? accountDetails = "${bankNameController.text} || ${confirmAccountNumberController.text} || ${ifscController.text}";
                                    var data = {
                                      'redeemPoints': pointsController.text.toString(),
                                      'upiID': (value.sendMoneyTo == "upi")?upiController.text.toString():"-",
                                      'bankAccountDetails': (value.sendMoneyTo == "bank")?accountDetails.toString() : "-"
                                    };
                                    print("this is mutipart data ${data}");
                                    print("this is image ${value.selectedFile}");
                                    value.redeemPoints(data, context, headers, "QRCODE", value.selectedFile);
                                  }
                                },
                                height: bigButtonHeight,
                                width: context.deviceWidth,
                                backgroundColor: Theme.of(context).primaryColor,
                                text: 'REDEEM',
                                showProgress: value.loading,
                                radius: radiusValue,
                                fontSize: 14,
                                letterspacing: 0.2,
                                textPadding: 0,
                                progressColor: colorLightWhite,
                                progressStrokeWidth: 1.5,
                              );
                            }else{
                              return Container();
                            }

                          }
                      ),

                      SizedBox(height: verticalSpaceSmall),

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




