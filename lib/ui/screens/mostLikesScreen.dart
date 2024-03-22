import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/leaderboardViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class MostLikes extends StatefulWidget {
  const MostLikes({super.key});

  //const Monthly({Key? key}) : super(key: key);

  @override
  State<MostLikes> createState() => _MostLikesState();
}

class _MostLikesState extends State<MostLikes> {

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  var headers;
  String? userProfileImageBaseUrl;

  @override
  void initState() {

    final leaderboardViewModel = Provider.of<LeaderboardViewModel>(context, listen: false);

    leaderboardViewModel.mostLikesTopRankersData = [];

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

        leaderboardViewModel.getLeaderboardMostLikesData(headers, page, false, true);
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

    userProfileImageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishUserProfileImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiUserProfileImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduUserProfileImagebaseUrl:AppUrl.hindiUserProfileImagebaseUrl;

    return Consumer<LeaderboardViewModel>(
        builder: (context, value, child){
          switch(value.leaderboardData.status){
            case Status.LOADING :
              return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  )
              );

            case Status.ERROR :
              return Text('${value.leaderboardData.message.toString()} this is the error');

            case Status.COMPLETED :
              return Stack(
                  children :[
                    (value.leaderboardMostFollowersModel != null)?
                    Container(
                      decoration: BoxDecoration(
                        //color: Theme.of(context).canvasColor,
                        gradient: RadialGradient(
                          colors: [(themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,Theme.of(context).canvasColor],
                          radius: 0.9,
                          focal: Alignment(0.0, 0.0),
                          tileMode: TileMode.clamp,
                        ),
                      ),

                      child: Padding(
                        padding: EdgeInsets.only(left : 15, right: 15, top: verticalSpaceExtraSmall),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                        arguments: {"writerId" : "${value.leaderboardMostLikesModel!.data!.dataOfTopThree![1].userID}"}
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    radius: 40,
                                    child:  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                          height: 85,
                                          width: 85,
                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.leaderboardMostLikesModel!.data!.dataOfTopThree![1].userProfile}",
                                          fit: BoxFit.fill,
                                          alignment: Alignment.bottomCenter,
                                          errorWidget: (context, url, error) => Image.asset(blankProfilePicture)
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: 105,
                                  child: Center(
                                    child: Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![1].name}",
                                      style: Theme.of(context).textTheme.subtitle2,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![1].totalLikes} Likes",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //SizedBox(height: 5),
                                Text('2\u207f\u1d48',
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).textTheme.bodyText2!.color
                                  ),
                                ),
                                SizedBox(height: 15),
                                SizedBox(
                                  height: 320,
                                  width: 110,
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: SvgPicture.asset(crown,
                                    color: yellow,
                                  ) ,
                                ),
                                SizedBox(height: 2),
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                        arguments: {"writerId" : "${value.leaderboardMostLikesModel!.data!.dataOfTopThree![0].userID}"}
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    radius: 50,
                                    child:  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                          height: 100,
                                          width: 100,
                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.leaderboardMostLikesModel!.data!.dataOfTopThree![0].userProfile}",
                                          fit: BoxFit.fill,
                                          alignment: Alignment.bottomCenter,
                                          errorWidget: (context, url, error) => Image.asset(blankProfilePicture)
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 10),
                                SizedBox(
                                  width: 105,
                                  child: Center(
                                    child: Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![0].name}",
                                      style: Theme.of(context).textTheme.subtitle2,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![0].totalLikes} Likes",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //SizedBox(height: 5),
                                Text('1\u02e2\u1d57',
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).textTheme.bodyText2!.color
                                  ),
                                ),
                                SizedBox(height: 15),
                                SizedBox(
                                  height: 335,
                                  width: 110,
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                        arguments: {"writerId" : "${value.leaderboardMostLikesModel!.data!.dataOfTopThree![2].userID}"}
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    radius: 40,

                                    child:  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                          height: 85,
                                          width: 85,
                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.leaderboardMostLikesModel!.data!.dataOfTopThree![2].userProfile}",
                                          fit: BoxFit.fill,
                                          alignment: Alignment.bottomCenter,
                                          errorWidget: (context, url, error) => Image.asset(blankProfilePicture)
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: 105,
                                  child: Center(
                                    child: Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![2].name}",
                                      style: Theme.of(context).textTheme.subtitle2,
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text("${value.leaderboardMostLikesModel!.data!.dataOfTopThree![2].totalLikes} Likes",
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                //SizedBox(height: 5),
                                Text('3\u02b3\u1d48',
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).textTheme.bodyText2!.color
                                  ),
                                ),
                                SizedBox(height: 15),
                                SizedBox(
                                  height: 320,
                                  width: 110,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ):
                    const SizedBox(),
                    DraggableScrollableSheet(
                        initialChildSize: 0.6,
                        minChildSize: 0.6,
                        snap: true,
                        snapSizes: [0.6,1],
                        builder: (BuildContext context, ScrollController controller){
                          return Container(
                            //margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(radiusValue),topRight: Radius.circular(radiusValue) )
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 65,
                                  height: 1.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Expanded(
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      controller: scrollController,
                                      itemCount: (value.load == true)? (value.mostLikesTopRankersData.length + 2) : value.mostLikesTopRankersData.length+1 ,
                                      itemBuilder: (BuildContext context, int index ){
                                        if(index == 0){
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).cardColor,

                                                // gradient: RadialGradient(
                                                //   colors: [(themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,Theme.of(context).canvasColor],
                                                //   radius: 3.1,
                                                //   focal: Alignment(0.0, 0.0),
                                                //   tileMode: TileMode.clamp,
                                                // ),
                                                //borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                                                border: Border.all(width: 0.4, color: primaryColor)
                                            ),
                                            margin: EdgeInsets.only(bottom: 15),
                                            padding: EdgeInsets.only(bottom: 12, top: 12, left: 15, right: 15),

                                            child: Row(
                                              children: [
                                                Text('-'),
                                                SizedBox(width: 15),
                                                CircleAvatar(
                                                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                  radius: 26,

                                                  child:  ClipRRect(
                                                    borderRadius: BorderRadius.circular(30),
                                                    child: CachedNetworkImage(
                                                        height: 54,
                                                        width: 54,
                                                        imageUrl: "${AppUrl.profileImagebaseUrl}${value.leaderboardMostLikesModel!.data!.authrankdata![0].userProfile}",
                                                        fit: BoxFit.fill,
                                                        alignment: Alignment.bottomCenter,
                                                        errorWidget: (context, url, error) => Image.asset(blankProfilePicture)
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text("${value.leaderboardMostLikesModel!.data!.authrankdata![0].name}",
                                                      style: Theme.of(context).textTheme.subtitle2,
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text("Rank ${value.leaderboardMostLikesModel!.data!.authrankdata![0].rank}",
                                                      style: Theme.of(context).textTheme.caption,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );

                                        }
                                        if (index < value.mostLikesTopRankersData.length+1){
                                          return InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                                  arguments: {"writerId" : "${value.mostLikesTopRankersData[index-1].userID}"}
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).cardColor,
                                                //borderRadius: BorderRadius.all(Radius.circular(radiusValue))
                                              ),
                                              margin: EdgeInsets.only(bottom: 15),
                                              padding: EdgeInsets.only(bottom: 12, top: 12, left: 15, right: 15),

                                              child: Row(
                                                children: [
                                                  Text('${index+3}'),
                                                  SizedBox(width: 15),
                                                  CircleAvatar(
                                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                                    radius: 26,

                                                    child:  ClipRRect(
                                                      borderRadius: BorderRadius.circular(30),
                                                      child: CachedNetworkImage(
                                                          height: 54,
                                                          width: 54,
                                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.mostLikesTopRankersData[index-1].userProfile}",
                                                          fit: BoxFit.fill,
                                                          alignment: Alignment.bottomCenter,
                                                          errorWidget: (context, url, error) => Image.asset(blankProfilePicture)
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${value.mostLikesTopRankersData[index-1].name}",
                                                        style: Theme.of(context).textTheme.subtitle2,
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text("${value.mostLikesTopRankersData[index-1].totalLikes} Likes",
                                                        style: Theme.of(context).textTheme.caption,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }else{
                                          return Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(35),
                                              child: CupertinoActivityIndicator(
                                                  color: primaryColor
                                              ),
                                            ),
                                          );
                                        }

                                      }
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    )
                  ]
              );

          }
          return const SizedBox();

        }
    );
  }

  Future <void> _scroll ()async{
    print("scroll working");
    final leaderboardViewModel = Provider.of<LeaderboardViewModel>(context, listen: false);
    if (leaderboardViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);

      await leaderboardViewModel.getLeaderboardMostLikesData(headers, page, true, false);

      //paginationViewModel.setLoad(false);

    }
  }
}