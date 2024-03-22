import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/screens/loginScreen.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  //const OnboardingScreen({Key? key}) : super(key: key);

  PageController pageController = PageController();

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
            //extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Container(
                  height: context.deviceHeight*0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: context.deviceHeight*0.7,
                        child: PageView(
                          controller: pageController,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: context.deviceHeight*0.015),
                                Container(
                                  //color: Colors.grey,
                                  height: context.deviceHeight*0.4,
                                  width: context.deviceWidth*1,
                                  child: SvgPicture.asset(onboardingScreenImage1),
                                ),
                                Column(
                                  children: [
                                    Text('Lekhny',
                                      style: Theme.of(context).textTheme.headline5
                                    ),
                                    SizedBox(height: headingVerticalSpace),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: Text("Lekhny, a book reading and writting app, connects a global community of million readers and writers through the power of story.",
                                        style: Theme.of(context).textTheme.bodyText2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: context.deviceHeight*0.015),
                                Container(
                                  height: context.deviceHeight*0.4,
                                  width: context.deviceWidth*1,
                                  child: SvgPicture.asset(onboardingScreenImage2),
                                ),
                                Column(
                                  children: [
                                    Text('Read & Write',
                                        style: Theme.of(context).textTheme.headline5
                                    ),
                                    SizedBox(height: headingVerticalSpace),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: Text("With Lekhny make"
                                          " own profile and share your books and achievements with the world.",
                                        style: Theme.of(context).textTheme.bodyText2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: context.deviceHeight*0.015),
                                Container(
                                  height: context.deviceHeight*0.4,
                                  width: context.deviceWidth*1,
                                  child: SvgPicture.asset(onboardingScreenImage3),
                                ),
                                Column(
                                  children: [
                                    Text('Earn Points',
                                        style: Theme.of(context).textTheme.headline5
                                    ),
                                    SizedBox(height: headingVerticalSpace),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20, right: 20),
                                      child: Text("If you know how to write then this is a golden opportunity for you. Here you can earn points and redeem by writing",
                                        style: Theme.of(context).textTheme.bodyText2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    alignment: Alignment(0,.65) ,
                    child: SmoothPageIndicator(
                        effect: CustomizableEffect(
                            dotDecoration: DotDecoration(
                              height: 8,
                              width: 8,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: colorLight2,
                            ),
                            activeDotDecoration: DotDecoration(
                                height: 10,
                                width: 10,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: primaryColor
                            )),
                        controller: pageController,
                        count: 3
                    )),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: bottomMargin),
              padding: EdgeInsets.only(left: 20, right: 20,),
              height: bigButtonHeight,
              width: double.infinity,
              child: FloatingActionButton(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                ),
                onPressed: (){
                 Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
                },
                child: Text('GET STARTED',
                  style: Theme.of(context).textTheme.button
                ),
                backgroundColor: primaryColor,
                heroTag: 'showUserLocation',
              ),
            ),
          ),
        ));
  }
}
