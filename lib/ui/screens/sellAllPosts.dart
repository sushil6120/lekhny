import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookListBuilder.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/coloredVerticalSpace.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/extensions.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/seeAllPostsViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:lekhny/viewModel/seeAllPostsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class SeeAllPostsScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  SeeAllPostsScreen(this.args, {super.key});

  @override
  State<SeeAllPostsScreen> createState() => _SeeAllPostsScreenState();
}

class _SeeAllPostsScreenState extends State<SeeAllPostsScreen> {

  final ScrollController scrollController = ScrollController();

  int page = 1;

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? heading;
  String? id;
  String? topicId;
  String? appLanguage;
  String? imageBaseUrl;
  String? dailyTopicsImageBaseUrl;
  var headers;

  @override
  void initState() {
    heading = widget.args!["heading"];
    id = widget.args!["id"];
    topicId = widget.args!["topicId"];
    final seeAllPostsViewModel = Provider.of<SeeAllPostsViewModel>(context, listen: false);

    seeAllPostsViewModel.competitionPostsData = [];

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

        print(" this is headers ${headers}");
        print("this is id ${widget.args!["categoryID"]}");
        seeAllPostsViewModel.getSeeAllPostsData(null, headers, page, false, id, topicId);
        print("init is working");

        scrollController.addListener( _scroll);

      });
    });
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    dailyTopicsImageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishDailyCompImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiDailyCompImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduDailyCompImagebaseUrl:AppUrl.hindiDailyCompImagebaseUrl;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
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
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarBackButton(),
                //SizedBox(width: 30),
                SizedBox(
                  width: context.deviceWidth*0.75,
                  child: Text("$heading",
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
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
          ),
        ),
        body: Consumer<SeeAllPostsViewModel>(
            builder: (context,value,child){
              //print('satus ${value.homePageData.status}');
              //print('value ${value.homePageData.data![0]!.data!.length}');
              switch(value.seeAllPostsData.status){
                case Status.LOADING :
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  );

                case Status.ERROR :
                  return Text('${value.seeAllPostsData.message.toString()} this is the error');

                case Status.COMPLETED :
                  if(id == "1"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5, top: verticalSpaceSmall2),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.readingHistoryData.length + 1) : value.readingHistoryData.length ,
                                        (index){
                                      if (index < value.readingHistoryData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.readingHistoryData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.readingHistoryData[index].bookCover}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.readingHistoryData[index].title}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.readingHistoryData[index].author}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "2"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.topPostsData.length + 1) : value.topPostsData.length ,
                                        (index){
                                      if (index < value.topPostsData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.topPostsData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.topPostsData[index].bookCover}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.topPostsData[index].title}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.topPostsData[index].author}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "3"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.topPicksData.length + 1) : value.topPicksData.length ,
                                        (index){
                                      if (index < value.topPicksData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.topPicksData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.topPicksData[index].bookCoverImage}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.topPicksData[index].bookTitle}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.topPicksData[index].writer}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if(id == "4"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.topSeriesData.length + 1) : value.topSeriesData.length ,
                                        (index){
                                      if (index < value.topSeriesData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.topSeriesData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.topSeriesData[index].bookCoverImage}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.topSeriesData[index].bookTitle}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.topSeriesData[index].writer}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "5"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.mostReadPostsData.length + 1) : value.mostReadPostsData.length ,
                                        (index){
                                      if (index < value.mostReadPostsData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.mostReadPostsData[index].id.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.mostReadPostsData[index].bookCover}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.mostReadPostsData[index].title}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.mostReadPostsData[index].author}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "6"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.latestPostsData.length + 1) : value.latestPostsData.length ,
                                        (index){
                                      if (index < value.latestPostsData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.latestPostsData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.latestPostsData[index].bookCoverImage}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.latestPostsData[index].bookTitle}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.latestPostsData[index].writer}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "7"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1.4/1:1.4/1,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?4:2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.allTopicData.length + 1) : value.allTopicData.length ,
                                        (index){
                                      if (index < value.allTopicData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            Navigator.pushNamed(context, RoutesName.seeAllPostsScreen,
                                                arguments: {
                                                  "heading" : "${value.allTopicData![index].competitionType} - ${value.allTopicData![index].topicTitle}",
                                                  "id" : "8",
                                                  "topicId" : "${value.allTopicData![index].topicID}"
                                                }
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            //height: 100,
                                            //width: 215,
                                            // margin: (context.locale == Locale('ur'))?
                                            // (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                            // (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                            ),
                                            child: Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 120,
                                                    width: context.deviceWidth*.48,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: "${dailyTopicsImageBaseUrl}${value.allTopicData![index].topicCover}",
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
                                                    height: 120,
                                                    width: context.deviceWidth*.48,
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
                                                          child: Text("${value.allTopicData![index].competitionType} - ${value.allTopicData![index].topicTitle}",
                                                            maxLines: 1,
                                                            overflow: TextOverflow.clip,
                                                            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                              color: colorLightWhite,
                                                            ),
                                                          ),
                                                        ),

                                                        SizedBox(height: 5),
                                                        Text("${value.allTopicData![index].competitionDate}".formatDateWoTime(),
                                                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                              color: colorLightWhite
                                                          ),
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text("${value.allTopicData![index].totalPost} Posts",
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
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }else if (id == "8"){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.competitionPostsData.length + 1) : value.competitionPostsData.length ,
                                        (index){
                                      if (index < value.competitionPostsData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.competitionPostsData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.competitionPostsData[index].bookCover}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.competitionPostsData[index].title}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.competitionPostsData[index].author}"
                                          ),
                                        );
                                      }else{
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(20),
                                            child: CupertinoActivityIndicator(
                                                color: primaryColor
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                )
                            ),
                          ),
                        )
                        //SizedBox(height: verticalSpaceSmall),

                      ],
                    );
                  }


              }
              return Container();

            }
        ),
      ),
    );
  }

  Future <void> _scroll ()async{
    final seeAllPostsViewModel = Provider.of<SeeAllPostsViewModel>(context, listen: false);
    if (seeAllPostsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);
      seeAllPostsViewModel.getSeeAllPostsData(null, headers, page, true, id, topicId);
    }
  }

}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
