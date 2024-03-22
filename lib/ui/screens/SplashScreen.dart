import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/services/loginStatusService.dart';
import 'package:lekhny/utils/images.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  LoginStatusService loginStatusService = LoginStatusService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //loginStatusService.checkAuthention(context);
    loginStatusService.checkIsInstalled(context);
  }

  @override
  Widget build(BuildContext context) {

    final themeManager = Provider.of<ThemeManager>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Theme.of(context).brightness,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Theme.of(context).brightness
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(lekhnyLogoEnglish),
                      fit: BoxFit.contain
                  )
              ),
            ),
          )
        )
    );
  }
}