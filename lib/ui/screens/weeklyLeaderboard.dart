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
import 'package:lekhny/ui/screens/mostFollowersScreen.dart';
import 'package:lekhny/ui/screens/mostLikesScreen.dart';
import 'package:lekhny/ui/screens/mostPostsScreen.dart';
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

class WeeklyLeaderboardScreen extends StatefulWidget {
  @override
  State<WeeklyLeaderboardScreen> createState() => _WeeklyLeaderboardScreenState();
}

class _WeeklyLeaderboardScreenState extends State<WeeklyLeaderboardScreen> with TickerProviderStateMixin  {
  //const WeeklyLeaderboardScreen({Key? key}) : super(key: key);

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
    TabController tabController =TabController(length: 3, vsync:this);
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
                  Text('lekhnyWeeklyRank'.tr().toString(),
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
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.symmetric(horizontal: BorderSide(
                      width: 0.1, color: Theme.of(context).textTheme.headline6!.color!)
                      ),
                  color: Theme.of(context).canvasColor,
                ),
                width: double.infinity,

                child: TabBar(
                    labelColor: Theme.of(context).textTheme.button!.color,
                    indicatorPadding: EdgeInsets.symmetric(vertical: 12),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: primaryColor,
                    ),
                    unselectedLabelColor: Theme.of(context).textTheme.headline6!.color,
                    controller: tabController,
                    tabs: [
                      Tab(icon: Text('mostPosts'.tr().toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            //color: primaryColor
                        ),
                      )),
                      Tab(icon: Text('mostLikes'.tr().toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                      )),
                      Tab(icon: Text('mostFollowers'.tr().toString(),
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ]
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height-(context.appBarHeight+context.safeAreaHeight+55),
                child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: const [
                      MostPosts(),
                      MostLikes(),
                      MostFollowers(),
                    ]
                ),
              ),
            ],
          )
      ),
    );
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
