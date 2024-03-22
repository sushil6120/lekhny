import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookListBuilder.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/coloredVerticalSpace.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/topTenWritersScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';

class LekhnyTrophySystemScreen extends StatefulWidget {
  @override
  State<LekhnyTrophySystemScreen> createState() => _LekhnyTrophySystemScreenState();
}

class _LekhnyTrophySystemScreenState extends State<LekhnyTrophySystemScreen> {
  //const LekhnyTrophySystemScreen({Key? key}) : super(key: key);

  final List<String> items = [
    'English',
    'हिन्दी',
    'اردو',
  ];

  String? selectedValue;

  List<int> list = [1, 2, 3, 4, 5];

  static final customCacheManager = CacheManager(
      Config(
          'customCacheKey',
          stalePeriod: const Duration(days: 15),
          maxNrOfCacheObjects: 100
      )
  );
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    selectedValue = (context.locale == Locale('en'))?'English':
    (context.locale == Locale('hi'))?'हिन्दी':(context.locale == Locale('ur'))?'اردو':' ';
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarBackButton(),
                  //SizedBox(width: 30),
                  Text('Lekhny Trophy System',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(Icons.search_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: lekhnyTrophyDemoData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: context.deviceWidth,
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right:15),
                      margin: (index==0)?EdgeInsets.only(top: verticalSpaceSmall,bottom: verticalSpaceSmall, left: 15, right: 15):
                      EdgeInsets.only(bottom: verticalSpaceSmall, left: 15, right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                        border: Border.all(width: 1, color: lekhnyTrophyDemoData[index]['color']),
                        // gradient: LinearGradient(
                        //   colors: [Theme.of(context).scaffoldBackgroundColor,Theme.of(context).b ],
                        //   // radius: 0.7,
                        //   // focal: Alignment(0.2, -0.1),
                        //   begin: Alignment.bottomRight,
                        //   end: Alignment.topLeft,
                        //
                        //   tileMode: TileMode.clamp,
                        // ),
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment : Alignment.center,
                            child: Text('LEVEL ${index+1}',
                              style: Theme.of(context).textTheme.overline!.copyWith(
                                color: lekhnyTrophyDemoData[index]['color']
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${lekhnyTrophyDemoData[index]['level']}',
                                    style: Theme.of(context).textTheme.subtitle1,
                                  ),
                                  SizedBox(height: 5),
                                  Text('${lekhnyTrophyDemoData[index]['trophy']}',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  SizedBox(height: verticalSpaceSmall2),
                                  Text('Get Trophies',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        color: Theme.of(context).textTheme.headline6!.color
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text('${lekhnyTrophyDemoData[index]['getTrophies']}',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 60,
                                width : 60,
                                child: SvgPicture.asset(trophyOutlineBlack,
                                  color: lekhnyTrophyDemoData[index]['color']
                                ),
                              ),


                            ],
                          ),
                          // SizedBox(height: verticalSpaceSmall2),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>TopTenWriters()));
                          //   },
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text('Top 10 Writers Of Level 1',
                          //       style: Theme.of(context).textTheme.caption!.copyWith(
                          //           color: primaryColor
                          //       ),
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                    );
                  },
                ),
              ),
              //SizedBox(height: verticalSpaceSmall),

            ],
          )
      ),
    );
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
