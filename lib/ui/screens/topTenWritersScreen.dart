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

class TopTenWriters extends StatefulWidget {
  @override
  State<TopTenWriters> createState() => _TopTenWritersState();
}

class _TopTenWritersState extends State<TopTenWriters> {
  //const TopTenWriters({Key? key}) : super(key: key);

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
                  Text('Lekhny Sadasay Writers',
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
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   height: 55,
              //   decoration: BoxDecoration(
              //     color: Theme.of(context).cardColor
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       SizedBox(
              //         width: context.deviceWidth*0.2,
              //         child: Text('Author',
              //           style: Theme.of(context).textTheme.subtitle2,
              //         ),
              //       ),
              //       SizedBox(
              //         width: context.deviceWidth*0.15,
              //         child: Text('Likes',
              //           style: Theme.of(context).textTheme.subtitle2,
              //         ),
              //       ),
              //       SizedBox(
              //         width: context.deviceWidth*0.15,
              //         child: Text('Posts',
              //           style: Theme.of(context).textTheme.subtitle2,
              //         ),
              //       ),
              //       SizedBox(
              //         width: context.deviceWidth*0.22,
              //         child: Text('Followers',
              //           style: Theme.of(context).textTheme.subtitle2,
              //         ),
              //       ),
              //       SizedBox(
              //         width: context.deviceWidth*0.15,
              //         child: Text('Trophy',
              //           style: Theme.of(context).textTheme.subtitle2,
              //           textAlign: TextAlign.end,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: context.deviceWidth,
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right:15),
                      margin: (index==0)?EdgeInsets.only(bottom: verticalSpaceSmall2):
                      EdgeInsets.only(bottom: verticalSpaceSmall2),
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                       // border: Border.all(width: 1, color: lekhnyTrophyDemoData[index]['color']),
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
                      child: Row(
                       children: [
                         Text('${index+1}'),
                         SizedBox(width: 15),
                         Container(
                             height: 60,
                             width: 60,
                             child: CircleAvatar(
                               foregroundImage: NetworkImage('https://www.siliconindia.com/news/newsimages/special/xbq2g5fZ.jpeg',
                               ) ,
                             )
                         ),
                         SizedBox(width: 15),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('Arundhati Roy',
                               style: Theme.of(context).textTheme.subtitle2,
                             ),
                             SizedBox(height: 8),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: [
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text('38',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                     Text('Posts',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                   ],
                                 ),
                                 SizedBox(width: 12),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text('59',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                     Text('Likes',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                   ],
                                 ),
                                 SizedBox(width: 12),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text('12k',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                     Text('Followers',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                   ],
                                 ),
                                 SizedBox(width: 12),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                     Text('20',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                     Text('Trophy',
                                       style: Theme.of(context).textTheme.caption,
                                     ),
                                   ],
                                 ),
                               ],
                             ),
                           ],
                         ),
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
