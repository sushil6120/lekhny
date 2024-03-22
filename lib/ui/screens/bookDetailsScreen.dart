import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/bookListBuilder.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookStatsWidget.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/coloredVerticalSpace.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/bookDetailsScreen.dart';
import 'package:lekhny/ui/screens/bookDetailsScreen.dart';
import 'package:lekhny/ui/screens/commentsScreen.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/ui/widget/profile%20page%20widget/writersInfoTextWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/bookDetailsScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class BookDetailsScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  BookDetailsScreen(this.args);

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  BookDetailsScreenViewModel bookDetailsScreenViewModel = BookDetailsScreenViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  var headers;
  String? postId;
  String? postLink;

  @override
  void initState() {

    postId = widget.args!["postId"];
    postLink = "https://lekhny.com/viewPost/$postId";
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
        print(" this is token ${value.toString()}");
        bookDetailsScreenViewModel.getSingleBookDetailsData(postId!, null, headers);
        print("init is working");
      });
    });

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   titleSpacing: 0,
          //   automaticallyImplyLeading: false,
          //   elevation: 1,
          //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          //   title: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 15),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         AppBarBackButton(),
          //         //SizedBox(width: 30),
          //         Text('Novel',
          //           style: Theme.of(context).textTheme.headline6,
          //         ),
          //         Icon(Icons.search_rounded,
          //           color: Theme.of(context).textTheme.headline6!.color,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          body: ChangeNotifierProvider<BookDetailsScreenViewModel>(
            create: (BuildContext context)=> bookDetailsScreenViewModel,
            child: Consumer<BookDetailsScreenViewModel>(
                builder: (context,value,child){
                  //print('satus ${value.homePageData.status}');
                  //print('value ${value.homePageData.data![0]!.data!.length}');
                  switch(value.singleBookDetailsData.status){
                    case Status.LOADING :
                      return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )
                      );

                    case Status.ERROR :
                      return Text('${value.singleBookDetailsData.message.toString()} this is the error');

                    case Status.COMPLETED :

                      print("lang ${value.singleBookDetailsModel!.data![0].languageID}");

                      if(value.singleBookDetailsModel!.data![0].languageID != null){
                        imageBaseUrl = (value.singleBookDetailsModel!.data![0].languageID == "3")?AppUrl.englishImagebaseUrl:
                        (value.singleBookDetailsModel!.data![0].languageID == "2")?AppUrl.hindiImagebaseUrl:(value.singleBookDetailsModel!.data![0].languageID == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

                      }

                      return SafeArea(
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              pinned: true,
                              backgroundColor: primaryColor,
                              expandedHeight: 365,
                              automaticallyImplyLeading: false,
                              leading: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back_ios_new_rounded,
                                  color: colorLightWhite,
                                ),
                              ),
                              flexibleSpace: Container(
                                height: 365,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: verticalSpaceMedium),
                                    Container(
                                      width: 145,
                                      height: 215,
                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        //color: Colors.red,
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black26,
                                                spreadRadius: 0,
                                                blurRadius: 5,
                                                offset: Offset(2.5, 6)
                                            )
                                          ]
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1 /1.5,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                          child: CachedNetworkImage(
                                            imageUrl: "${imageBaseUrl}${value.singleBookDetailsModel!.data![0].bookCover}",
                                            fit: BoxFit.cover,
                                            alignment: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: verticalSpaceSmall),
                                    Text("${value.singleBookDetailsModel!.data![0].title}",
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                          color: colorLightWhite,),
                                      textAlign: TextAlign.center,
                                      softWrap: false,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2),
                                    Text("${value.singleBookDetailsModel!.data![0].author}",
                                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            color: colorLight2
                                        )
                                    ),

                                  ],
                                ),

                              ),
                              // title: Text('Book Name'),
                              // centerTitle: true,
                              actions: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child:  InkWell(
                                    onTap:(){
                                      Share.share('Check out this post $postLink',
                                          subject: 'Lekhny');
                                    },
                                    child: Icon(Icons.more_vert_rounded),
                                  ),
                                )


                              ],

                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                //margin: EdgeInsets.only(top: 10),
                                height: context.deviceHeight - (context.safeAreaHeight + 365),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusValue),topRight: Radius.circular(radiusValue) )
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: verticalSpaceMedium),
                                    // Column(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     Text('The Power of Positive Thinking',
                                    //       style: Theme.of(context).textTheme.subtitle1,
                                    //     ),
                                    //     SizedBox(height: 2),
                                    //     Text('Steve Austin',
                                    //       style: Theme.of(context).textTheme.caption,
                                    //     ),
                                    //   ],
                                    // ),
                                    SizedBox(height: verticalSpaceSmall),
                                    Container(
                                        margin: EdgeInsets.symmetric(horizontal: 15),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children : [
                                              BookStatsWidget(
                                                icon: Icons.remove_red_eye_outlined,
                                                iconSize: 16,
                                                lightText: "${value.singleBookDetailsModel!.data![0].views} Views",
                                                iconColor: primaryColor,
                                                fontSize: 14,
                                              ),
                                              Container(
                                                height: 35,
                                                width: 0.5,
                                                color: Theme.of(context).disabledColor,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  value.likePostData(postId!, null, headers);
                                                },
                                                child: BookStatsWidget(
                                                  icon: (value.isLiked == 0)?Icons.favorite_border_rounded:Icons.favorite,
                                                  iconSize: 16,
                                                  lightText: "${value.likeValue} Likes",
                                                  iconColor: errorColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 0.5,
                                                color: Theme.of(context).disabledColor,
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.pushNamed(context, RoutesName.commentScreen,
                                                      arguments: {
                                                        "postId" : postId,
                                                      });
                                                },
                                                child: BookStatsWidget(
                                                  icon: Icons.mode_comment_outlined,
                                                  iconSize: 16,
                                                  lightText: 'Comments',
                                                  iconColor: primaryColor,
                                                  fontSize: 14,
                                                ),
                                              ),

                                            ]
                                        )
                                    ),
                                    SizedBox(height: verticalSpaceSmall),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("Total Parts : ${value.singleBookDetailsModel!.data![0].totalPart}",
                                            style: Theme.of(context).textTheme.bodyText2,
                                          ),
                                          ButtonBig(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.readingScreen,
                                                  arguments: {"postId" : value.singleBookDetailsModel!.data![0].postID, "index" : 0}
                                              );

                                            },
                                            height: 30,
                                            width: 80,
                                            backgroundColor: Theme.of(context).primaryColor,
                                            text: 'read'.tr().toString(),
                                            showProgress: false,
                                            radius: radiusValue,
                                            fontSize: 12,
                                            letterspacing: 0.2,
                                            textPadding: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: verticalSpaceSmall),
                                    SizedBox(height: 5),
                                    Expanded(
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          //controller: scrollController,
                                          itemCount: value.singleBookPartsModel!.data!.length,
                                          itemBuilder: (BuildContext context, int index ){
                                            return GestureDetector(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.readingScreen,
                                                    arguments: {"postId" : value.singleBookPartsModel!.data![index].id, "index" : index}
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context).cardColor,
                                                    borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                                                ),
                                                margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
                                                padding: EdgeInsets.only(bottom: 12, top: 12, left: 15, right: 15),

                                                child: Row(
                                                  children: [
                                                    Text('${index+1}'),
                                                    SizedBox(width: 15),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: context.deviceWidth - 100,
                                                          child: Text("${value.singleBookPartsModel!.data![index].bookTitle}",
                                                            style: Theme.of(context).textTheme.subtitle2,
                                                            textAlign: TextAlign.start,
                                                            softWrap: false,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            BookStatsWidget(
                                                              icon: Icons.remove_red_eye_outlined,
                                                              iconSize: 12,
                                                              fontSize: 12,
                                                              lightText: "${value.singleBookPartsModel!.data![index].totalViwers} Reads",
                                                              iconColor: primaryColor,
                                                            ),
                                                            SizedBox(width: 15),
                                                            BookStatsWidget(
                                                              icon: Icons.favorite,
                                                              iconSize: 12,
                                                              fontSize: 12,
                                                              lightText: "${value.singleBookPartsModel!.data![index].totalLikes} Likes",
                                                              iconColor: errorColor,
                                                            ),
                                                          ],
                                                        ),

                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )

                          ],
                        ),
                      );

                  }
                  return Container();

                }
            ),

          ),
      ),
    );
  }
}
