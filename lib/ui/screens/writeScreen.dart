import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonBigWithIcon.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/stickydemopage.dart';
import 'package:lekhny/ui/widget/write%20page%20widget/writePageOptionWidget.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';

class WriteScreen extends StatefulWidget {
  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  //const WriteScreen({Key? key}) : super(key: key);

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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              titleSpacing: 0,
              automaticallyImplyLeading: false,
              elevation: 1,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text('write'.tr().toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: context.deviceWidth,
                    decoration: BoxDecoration(
                      color: primaryColor
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: verticalSpaceLarge),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('writeTagline'.tr().toString(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: colorLightWhite,),
                            textAlign: TextAlign.center,
                            softWrap: false,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: verticalSpaceSmall),
                        ButtonBigWithIcon(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesName.textEditorScreen,
                                arguments: {"postId" : null, "isContest" : '2', "contestId": null, "data": "", "mainPostId": null }
                            );
                          },
                          height: 36,
                          width: 120,
                          backgroundColor: colorLightWhite,
                          textColor: primaryColor,
                          text: 'write'.tr().toString(),
                          showProgress: false,
                          radius: radiusValue,
                          fontSize: 14,
                          letterspacing: 0.2,
                          icon: Icons.edit_note_outlined,
                          iconColor: primaryColor,
                          iconWidth: 5,
                          iconSize: 20,

                        ),
                        SizedBox(height: verticalSpaceLarge),
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpaceSmall),
                  WritePageOptionWidget(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.dailyCompetitionScreen);

                      },
                      icon: Icons.wine_bar_outlined,
                      iconColor: Theme.of(context).textTheme.subtitle1!.color,
                      iconsSize: 24,
                      text: 'takePart'.tr().toString(),
                  ),
                  WritePageOptionWidget(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.draftScreen);
                      },
                      icon: Icons.archive_outlined,
                      iconColor: Theme.of(context).textTheme.subtitle1!.color,
                      iconsSize: 24,
                      text: 'unpublishedPosts'.tr().toString(),
                  ),
                  WritePageOptionWidget(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.publishedPostsScreen);
                      },
                      icon: Icons.add,
                      iconColor: Theme.of(context).textTheme.subtitle1!.color,
                      iconsSize: 24,
                      text: 'editAddPartsPosts'.tr().toString(),
                  ),
                  WritePageOptionWidget(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.publishedSeriesScreen);
                      },
                      icon: Icons.bookmark_add_outlined,
                      iconColor: Theme.of(context).textTheme.subtitle1!.color,
                      iconsSize: 24,
                      text: 'editAddPartsSeries'.tr().toString(),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
