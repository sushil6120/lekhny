import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:lekhny/utils/animations.dart';
import 'package:lekhny/utils/extensions.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/followUnfollowViewModel.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookListBuilder.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/coloredVerticalSpace.dart';
import 'package:lekhny/ui/global%20widgets/iosProgressIndicatorWidget.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/lekhnyTrophySystemScreen.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/weeklyLeaderboard.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/homePageViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:html2md/html2md.dart' as html2md;

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({Key? key}) : super(key: key);

  bool isFabVisible = false;
  bool scrollToIndex = false;
  final itemKey = GlobalKey();
  final scrollController = ScrollController();
  DateTime date = DateTime.now();
  String? text;


  List<String?>? week;
  List<String?>? week2;

  List<String?> weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  List<String?> weekDaysShort = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  List<String?> weekDaysShortHindi = ["सोमवार", "मंगलवार", "बुधवार", "गुरुवार", "शुक्रवार", "शनिवार"];
  List<String?> weekDaysShortUrdu = ["پیر", "منگل", "بدھ", "جمعرات", "جمعہ", "ہفتہ"];

  final List<String> items = [
    'English',
    'हिन्दी',
    'اردو',
  ];

  String? selectedValue;

  List<int> list = [1, 2, 3, 4, 5];

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  HomePageViewModel homePageViewModel = HomePageViewModel();

  // static final customCacheManager = CacheManager(
  //   Config(
  //       'customCacheKey',
  //       stalePeriod: const Duration(days: 15),
  //       maxNrOfCacheObjects: 100
  //   )
  // );

  String? appLanguage;
  String? imageBaseUrl;
  String? dailyTopicsImageBaseUrl;
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
          'Content-Type': 'text/plain',
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print(" this is token ${value.toString()}");
        homePageViewModel.gethomePageData(null, headers, 1);
        print("init is working");
        print("${date} date is");
        homePageViewModel.setDailyWinnerTappedIndex(date.weekday -1);
        homePageViewModel.getDailyCompetitionWinnersData(null, headers, "${date.weekday}");

        if(date.weekday > 4){
          scrollToIndex = true;
        }

      });
    });



    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeManager = Provider.of<ThemeManager>(context);

    dailyTopicsImageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishDailyCompImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiDailyCompImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduDailyCompImagebaseUrl:AppUrl.hindiDailyCompImagebaseUrl;

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    week = (context.locale == Locale('en'))?weekDaysShort:
    (context.locale == Locale('hi'))?weekDaysShortHindi:(context.locale == Locale('ur'))?weekDaysShortUrdu:weekDaysShort;

    week2 = (context.locale == Locale('en'))?weekDays:
    (context.locale == Locale('hi'))?weekDaysShortHindi:(context.locale == Locale('ur'))?weekDaysShortUrdu:weekDays;

    selectedValue = (context.locale == Locale('en'))?'English':
    (context.locale == Locale('hi'))?'हिन्दी':(context.locale == Locale('ur'))?'اردو':' ';
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
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text('home'.tr().toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          //underline: Divider(height: 2, color: primaryColor,),
                          selectedItemHighlightColor: Theme.of(context).canvasColor,
                          selectedItemBuilder: (BuildContext conetxt){
                            return <Widget>[
                              Center(
                                child: Text('English',
                                  style: TextStyle(
                                    color: primaryColor
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('हिन्दी',
                                  style: TextStyle(
                                      color: primaryColor
                                  ),
                                ),
                              ),
                              Center(
                                child: Text('اردو',
                                  style: TextStyle(
                                      color: primaryColor
                                  ),
                                ),
                              ),

                            ];
                          },
                          icon: const Icon(Icons.arrow_drop_down_rounded,
                          ),
                          style: Theme.of(context).textTheme.bodyText2,
                          hint: Text(selectedValue.toString()),
                          items: items
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            selectedValue = value as String;
                            if(selectedValue == 'English'){
                              //context.locale = Locale('en');
                              context.setLocale(const Locale('en'));
                              sharedPreferencesViewModel.saveLanguage('3');
                              Phoenix.rebirth(context);
                              //Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false );

                            }else if(selectedValue == 'हिन्दी'){
                              context.setLocale(const Locale('hi'));
                              sharedPreferencesViewModel.saveLanguage('2');
                              Phoenix.rebirth(context);
                              //Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false );

                            }else if(selectedValue == 'اردو'){
                              context.setLocale(const Locale('ur'));
                              sharedPreferencesViewModel.saveLanguage('4');
                              Phoenix.rebirth(context);
                              //Navigator.pushNamedAndRemoveUntil(context, RoutesName.bottomNavigationBarScreen, (route) => false );

                            }
                          },
                          buttonSplashColor: Colors.transparent,
                          buttonHighlightColor: Colors.transparent,
                          //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
                          iconSize: 24,
                           iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
                          // iconDisabledColor: Colors.grey,
                          buttonHeight: 25,
                          buttonWidth: 90,
                          buttonPadding: EdgeInsets.only(left: 0, right: 0),
                          // buttonDecoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(radiusValue),
                          //   border: Border.all(
                          //     color: Theme.of(context).textTheme.bodyText1!.color!,
                          //   ),
                          //   color: Colors.transparent,
                          // ),
                          //buttonElevation: 2,
                          itemHeight: 40,
                          //itemPadding: const EdgeInsets.only(left: 15, right: 15),
                          dropdownMaxHeight: 150,
                          dropdownWidth: 120,
                          dropdownPadding: null,
                          dropdownDecoration: BoxDecoration(
                            // border: Border(
                            //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
                            // ),
                            borderRadius: BorderRadius.circular(radiusValue),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          dropdownElevation: 1,
                          //scrollbarRadius: const Radius.circular(40),
                          //scrollbarThickness: 6,
                          //scrollbarAlwaysShow: true,
                          offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
                        ),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RoutesName.notificationScreen);
                        },
                        child: Icon(
                          Icons.notifications_outlined,color: Theme.of(context).textTheme.headline4!.color,
                        ),
                      ),
                      SizedBox(width: 15),
                      Consumer<SearchScreenViewModel>(builder: (BuildContext context, value, Widget? child){
                        return GestureDetector(
                          onTap: (){
                            value.textFieldLength = 0;
                            Navigator.pushNamed(context, RoutesName.searchScreen);
                          },
                          child: Icon(
                            Icons.search_rounded,color: Theme.of(context).textTheme.headline4!.color,
                          ),
                        );
                      }),

                    ],
                  ),
                ],
              ),
            ),
          ),
          body: ChangeNotifierProvider<HomePageViewModel>(
            create: (BuildContext context)=> homePageViewModel,
            child: Consumer<HomePageViewModel>(
                builder: (context,value,child){
                  //print('satus ${value.homePageData.status}');
                  //print('value ${value.homePageData.data![0]!.data!.length}');
                  switch(value.homePageData.status){
                    case Status.LOADING :
                      return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )
                      );

                    case Status.ERROR :
                      return Text('${value.homePageData.message.toString()} this is the error');

                    case Status.COMPLETED :
                      return NotificationListener<UserScrollNotification>(
                        onNotification: (notification){

                          if(scrollToIndex == true){
                            scrollController.jumpTo(50*4);
                            scrollToIndex = false;
                          }


                          if(notification.direction == ScrollDirection.forward){
                            if(!isFabVisible) {
                              setState(() {
                                isFabVisible =true;
                              });
                            }
                          }else if (notification.direction == ScrollDirection.reverse){
                            if(isFabVisible) {
                              setState(() {
                                isFabVisible =false;
                              });
                            }
                          }
                          return true;
                        },
                        child: RefreshIndicator(
                          strokeWidth: 2,
                          color: primaryColor,
                          backgroundColor: Theme.of(context).canvasColor,
                          onRefresh: ()async{
                            // homePageViewModel.gethomePageData(null, headers);
                            // print("init is working");
                            // print("${date} date is");
                            // homePageViewModel.setDailyWinnerTappedIndex(date.weekday -1);
                            // homePageViewModel.getDailyCompetitionWinnersData(null, headers, "${date.weekday}");
                            Phoenix.rebirth(context);

                            // if(date.weekday > 4){
                            //   scrollToIndex = true;
                            // }

                          },
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                     color: primaryColor,
                                      // gradient: LinearGradient(
                                      //     colors: [
                                      //       primaryColor,
                                      //       Colors.transparent,
                                      //     ],
                                      //     stops: [0.0, 1.0],
                                      //     begin: (context.locale == Locale('ur'))?FractionalOffset.centerRight:FractionalOffset.centerLeft,
                                      //     end: (context.locale == Locale('ur'))?FractionalOffset.centerLeft:FractionalOffset.centerRight,
                                      //     tileMode: TileMode.clamp
                                      // ),
                                    borderRadius: BorderRadius.circular(radiusValue)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('greetings'.tr().toString(),
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                  color: colorLightWhite
                                              )
                                          ),
                                          SizedBox(height: 5),
                                          Text("${value.userProfileModel!.data![0].name}",
                                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                color: colorLightWhite
                                              )
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 80,
                                        width: 105,
                                        child: SvgPicture.asset(
                                            bookReadingHomePage,
                                            matchTextDirection: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [(themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight, Theme.of(context).canvasColor],
                                      radius: 0.75,
                                      focal: Alignment(0.7, -0.7),
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: verticalSpaceSmall),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('6DayHeading'.tr().toString(),
                                            style: Theme.of(context).textTheme.subtitle1,
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              String? text1 = value.dailyCompetitionRulesModel!.data![0].rule;
                                              String? text2 = text1!.replaceAll("<br>", "\n");
                                              text = html2md.convert(text2).replaceAll("*", "");
                                              showRules(text!);
                                            },
                                            child: Icon(Icons.help_outline_rounded,
                                              size: 18,
                                              color: primaryColor,
                                            ),
                                          )

                                        ],
                                      ),
                                      SizedBox(height: verticalSpaceExtraSmall),
                                      Text('6DayBody'.tr().toString(),
                                        style: Theme.of(context).textTheme.bodyText2,
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: verticalSpaceMedium),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: List.generate(6, (index){
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        color: (value.sixDayStreakResponse["data"]["${index+1}"] == 1)?primaryColor:Theme.of(context).canvasColor,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(width: 1, color: Colors.black)
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Text("${week![index]}",
                                                      style: Theme.of(context).textTheme.caption
                                                  ),
                                                ],
                                              );

                                            })
                                        ),
                                      ),
                                      SizedBox(height: verticalSpaceMedium),

                                      // Align(
                                      //   alignment: Alignment.center,
                                      //   child: ButtonBig(
                                      //     height: 30,
                                      //     width: 80,
                                      //     backgroundColor: primaryColor,
                                      //     text: 'Enter Now',
                                      //     showProgress: false,
                                      //     radius: radiusValue,
                                      //     fontSize: 12,
                                      //     letterspacing: 0,
                                      //     textPadding: 0,
                                      //   ),
                                      // )
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, RoutesName.dailyCompetitionScreen);
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text('enterNow'.tr().toString(),
                                            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                // ListView.builder(
                                //   physics: BouncingScrollPhysics(),
                                //   shrinkWrap: true,
                                //   scrollDirection: Axis.horizontal,
                                //   itemCount: 6,
                                //   itemBuilder: (BuildContext context, int index) {
                                //     return Padding(
                                //       padding: EdgeInsets.symmetric(horizontal: 8),
                                //       child: Column(
                                //         children: [
                                //           Container(
                                //             height: 25,
                                //             width: 25,
                                //             decoration: BoxDecoration(
                                //                 color: primaryColor,
                                //                 shape: BoxShape.circle,
                                //                 border: Border.all(width: 1, color: Colors.black)
                                //             ),
                                //           ),
                                //           SizedBox(height: 10,),
                                //           Text("${weekDays[index]}",
                                //             style: Theme.of(context).textTheme.overline!.copyWith(
                                //                 letterSpacing: 0
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     );
                                //   },
                                // ),

                                (value.readingHistoryModel!.data!.isNotEmpty)?
                                BookListContainer(
                                  listViewHeight: 222,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'yourReads'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                              "heading" : 'yourReads'.tr().toString(),
                                              "id" : "1",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: (value.readingHistoryModel!.data!.length > 7)? 7:value.readingHistoryModel!.data!.length ,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                        child: BookWidget(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                  arguments: {"postId" : value.readingHistoryModel!.data![index].postID.toString() }
                                              );
                                            },
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            showParts: false,
                                            showViews: true,
                                            showBookTitle: true,
                                            showWriter: true,
                                            partsValue: demoData[index]["parts"],
                                            partsSpace: 0,
                                            imgSpace: 10,
                                            imageHeight: 100,
                                            imageWidth: 150,
                                            imgUrl: "${imageBaseUrl}${value.readingHistoryModel!.data![index].bookCover}",
                                            viewsValue: value.readingHistoryModel!.data![index].views.toString(),
                                            bookTextWidth: 100,
                                            bookName: value.readingHistoryModel!.data![index].title,
                                            bookNameSpace: 4,
                                            writerTextWidth: 100,
                                            writerName: value.readingHistoryModel!.data![index].author
                                        ),
                                      );
                                    },
                                  ),
                                ):Container(),
                                BookListContainer(
                                  listViewHeight: 222,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'readersChoice'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                          "heading" : 'readersChoice'.tr().toString(),
                                              "id" : "2",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.topPostsModel!.data!.topStory!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                        child: BookWidget(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                  arguments: {"postId" : value.topPostsModel!.data!.topStory![index].postID.toString()}
                                              );

                                            },
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            showParts: false,
                                            showViews: true,
                                            showBookTitle: true,
                                            showWriter: true,
                                            partsValue: "",
                                            partsSpace: 0,
                                            imgSpace: 10,
                                            imageHeight: 100,
                                            imageWidth: 150,
                                            imgUrl: "${imageBaseUrl}${value.topPostsModel!.data!.topStory![index].bookCover}",
                                            viewsValue: "${value.topPostsModel!.data!.topStory![index].views}",
                                            bookTextWidth: 100,
                                            bookName: "${value.topPostsModel!.data!.topStory![index].title}",
                                            bookNameSpace: 4,
                                            writerTextWidth: 100,
                                            writerName: "${value.topPostsModel!.data!.topStory![index].author}"
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      HeadingRowWidget(
                                          headingText: 'specialForYou'.tr().toString(),
                                          textButton: 'seeAll'.tr().toString(),
                                          showTextButton: true,
                                          onTap: (){
                                            Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                                arguments: {
                                                  "heading" : 'specialForYou'.tr().toString(),
                                                  "id" : "3",
                                                  "topicId" : ""
                                                }
                                            );
                                          }
                                      ),
                                      SizedBox(height: verticalSpaceSmall),
                                      Container(
                                        height: 180,
                                        //color: Colors.red,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: value.topPicksModel!.data!.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.topPicksModel!.data![index].postID.toString() }
                                                );
                                              },
                                              child: Stack(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Container(
                                                      alignment: Alignment.centerLeft,
                                                      width: context.deviceWidth*0.88,
                                                      decoration: BoxDecoration(
                                                        // gradient: LinearGradient(
                                                        //     begin: Alignment.centerLeft,
                                                        //     end: Alignment.centerRight,
                                                        //     //stops: [0.0,1.0],
                                                        //     colors: [
                                                        //       colorLight3,
                                                        //     Color(0xff7c6793),
                                                        //
                                                        //     ]),
                                                        color: (themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,
                                                        borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                      ),
                                                      height: 145,
                                                      padding: (context.locale == Locale('ur'))?EdgeInsets.only(right: 140, left: 15):EdgeInsets.only(left: 140, right: 15),
                                                      margin: (context.locale == Locale('ur'))?
                                                      (index== 0)?EdgeInsets.only(left: 15, right: 15,):EdgeInsets.only(left: 15):
                                                      (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
                                                      child: Padding(
                                                        padding: EdgeInsets.only(bottom: 20,top: 20),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                // Text("TOP PICK",
                                                                //   style: Theme.of(context).textTheme.overline!.copyWith(
                                                                //     color: (themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor:secondaryColor,
                                                                //   ),
                                                                // ),
                                                                SizedBox(
                                                                  child: Text("${value.topPicksModel!.data![index].bookTitle}",
                                                                    style: Theme.of(context).textTheme.subtitle1,
                                                                    textAlign: TextAlign.start,
                                                                    softWrap: true,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),
                                                                SizedBox(height: 4),
                                                                SizedBox(
                                                                  child: Text("${value.topPicksModel!.data![index].writer}",
                                                                    style: Theme.of(context).textTheme.caption,
                                                                    textAlign: TextAlign.start,
                                                                    softWrap: false,
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                  ),
                                                                ),

                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Icon(Icons.remove_red_eye_outlined,
                                                                      size: 14,
                                                                      color: Theme.of(context).disabledColor,
                                                                    ),
                                                                    SizedBox(width: 2),
                                                                    Text("${value.topPicksModel!.data![index].totalViwers}",
                                                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(width: 15),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Icon(Icons.thumb_up_alt_outlined,
                                                                      size: 14,
                                                                      color: Theme.of(context).disabledColor,
                                                                    ),
                                                                    SizedBox(width: 2),
                                                                    Text("${value.topPicksModel!.data![index].totalLike}",
                                                                      style: Theme.of(context).textTheme.caption!.copyWith(
                                                                          letterSpacing: 0.5
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomLeft,
                                                    child: Container(
                                                      //margin: EdgeInsets.only(left: 30, top:5),
                                                      margin: (context.locale == Locale('ur'))?
                                                      (index==0)?EdgeInsets.only(right: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(right: 15, top:2,bottom: verticalSpaceSmall):
                                                      (index==0)?EdgeInsets.only(left: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:2,bottom: verticalSpaceSmall),
                                                      width: 110,
                                                      height: 160,
                                                      alignment: Alignment.topCenter,
                                                      decoration: BoxDecoration(
                                                        //color: Colors.red,
                                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                                color: Colors.black26,
                                                                spreadRadius: 0,
                                                                blurRadius: 5,
                                                                offset: Offset(0, 5)
                                                            )
                                                          ]
                                                      ),
                                                      child: AspectRatio(
                                                        aspectRatio: 1 /1.5,
                                                        child: ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                          child: CachedNetworkImage(
                                                            imageUrl: "${imageBaseUrl}${value.topPicksModel!.data![index].bookCoverImage}",
                                                            fit: BoxFit.fill,
                                                            alignment: Alignment.bottomCenter,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                BookListContainer(
                                  listViewHeight: 237,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'topSeries'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                              "heading" : 'topSeries'.tr().toString(),
                                              "id" : "4",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.topSeriesModel!.data!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                        child: BookWidget(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                  arguments: {"postId" : value.topSeriesModel!.data![index].postID.toString()}
                                              );
                                            },
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            showParts: true,
                                            showViews: true,
                                            showBookTitle: true,
                                            showWriter: true,
                                            partsValue: value.topSeriesModel!.data![index].ttoalPart.toString(),
                                            partsSpace: 4,
                                            imgSpace: 10,
                                            imageHeight: 100,
                                            imageWidth: 150,
                                            imgUrl: "${imageBaseUrl}${value.topSeriesModel!.data![index].bookCoverImage}",
                                            viewsValue: value.topSeriesModel!.data![index].totalViwers.toString(),
                                            bookTextWidth: 100,
                                            bookName: value.topSeriesModel!.data![index].bookTitle,
                                            bookNameSpace: 4,
                                            writerTextWidth: 100,
                                            writerName: value.topSeriesModel!.data![index].writer
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                BookListContainer(
                                  listViewHeight: 222,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'mostReadPosts'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                              "heading" : 'mostReadPosts'.tr().toString(),
                                              "id" : "5",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.mostReadPostsModel!.data!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                        child: BookWidget(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                  arguments: {"postId" : value.mostReadPostsModel!.data![index].id.toString()}
                                              );
                                            },
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            showParts: false,
                                            showViews: true,
                                            showBookTitle: true,
                                            showWriter: true,
                                            partsValue: "",
                                            partsSpace: 0,
                                            imgSpace: 10,
                                            imageHeight: 100,
                                            imageWidth: 150,
                                            imgUrl: "${imageBaseUrl}${value.mostReadPostsModel!.data![index].bookCover}",
                                            viewsValue: "${value.mostReadPostsModel!.data![index].totalviewes??0}",
                                            bookTextWidth: 100,
                                            bookName: "${value.mostReadPostsModel!.data![index].title}",
                                            bookNameSpace: 4,
                                            writerTextWidth: 100,
                                            writerName: "${value.mostReadPostsModel!.data![index].author}"
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                BookListContainer(
                                  listViewHeight: 222,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'newPosts'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                              "heading" : 'newPosts'.tr().toString(),
                                              "id" : "6",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.latestPostsModel!.data!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Container(
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                        child: BookWidget(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                  arguments: {"postId" : value.latestPostsModel!.data![index].postID.toString()}
                                              );
                                            },
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            showParts: false,
                                            showViews: true,
                                            showBookTitle: true,
                                            showWriter: true,
                                            partsValue: "",
                                            partsSpace: 0,
                                            imgSpace: 10,
                                            imageHeight: 100,
                                            imageWidth: 150,
                                            imgUrl: "${imageBaseUrl}${value.latestPostsModel!.data![index].bookCoverImage}",
                                            viewsValue: "${value.latestPostsModel!.data![index].totalViwers??0}",
                                            bookTextWidth: 100,
                                            bookName: "${value.latestPostsModel!.data![index].bookTitle}",
                                            bookNameSpace: 4,
                                            writerTextWidth: 100,
                                            writerName: "${value.latestPostsModel!.data![index].writer}"
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      //padding: EdgeInsets.only(top: 25, bottom: 25),
                                      margin: EdgeInsets.only(top: verticalSpaceSmall),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      child: Lottie.asset(confettiAnimation),
                                    ),
                                    Container(
                                      width: context.deviceWidth,
                                      padding: EdgeInsets.only(top: 25, bottom: 25),
                                      margin: EdgeInsets.only(top: verticalSpaceSmall),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          HeadingRowWidget(
                                              headingText: 'dailyContestWinners'.tr().toString(),
                                              textButton: 'seeAll'.tr().toString(),
                                              showTextButton: false,
                                              onTap: (){}
                                          ),
                                          SizedBox(height: verticalSpaceSmall),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  //color: Colors.grey,
                                                  height: 35,
                                                  child: ListView.builder(
                                                    key: itemKey,
                                                    controller: scrollController,
                                                    physics: BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: 6,
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return GestureDetector(
                                                        onTap: (){

                                                          // page = 1;
                                                          value.setDailyWinnerTappedIndex(index);
                                                          value.getDailyCompetitionWinnersData(null, headers, "${index+1}");
                                                          print("this is day ${index+1}");
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                                              color: (value.dailyWinnerTappedIndex == index)?primaryColor:Theme.of(context).scaffoldBackgroundColor
                                                          ),
                                                          margin: (context.locale == Locale('ur'))?
                                                          (index== 0)?EdgeInsets.only(left: 15, right: 15, top: 1,bottom: 1):EdgeInsets.only(left: 15, top: 1,bottom: 1):
                                                          (index==0)?EdgeInsets.only(left: 15, right: 15,top: 1,bottom: 1):EdgeInsets.only(right: 15, top: 1,bottom: 1),
                                                          padding: const EdgeInsets.symmetric(horizontal: 10,) ,
                                                          child: Text(
                                                            '${week2![index]}',
                                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                                color: (value.dailyWinnerTappedIndex == index)?colorLightWhite:Theme.of(context).textTheme.bodyText2!.color
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                (value.dailyWinnerLoading == true)?
                                                SizedBox(
                                                    height: 225,
                                                    child: IosProgressIndicatorWidget(Alignment.center, 0, primaryColor)
                                                ):
                                                (value.dailyCompetitionWinnersModel != null)?
                                                SizedBox(
                                                  height: 225,
                                                  child: (value.winnersList.isNotEmpty)?
                                                  ListView.builder(
                                                      physics: BouncingScrollPhysics(),
                                                      itemCount: value.winnersList!.length,
                                                      itemBuilder: (BuildContext context, int index){
                                                        return Padding(
                                                          padding: (index == 0)?EdgeInsets.only(left: 18.0, right: 18.0, top: verticalSpaceSmall, bottom:verticalSpaceSmall):
                                                          EdgeInsets.only(left: 18.0, right: 18.0, bottom: verticalSpaceSmall),
                                                          child: InkWell(
                                                            onTap: (){
                                                              // Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                              //     arguments: {"postId" : value.mainSearchModel!.data!.postBytitle![index].postID.toString()}
                                                              // );
                                                            },
                                                            child: Row(
                                                              children: [
                                                                BookWidget(
                                                                    onTap: (){},
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    showParts: false,
                                                                    showViews: false,
                                                                    showBookTitle: false,
                                                                    showWriter: false,
                                                                    partsValue: "",
                                                                    partsSpace: 0,
                                                                    imgSpace: 0,
                                                                    imageHeight: 65,
                                                                    imageWidth: 95,
                                                                    imgUrl: "${imageBaseUrl}${value.winnersList![index].bookCoverImage}",
                                                                    viewsValue: "",
                                                                    bookTextWidth: 95,
                                                                    bookName: "",
                                                                    bookNameSpace: 0,
                                                                    writerTextWidth: 95,
                                                                    writerName: ""
                                                                ),
                                                                SizedBox(width: 18),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text("${value.winnersList![index].category}",
                                                                        style: Theme.of(context).textTheme.caption!.copyWith(
                                                                          color: primaryColor
                                                                        )
                                                                    ),
                                                                    SizedBox(height: 2),
                                                                    SizedBox(
                                                                      width: context.deviceWidth- 150,
                                                                      child: Text("${value.winnersList![index].bookTitle}",
                                                                        style: Theme.of(context).textTheme.subtitle2,
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 5),
                                                                    Text("${value.winnersList![index].name}",
                                                                        style: Theme.of(context).textTheme.caption
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  ):
                                                  Center(child: Text("Winners will be announced soon"))
                                                  ,
                                                ):
                                                const SizedBox(
                                                  height: 225,
                                                  child: Center(child: Text("Something went wrong")),

                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                BookListContainer(
                                  listViewHeight: 140,
                                  headingWidget: HeadingRowWidget(
                                      headingText: 'dailyCompetitionsTopics'.tr().toString(),
                                      textButton: 'seeAll'.tr().toString(),
                                      showTextButton: true,
                                      onTap: (){
                                        Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                            arguments: {
                                              "heading" : 'dailyCompetitionsTopics'.tr().toString(),
                                              "id" : "7",
                                              "topicId" : ""
                                            }
                                        );
                                      }
                                  ),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: value.pastDailyTopicsModel!.data!.allTopic!.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                              arguments: {
                                                "heading" : "${value.pastDailyTopicsModel!.data!.allTopic![index].competitionType} - ${value.pastDailyTopicsModel!.data!.allTopic![index].topicTitle}",
                                                "id" : "8",
                                                "topicId" : "${value.pastDailyTopicsModel!.data!.allTopic![index].topicID}"
                                              }
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 140,
                                          width: 215,
                                          margin: (context.locale == Locale('ur'))?
                                          (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                          (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          ),
                                          child: Stack(
                                              children: [
                                                SizedBox(
                                                  height: 140,
                                                  width: 215,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: "${dailyTopicsImageBaseUrl}${value.pastDailyTopicsModel!.data!.allTopic![index].topicCover}",
                                                      fit: BoxFit.cover,
                                                      alignment: Alignment.center,
                                                      // errorBuilder: (BuildContext context, Object exception,
                                                      //     StackTrace? stackTrace) {
                                                      //   return const Text('😢');
                                                      // },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 140,
                                                  width: 215,
                                                  decoration: BoxDecoration(
                                                    // color: Colors.black38,
                                                      gradient: const LinearGradient(
                                                          colors: [Colors.black45, Colors.transparent],
                                                          begin: Alignment.bottomCenter,
                                                          end: Alignment.topCenter,
                                                          stops: [0,1]
                                                      ),
                                                    borderRadius: BorderRadius.all(Radius.circular(radiusValue)),

                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 185,
                                                        child: Text("${value.pastDailyTopicsModel!.data!.allTopic![index].competitionType} - ${value.pastDailyTopicsModel!.data!.allTopic![index].topicTitle}",
                                                          maxLines: 1,
                                                          overflow: TextOverflow.clip,
                                                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                              color: colorLightWhite,
                                                          ),
                                                        ),
                                                      ),

                                                      SizedBox(height: 5),
                                                      Text("${value.pastDailyTopicsModel!.data!.allTopic![index].competitionDate}".formatDateWoTime(),
                                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                            color: colorLightWhite
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text("${value.pastDailyTopicsModel!.data!.allTopic![index].totalPost} Posts",
                                                        maxLines: 2,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                            color: colorLightWhite
                                                        ),

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ]

                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    gradient: RadialGradient(
                                      colors: [(themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight, Theme.of(context).canvasColor],
                                      radius: 0.75,
                                      focal: Alignment(0.7, -0.7),
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HeadingRowWidget(
                                          headingText: 'lekhnyTrophy'.tr().toString(),
                                          textButton: 'SEE HOW IT WORKS?',
                                          showTextButton: false,
                                          onTap: (){}
                                      ),
                                      SizedBox(height: verticalSpaceSmall),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('yourCurrentRank'.tr().toString(),
                                                      style: Theme.of(context).textTheme.caption,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text('8894',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),

                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    Text('yourCurrentLevel'.tr().toString(),
                                                      style: Theme.of(context).textTheme.caption,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text('Lekhny Sadasy',
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                    ),

                                                  ],
                                                ),

                                              ],
                                            ),
                                            SizedBox(height: verticalSpaceMedium),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LekhnyTrophySystemScreen()));
                                              },
                                              child: OutlineButtonBig(
                                                height: 40,
                                                width: double.infinity,
                                                backgroundColor: Theme.of(context).canvasColor,
                                                text: 'howLekhnyTrophySysytemWorks'.tr().toString(),
                                                showProgress: false,
                                                radius: radiusValue,
                                                fontSize: 12,
                                                letterspacing: 0,
                                                textColor: primaryColor,
                                                borderWidth: 1,
                                                borderColor: primaryColor,

                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HeadingRowWidget(
                                          headingText: 'upcomingBookAd'.tr().toString(),
                                          textButton: 'seeAll'.tr().toString(),
                                          showTextButton: false,
                                          onTap: (){}
                                      ),
                                      SizedBox(height: verticalSpaceSmall),
                                      SizedBox(
                                        height: 180,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 112,
                                              height: 168,
                                              margin: const EdgeInsets.symmetric(horizontal: 15),
                                              alignment: Alignment.topCenter,
                                              decoration: BoxDecoration(
                                                //color: Colors.red,
                                                borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                              ),
                                              child: AspectRatio(
                                                aspectRatio: 1 /1.5,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: "${AppUrl.upcomingBookImagebaseUrl}${value.upcomingBookModel!.data![0].bookImage}",
                                                    fit: BoxFit.fill,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                //SizedBox(height: verticalSpaceSmall),
                                                // Text('MYSTERY',
                                                //   style: Theme.of(context).textTheme.overline!.copyWith(
                                                //     color: primaryColor,
                                                //   ),
                                                // ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: context.deviceWidth-157,
                                                      child: Text("${value.upcomingBookModel!.data![0].booktitle}",
                                                        style: Theme.of(context).textTheme.subtitle1,
                                                        textAlign: TextAlign.start,
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    SizedBox(
                                                      width: context.deviceWidth-157,
                                                      child: Text("${value.upcomingBookModel!.data![0].writerName}",
                                                        style: Theme.of(context).textTheme.bodyText2!,
                                                        textAlign: TextAlign.start,
                                                        softWrap: false,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.fade,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    SizedBox(
                                                      width: context.deviceWidth-157,
                                                      child: Text("${value.upcomingBookModel!.data![0].bookDetails}",
                                                        style: Theme.of(context).textTheme.caption,
                                                        textAlign: TextAlign.start,
                                                        softWrap: true,
                                                        maxLines: (context.locale == Locale('ur'))?3:4,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.pushNamed(context, RoutesName.upcomingBookScreen,
                                                        arguments: {"bookId" : "${value.upcomingBookModel!.data![0].bookID}"}
                                                    );
                                                  },
                                                  child: Text('readMore'.tr().toString(),
                                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                                        color: primaryColor
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      HeadingRowWidget(
                                          headingText: 'activeWriters'.tr().toString(),
                                          textButton: 'seeAll'.tr().toString(),
                                          showTextButton: false,
                                          onTap: (){}
                                      ),
                                      SizedBox(height: verticalSpaceSmall),
                                      Consumer<FollowUnfollowViewModel>(builder: (BuildContext context, value2, Widget? child){
                                        return  SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            physics: const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: value.topWritersModel!.data!.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return Container(
                                                margin: (context.locale == Locale('ur'))?
                                                (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                                (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                                            arguments: {"writerId" : "${value.topWritersModel!.data![index].id}"}
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height: 100,
                                                              width: 100,
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle
                                                              ),

                                                              child: ClipRRect(
                                                                borderRadius: const BorderRadius.all(Radius.circular(50)),

                                                                child: (value.topWritersModel!.data![index].userProfile != null)?
                                                                CachedNetworkImage(
                                                                  imageUrl: "${AppUrl.profileImagebaseUrl}${value.topWritersModel!.data![index].userProfile}",
                                                                  fit: BoxFit.cover,
                                                                ):
                                                                Image.asset(blankProfilePicture),
                                                              )
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              SizedBox(
                                                                width: 100,
                                                                child: Text("${value.topWritersModel!.data![index].name}",
                                                                  style: Theme.of(context).textTheme.subtitle2,
                                                                  textAlign: TextAlign.center,
                                                                  softWrap: true,
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                              (value.topWritersModel!.data![index].verifiedUser == "0")?
                                                              Icon(Icons.verified_rounded,
                                                                color: primaryColor,
                                                                size: 16,
                                                              ):const SizedBox()
                                                            ],
                                                          ),
                                                          // SizedBox(height: 4),
                                                          // SizedBox(
                                                          //   width: 125,
                                                          //   child: Text("Rank ${value.topWritersModel!.data![index].lekhnyrank}",
                                                          //     style: Theme.of(context).textTheme.caption,
                                                          //     textAlign: TextAlign.center,
                                                          //     softWrap: false,
                                                          //     maxLines: 1,
                                                          //     overflow: TextOverflow.fade,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    ButtonBig(
                                                      onTap: (){
                                                        value2.setTappedIndex(index);
                                                        var data = {
                                                          "writterID": value.topWritersModel!.data![index].id!.toString()
                                                        };

                                                        String? data2 = json.encode(data);
                                                        value2.followUnfollowData(data2, headers, context).then((value3){
                                                          if(value2.tappedIndex == index && value2.followStatus == "unfollow"){
                                                            value.topWritersModel!.data!.removeAt(index);
                                                          }
                                                        });
                                                      },
                                                      height: 30,
                                                      width: 100,
                                                      backgroundColor: primaryColor,
                                                      text: "Follow",
                                                      showProgress: (value2.tappedIndex == index )?value2.loading: false,
                                                      radius: radiusValue,
                                                      fontSize: 12,
                                                      letterspacing: 0.2,
                                                      textPadding: 0,
                                                      progressStrokeWidth: 1,
                                                      progressColor: colorLightWhite,
                                                      textColor: colorLightWhite,
                                                    )

                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                      }),

                                    ],
                                  ),
                                ),
                                Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: EdgeInsets.only(top: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                    //color: Theme.of(context).canvasColor,
                                    gradient: RadialGradient(
                                      colors: [(themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,Theme.of(context).canvasColor],
                                      radius: 1,
                                      focal: Alignment(0.58, -0.7),
                                      tileMode: TileMode.clamp,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          children: [
                                            Text('seeWhoGotTheMostLikes'.tr().toString(),
                                              style: Theme.of(context).textTheme.subtitle1,
                                            ),
                                            SizedBox(height: verticalSpaceExtraSmall),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('goToWeeklyLeaderboard'.tr().toString(),
                                                  style: Theme.of(context).textTheme.bodyText2,
                                                ),
                                                SizedBox(width: 12),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>WeeklyLeaderboardScreen()));
                                                  },
                                                  child: Icon(Icons.arrow_forward_rounded,
                                                    size: 18,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: verticalSpaceSmall),
                              ],
                            ),
                          ),
                        ),
                      );

                  }
                  return Container();

                }
            ),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Visibility(
            visible: false,
            child: Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.only(left: 4, right: 4),
              height: 55,
              width: double.infinity,
              child: FloatingActionButton(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                ),
                onPressed: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                },
                backgroundColor: Theme.of(context).cardColor,
                heroTag: 'showUserLocation',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 11),
                          padding: EdgeInsets.only(top: 4, bottom: 4),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                          ),
                          child: AspectRatio(
                            aspectRatio: 1 /1.5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                              child: Image.network("https://www.adobe.com/express/create/cover/media_178ebed46ae02d6f3284c7886e9b28c5bb9046a02.jpeg",
                                fit: BoxFit.fill,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('CONTINUE READING',
                                style: Theme.of(context).textTheme.overline!.copyWith(
                                    //letterSpacing: 0.2,
                                    color: primaryColor
                                ),
                              ),
                              SizedBox(height: 2),
                              SizedBox(
                                width: context.deviceWidth-160,
                                child: Text('The Power of positive thinking The Power of posit',
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              print('good job');
                            },
                            child: Icon(Icons.cancel_outlined,
                              size: 16,
                              color: Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showRules(String content) async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(radiusValue))),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Rules",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        alignment: Alignment.center,
        actionsPadding: EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
        contentPadding: EdgeInsets.symmetric(vertical:0, horizontal: 15),
        titlePadding: EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
        content: SizedBox(
          height: context.deviceHeight*0.4,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Text(content,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          ButtonBig(
            onTap: (){
              //SystemNavigator.pop();
              Navigator.pop(context);
            },
            width: 75,
            height: 40,
            backgroundColor: primaryColor,
            text: "OK",
            showProgress: false,
            radius: radiusValue,
            textColor: colorLightWhite,
            textPadding: 0,
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}

