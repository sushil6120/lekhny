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
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
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
import 'package:lekhny/viewModel/profileViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //const ProfileScreen({Key? key}) : super(key: key);

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? copyrightId;
  String? appLanguage;
  String? imageBaseUrl;
  String? coverBaseUrl;
  String? userProfileImageBaseUrl;
  var headers;


  @override
  void initState() {

    final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();

    })().then((value){

      print('this is appLanguage ${appLanguage}');

      sharedPreferencesViewModel.getToken().then((value){

        headers = {
          'lekhnyToken': value.toString(),
          //'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        var headers2 ={
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print(" this is token ${value.toString()}");
        profileViewModel.getProfileData(headers, headers2);
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
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text('profile'.tr().toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Row(
                children: [
                  // GestureDetector(
                  //   onTap: (){
                  //     Utils.toastMessage("This feature will be added soon");
                  //     //Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
                  //   },
                  //   child: Icon(
                  //     Icons.mail_outline_rounded,color: Theme.of(context).textTheme.headline4!.color,
                  //   ),
                  // ),
                  SizedBox(width: 25),
                  GestureDetector(
                    onTap: (){
                      //Utils.toastMessage("This feature will be added soon");
                      Navigator.pushNamed(context, RoutesName.settingScreen);
                    },
                    child: Icon(
                      Icons.settings_outlined,color: Theme.of(context).textTheme.headline4!.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Consumer<ProfileViewModel>(
          builder: (context,value,child){
            //print('satus ${value.homePageData.status}');
            //print('value ${value.homePageData.data![0]!.data!.length}');
            switch(value.profileData.status){
              case Status.LOADING :
                return Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    )
                );

              case Status.ERROR :
                return Text('${value.profileData.message.toString()} this is the error');

              case Status.COMPLETED :
                return DefaultTabController(
                    length: 2,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, _){
                        return [
                          SliverList
                            (
                              delegate: SliverChildListDelegate([
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 160,
                                        //color: Colors.red,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                width: context.deviceWidth,
                                                height: 105,
                                                child: Stack(
                                                    children:[
                                                      Container(
                                                        width: context.deviceWidth,
                                                        height: 105,
                                                        child: (value.userProfileModel!.data![0].backGroundImage == null)?
                                                        Image.asset(coverImage,
                                                          fit: BoxFit.cover,
                                                        ):
                                                        CachedNetworkImage(
                                                          imageUrl: "${AppUrl.profileImagebaseUrl}${value.userProfileModel!.data![0].backGroundImage}",
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment.bottomCenter,
                                                          // errorBuilder: (BuildContext context, Object exception,
                                                          //     StackTrace? stackTrace) {
                                                          //   return const Text('😢');
                                                          // },
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: (context.locale == Locale('ur'))?
                                                        Alignment.topLeft:
                                                        Alignment.topRight,
                                                        child: GestureDetector(
                                                          onTap: (){
                                                            Utils.toastMessage("This feature will be added soon");
                                                          },
                                                          child: Container(
                                                              height: 25,
                                                              width: 25,
                                                              decoration: BoxDecoration(
                                                                  color: Theme.of(context).canvasColor,
                                                                  border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                                              ),
                                                              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                                                              child: const Center(
                                                                child: Icon(Icons.edit_outlined,
                                                                  size: 16,
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ]
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
                                                      width: 115,
                                                      margin: EdgeInsets.symmetric(horizontal: 15),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                              height: 110,
                                                              width: 110,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border: Border.all(width: 0.5, color: Theme.of(context).scaffoldBackgroundColor)
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(55),
                                                                child: (value.userProfileModel!.data![0].profile == null)?
                                                                Image.asset(blankProfilePicture):
                                                                CachedNetworkImage(
                                                                  imageUrl: "${AppUrl.profileImagebaseUrl}${value.userProfileModel!.data![0].profile}",
                                                                  fit: BoxFit.cover,
                                                                  alignment: Alignment.bottomCenter,
                                                                  // errorBuilder: (BuildContext context, Object exception,
                                                                  //     StackTrace? stackTrace) {
                                                                  //   return const Text('😢');
                                                                  // },
                                                                ),
                                                              )
                                                          ),
                                                          InkWell(
                                                            onTap: (){
                                                              if(value.userProfileModel!.data![0].lekhnyExclusie == "1"){
                                                                Utils.flushBarErrorMessageWithButton("Please verify you email", context, "Verify", (p0) {
                                                                  Navigator.pushNamed(context, RoutesName.verifyEmailScreen);
                                                                });



                                                              }
                                                            },
                                                            child: Align(
                                                              alignment: (context.locale == Locale('ur'))?
                                                              Alignment.bottomLeft:
                                                              Alignment.bottomRight,
                                                              child: Container(
                                                                  height: 25,
                                                                  width: 25,
                                                                  decoration: BoxDecoration(
                                                                      color: Theme.of(context).canvasColor,
                                                                      border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                                  ),
                                                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                                                  child: Center(
                                                                    child: Icon(Icons.camera_alt_outlined,
                                                                      size: 16,
                                                                    ),
                                                                  )
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 55,
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("${value.userProfileModel!.data![0].name}",
                                                            style: Theme.of(context).textTheme.subtitle1,
                                                          ),
                                                          SizedBox(height: 2),
                                                          Text("${'lekhnyRank'.tr().toString()} - ${value.userProfileModel!.data![0].lekhnyRank}",
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
                                      Container(
                                          height: 150,
                                          //color: Colors.green,
                                          margin: EdgeInsets.symmetric(horizontal: 15),
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children :[
                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children : [
                                                      WritersInfoTextWidget(
                                                        boldText: (value.userProfileModel!.data![0].totalPost == null)?"0":"${value.userProfileModel!.data![0].totalPost}",
                                                        lightText: 'post'.tr().toString(),
                                                      ),
                                                      WritersInfoTextWidget(
                                                        boldText: (value.userProfileModel!.data![0].totalFollowers == null)?"0":"${value.userProfileModel!.data![0].totalFollowers}",
                                                        lightText: 'followers'.tr().toString(),
                                                      ),
                                                      WritersInfoTextWidget(
                                                        boldText: (value.userProfileModel!.data![0].totalFollowing == null)?"0":"${value.userProfileModel!.data![0].totalFollowing}",
                                                        lightText: 'following'.tr().toString(),
                                                      ),
                                                      WritersInfoTextWidget(
                                                        boldText: (value.userProfileModel!.data![0].totalTrophy ==null)?"0":"${value.userProfileModel!.data![0].totalTrophy}",
                                                        lightText: 'trophy'.tr().toString(),
                                                      ),
                                                    ]
                                                ),
                                                SizedBox(height: verticalSpaceSmall),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.pushNamed(context, RoutesName.pointsScreen);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                                    //margin: EdgeInsets.symmetric(horizontal: 15),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                      //border: Border.all(width: 1, color: Theme.of(context).cardColor)
                                                    ),
                                                    height: 50,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('redeemPoints'.tr().toString(),
                                                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                                                  color: colorLightWhite
                                                              ),
                                                            ),
                                                            //SizedBox(height: 2),
                                                            Text('convertYourEarnedPoints'.tr().toString(),
                                                              style: Theme.of(context).textTheme.caption!.copyWith(
                                                                  color: colorLightWhite
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Icon(Icons.arrow_forward_ios_rounded,
                                                          size: 20,
                                                          color: colorLightWhite,
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                //SizedBox(height: verticalSpaceSmall),
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //
                                                //     ButtonBig(
                                                //       onTap: (){
                                                //         Utils.toastMessage("This feature will be added soon");
                                                //       },
                                                //       height: 30,
                                                //       width: context.deviceWidth*.5 -25,
                                                //       backgroundColor: Theme.of(context).cardColor,
                                                //       text: 'editProfile'.tr().toString(),
                                                //       showProgress: false,
                                                //       radius: radiusValue,
                                                //       fontSize: 12,
                                                //       letterspacing: 0.2,
                                                //       textColor: Theme.of(context).textTheme.headline6!.color,
                                                //       textPadding: 0,
                                                //
                                                //     ),
                                                //     ButtonBig(
                                                //       onTap: (){
                                                //         Utils.toastMessage("This feature will be added soon");
                                                //       },
                                                //       height: 30,
                                                //       width: context.deviceWidth*.5 -25,
                                                //       backgroundColor: Theme.of(context).cardColor,
                                                //       text: 'share'.tr().toString(),
                                                //       showProgress: false,
                                                //       radius: radiusValue,
                                                //       fontSize: 12,
                                                //       textColor: Theme.of(context).textTheme.headline6!.color,
                                                //       letterspacing: 0.2,
                                                //       textPadding: 0,
                                                //     ),
                                                //
                                                //   ],
                                                // ),
                                                //SizedBox(height: verticalSpaceExtraSmall),
                                              ]
                                          )
                                      ),
                                    ],

                                  ),
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
                                Tab(child: Text('post'.tr().toString(),
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),
                                // Tab(child: Text('library'.tr().toString(),
                                //   style: Theme.of(context).textTheme.subtitle1,),
                                // ),
                                Tab(child: Text('dashbard'.tr().toString(),
                                  style: Theme.of(context).textTheme.subtitle1,),
                                ),

                              ],
                            ),

                          ),
                          Expanded(
                              child: TabBarView(
                                children: [
                                  ProfilePosts(),
                                  //ProfileLibrary(libraryCollectionModelClass: value.libraryCollectionModel),
                                  ProfileDashboard(userProfileModel: value.userProfileModel)
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
