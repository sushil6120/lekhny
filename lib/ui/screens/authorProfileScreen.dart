import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/screens/authorProfilePosts.dart';
import 'package:lekhny/ui/screens/authorProfileSeries.dart';
import 'package:lekhny/ui/screens/profileDashboard.dart';
import 'package:lekhny/ui/screens/profileLibrary.dart';
import 'package:lekhny/ui/screens/demoGalleryScreen.dart';
import 'package:lekhny/ui/screens/demoIgtvScreen.dart';
import 'package:lekhny/ui/screens/demoReelsScreen.dart';
import 'package:lekhny/ui/screens/profilePosts.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/profile%20page%20widget/writersInfoTextWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/writerProfileViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:lekhny/viewModel/writerProfileViewModel.dart';
import 'package:provider/provider.dart';

class AuthorProfileScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  AuthorProfileScreen(this.args);

  @override
  State<AuthorProfileScreen> createState() => _AuthorProfileScreenState();
}

class _AuthorProfileScreenState extends State<AuthorProfileScreen> {
  //const AuthorProfileScreen({Key? key}) : super(key: key);

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? writerId;
  String? appLanguage;
  String? imageBaseUrl;
  String? coverBaseUrl;
  String? userProfileImageBaseUrl;
  var headers;


  @override
  void initState() {

    writerId = widget.args!["writerId"];

    final writerProfileViewModel = Provider.of<WriterProfileViewModel>(context, listen: false);

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

        var headers2 ={
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print(" this is token ${value.toString()}");
        writerProfileViewModel.getWriterProfileDetailsData(writerId!, null, headers2);
        print("init is working");
      });
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    coverBaseUrl = (context.locale == Locale('en'))?AppUrl.englishCoverImageBaseUrl:AppUrl.hindiAndUrduCoverImageBaseUrl;

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    userProfileImageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishUserProfileImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiUserProfileImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduUserProfileImagebaseUrl:AppUrl.hindiUserProfileImagebaseUrl;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        centerTitle: false,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Consumer<WriterProfileViewModel>(
            builder: (context,value,child){
              //print('satus ${value.homePageData.status}');
              //print('value ${value.homePageData.data![0]!.data!.length}');
              switch(value.writerProfileDetailsData.status){
                case Status.LOADING :
                  return const SizedBox();

                case Status.ERROR :
                  return const SizedBox();

                case Status.COMPLETED :
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppBarBackButton(),
                            SizedBox(width: 15),
                            GestureDetector(
                              child: Text("Writer",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            Utils.toastMessage("This feature will be added soon");
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                          },
                          child: Icon(
                            Icons.more_vert_rounded,color: Theme.of(context).textTheme.headline4!.color,
                          ),
                        ),
                      ],
                    ),
                  );

              }
              return Container();

            }
        ),
      ),
      body: Consumer<WriterProfileViewModel>(
          builder: (context,value,child){
            //print('satus ${value.homePageData.status}');
            //print('value ${value.homePageData.data![0]!.data!.length}');
            switch(value.writerProfileDetailsData.status){
              case Status.LOADING :
                return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    )
                );

              case Status.ERROR :

                return Text('${value.writerProfileDetailsData.message.toString()} this is the error');

              case Status.COMPLETED :
                return DefaultTabController(
                    length: 2,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, _){
                        return [
                          SliverList(
                              delegate: SliverChildListDelegate([
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 160,
                                      //color: Colors.red,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: SizedBox(
                                              width: context.deviceWidth,
                                              height: 105,
                                              child: (value.writerProfileDetailsModel!.data!.writterProfile![0].backGroundImage == null)?
                                              Image.asset(coverImage,
                                                fit: BoxFit.cover,
                                              ):
                                              CachedNetworkImage(
                                                imageUrl: "${AppUrl.profileImagebaseUrl}${value.writerProfileDetailsModel!.data!.writterProfile![0].backGroundImage}",
                                                fit: BoxFit.cover,
                                                alignment: Alignment.bottomCenter,
                                                // errorBuilder: (BuildContext context, Object exception,
                                                //     StackTrace? stackTrace) {
                                                //   return const Text('😢');
                                                // },
                                              ),
                                            ) ,
                                          ),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      height: 110,
                                                      width: 110,
                                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(width: 0.5, color: Theme.of(context).scaffoldBackgroundColor)
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(55),
                                                        child: (value.writerProfileDetailsModel!.data!.writterProfile![0].profileImage == null)?
                                                        Image.asset(blankProfilePicture):
                                                        CachedNetworkImage(
                                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.writerProfileDetailsModel!.data!.writterProfile![0].profileImage}",
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment.center,
                                                          // errorBuilder: (BuildContext context, Object exception,
                                                          //     StackTrace? stackTrace) {
                                                          //   return const Text('😢');
                                                          // },
                                                        ),
                                                      )
                                                  ),

                                                  // Container(
                                                  //     height: 110,
                                                  //     width: 110,
                                                  //     decoration: const BoxDecoration(
                                                  //         shape: BoxShape.circle
                                                  //     ),
                                                  //
                                                  //     child: ClipRRect(
                                                  //       borderRadius: BorderRadius.all(Radius.circular(50)),
                                                  //
                                                  //       child: (value.writerProfileDetailsModel!.data!.writterProfile![0].profileImage == null)?
                                                  //       CachedNetworkImage(
                                                  //         imageUrl: "${AppUrl.profileImagebaseUrl}${value.writerProfileDetailsModel!.data!.writterProfile![0].profileImage}",
                                                  //         fit: BoxFit.cover,
                                                  //       ):
                                                  //       Image.asset(blankProfilePicture),
                                                  //     )
                                                  // ),
                                                  SizedBox(
                                                    height: 55,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,


                                                          children: [
                                                            Text("${value.writerProfileDetailsModel!.data!.writterProfile![0].name}",
                                                              style: Theme.of(context).textTheme.subtitle1,
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                            const SizedBox(width: 4),
                                                            (value.writerProfileDetailsModel!.data!.writterProfile![0].lekhnyVerify == "0")?
                                                            Icon(Icons.verified_rounded,
                                                              color: primaryColor,
                                                              size: 16,
                                                            ):const SizedBox()
                                                          ],
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text("Lekhny Rank - ${value.writerProfileDetailsModel!.data!.writterProfile![0].lekhnyrankTrophy}",
                                                          style: Theme.of(context).textTheme.caption,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                          )

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: verticalSpaceSmall),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children :[
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children : [
                                                  WritersInfoTextWidget(
                                                    boldText: (value.writerStatsModel!.data![0].totalPost == null)?"0":"${value.writerStatsModel!.data![0].totalPost}",
                                                    lightText: 'Posts',
                                                  ),
                                                  WritersInfoTextWidget(
                                                    boldText: (value.writerProfileDetailsModel!.data!.totalFollowers == null)?"0":"${value.writerProfileDetailsModel!.data!.totalFollowers}",
                                                    lightText: 'Followers',
                                                  ),
                                                  WritersInfoTextWidget(
                                                    boldText: (value.writerProfileDetailsModel!.data!.totlaFollowing == null)?"0":"${value.writerProfileDetailsModel!.data!.totalFollowers}",
                                                    lightText: 'Following',
                                                  ),
                                                  WritersInfoTextWidget(
                                                    boldText: (value.writerStatsModel!.data![0].totalTrophy ==null)?"0":"${value.writerStatsModel!.data![0].totalTrophy}",
                                                    lightText: 'Trophy',
                                                  ),
                                                ]
                                            ),
                                            SizedBox(height: verticalSpaceSmall),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                ButtonBig(
                                                  onTap: (){
                                                    var data = {
                                                      "writterID": writerId.toString()
                                                    };

                                                    String? data2 = json.encode(data);
                                                    value.followUnfollowData(data2, headers, context);
                                                  },
                                                  height: 30,
                                                  width: context.deviceWidth*.5 -22.5,
                                                  backgroundColor: (value.isFollowing == 1)?Theme.of(context).cardColor:primaryColor,
                                                  text: (value.isFollowing == 1)?'Unfollow': "Follow",
                                                  showProgress: value.loading,
                                                  radius: radiusValue,
                                                  fontSize: 12,
                                                  letterspacing: 0.2,
                                                  textColor: (value.isFollowing == 1)?Theme.of(context).textTheme.headline6!.color:colorLightWhite,
                                                  textPadding: 0,
                                                  progressColor: (value.isFollowing == 1)?Theme.of(context).textTheme.headline6!.color:colorLightWhite,
                                                  progressStrokeWidth: 1.5,

                                                ),

                                                ButtonBig(
                                                  onTap: (){
                                                    Utils.toastMessage("This feature will be added soon");
                                                  },
                                                  height: 30,
                                                  width: context.deviceWidth*.5 -22.5,
                                                  backgroundColor: Theme.of(context).cardColor,
                                                  text: "Message",
                                                  showProgress: false,
                                                  radius: radiusValue,
                                                  fontSize: 12,
                                                  letterspacing: 0.2,
                                                  textColor: Theme.of(context).textTheme.headline6!.color,
                                                  textPadding: 0,

                                                ),
                                                // ButtonBig(
                                                //   onTap: (){
                                                //     Utils.toastMessage("This feature will be added soon");
                                                //   },
                                                //   height: 30,
                                                //   width: context.deviceWidth*.3 -7.5,
                                                //   backgroundColor: Theme.of(context).cardColor,
                                                //   text: 'Share',
                                                //   showProgress: false,
                                                //   radius: radiusValue,
                                                //   fontSize: 12,
                                                //   textColor: Theme.of(context).textTheme.headline6!.color,
                                                //   letterspacing: 0.2,
                                                //   textPadding: 0,
                                                // ),

                                              ],
                                            ),
                                            //SizedBox(height: verticalSpaceExtraSmall),
                                          ]
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                              )
                          )
                        ];
                      },
                      body: Column(
                        children: [
                          //Icon(Icons.drag_handle_rounded),
                          Material(
                            child: TabBar(
                              indicatorColor: primaryColor,
                              tabs: [
                                Tab(child: Text('Stories',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),
                                Tab(child: Text('Series',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),
                                // Tab(child: Text('About',
                                //   style: Theme.of(context).textTheme.subtitle1,),
                                //),

                              ],
                            ),

                          ),
                          Expanded(
                              child: TabBarView(
                                children: [
                                  AuthorProfilePosts(writerId: writerId),
                                  AuthorProfileSeries(writerId: writerId),
                                  //ProfileDashboard(userProfileModel: value.writerProfileDetailsModel)
                                  // Container(),
                                ],
                              )
                          )
                        ],
                      ),
                    )
                );

            }
            return Container();

          }
      ),

    );
  }
}
