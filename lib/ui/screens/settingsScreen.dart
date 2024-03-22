import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/services/authServices/signUpWithGoogle.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBar.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/iconCircle.dart';
import 'package:lekhny/ui/global%20widgets/mainAppBar.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/bottomNavigationBarScreen.dart';
import 'package:lekhny/ui/screens/loginScreen.dart';
import 'package:lekhny/ui/widget/settings%20page%20widget/changeThemeSwitchWidget.dart';
import 'package:lekhny/ui/widget/settings%20page%20widget/rowWidget.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  //const SettingsScreen({Key? key}) : super(key: key);

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
            //resizeToAvoidBottomInset: true,
            appBar: MainappBarWidget(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                //height: context.actualHeight,
                padding: EdgeInsets.only(left: 18, right: 18, bottom: verticalSpaceMedium),
                child: Column(
                  children: [
                    //SizedBox(height: context.appBarHeight-context.safeAreaHeight),
                    Text('Settings',
                        style: Theme.of(context).textTheme.headline4
                    ),
                    SizedBox(height: verticalSpaceLarge),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("App Settings",
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: verticalSpaceExtraSmall),
                    Container(
                      height: bigButtonHeight,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.all(Radius.circular(radiusValue))

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.dark_mode_outlined,
                                size: 20,
                              ),
                              SizedBox(width: 15),
                              Text("Dark Mode",
                                style: Theme.of(context).textTheme.subtitle2,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            child: ChangeThemeButtomWidget(),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(height: verticalSpaceExtraSmall),
                    // Container(
                    //   height: bigButtonHeight,
                    //   padding: EdgeInsets.only(left: 15, right: 15),
                    //   decoration: BoxDecoration(
                    //       color: Theme.of(context).canvasColor,
                    //       borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                    //
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Icon(Icons.notifications_none_rounded,
                    //             size: 20,
                    //           ),
                    //           SizedBox(width: 15),
                    //           Text("Push Notifications",
                    //             style: Theme.of(context).textTheme.subtitle2,
                    //             textAlign: TextAlign.center,
                    //           ),
                    //         ],
                    //       ),
                    //       Container(
                    //         width: 40,
                    //         child: Switch(
                    //             activeColor: darkModeHighlightColor,
                    //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //             value: true,
                    //             onChanged: (value){
                    //
                    //             }),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: verticalSpaceExtraSmall),
                    // RowWidget(
                    //     onTap: (){},
                    //     icons: Icons.outlined_flag_rounded,
                    //     labelText: "Languages"),
                    SizedBox(height: verticalSpaceSmall),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Account",
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){},
                        icons: Icons.person_outline_outlined,
                        labelText: "Account Settings"),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.changePasswordScreen);
                        },
                        icons: Icons.lock_person_outlined,
                        labelText: "Change Password"),
                    SizedBox(height: verticalSpaceSmall),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("Wallet & Payment",
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.pointsScreen);
                        },
                        icons: Icons.account_balance_wallet_outlined,
                        labelText: "Lekhny Points"),
                    SizedBox(height: verticalSpaceSmall),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text("About Lekhny",
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){
                          launchUrlStart(url: "https://lekhny.com");
                        },
                        icons: Icons.language_rounded,
                        labelText: "Lekhny.com"),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){},
                        icons: Icons.help_outline,
                        labelText: "Help Center"),
                    SizedBox(height: verticalSpaceExtraSmall),
                    RowWidget(
                        onTap: (){},
                        icons: Icons.bug_report_outlined,
                        labelText: "Bug Report"),
                    SizedBox(height: verticalSpaceMedium),
                    GestureDetector(
                      onTap: (){

                        logOutDialog(context);

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
                      },
                      child: ButtonBig(
                          height: bigButtonHeight,
                          width: double.infinity,
                          backgroundColor: primaryColor,
                          text: 'LOG OUT',
                          showProgress: false,
                          radius: radiusValue,
                          textPadding: 0,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        )
    );
  }

  Future<void> logOutDialog (BuildContext context){
    return  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Log Out",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text("Are you sure ?",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonBig(
                onTap: (){
                  final sharedPreferencesViewModel = Provider.of<SharedPreferencesViewModel>(context, listen: false);
                  sharedPreferencesViewModel.removeToken();
                  SignUpWithGoogle().signOut().then((value){
                    Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
                  });
                },
                width: 75,
                height: 40,
                backgroundColor: Theme.of(context).canvasColor,
                text: "Yes",
                showProgress: false,
                radius: radiusValue,
                textColor: Theme.of(context).textTheme.titleSmall!.color,
                textPadding: 0,
              ),
              const SizedBox(width: 40),
              ButtonBig(
                onTap: (){
                  Navigator.pop(context);
                },
                width: 75,
                height: 40,
                backgroundColor: primaryColor,
                text: "No",
                showProgress: false,
                radius: radiusValue,
                textColor: colorLightWhite,
                textPadding: 20,
              ),
            ],
          ),

        ],
      ),
    );
  }

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
