import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/pointsMessageWidget.dart';
import 'package:lekhny/ui/global%20widgets/pointsOptionsWidget.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonBigWithIcon.dart';
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
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/lekhnyPointsViewModel.dart';
import 'package:lekhny/viewModel/redeemPointsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class PointsScreen extends StatefulWidget {
  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  LekhnyPointsViewModel lekhnyPointsViewModel = LekhnyPointsViewModel();

  String? appLanguage;

  @override
  void initState() {

    (()async{
      appLanguage = await sharedPreferencesViewModel.getLanguage();
    })().then((value){
      print('this is appLanguage ${appLanguage}');
      sharedPreferencesViewModel.getToken().then((value){

        final headers = {
          'lekhnyToken': value.toString(),
          'AppLanguage': appLanguage??"3",
          'Authorization': 'Bearer ${value.toString()}'
        };

        print(" this is token ${value.toString()}");
        lekhnyPointsViewModel.getAllPointsDetailsData(null, headers);
        print("init is working");

      });
    });

    // TODO: implement initState

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final redeemPointsViewModel = Provider.of<RedeemPointsViewModel>(context, listen: false);

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
                  Text('Lekhny Points',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(Icons.search_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
          body: ChangeNotifierProvider<LekhnyPointsViewModel>(
            create: (BuildContext context)=> lekhnyPointsViewModel,
            child: Consumer<LekhnyPointsViewModel>(
                builder: (context,value,child){
                  //print('satus ${value.homePageData.status}');
                  //print('value ${value.homePageData.data![0]!.data!.length}');
                  switch(value.allPointsDetailsData.status){
                    case Status.LOADING :
                      return Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )
                      );

                    case Status.ERROR :
                      return Text('${value.allPointsDetailsData.message.toString()} this is the error');

                    case Status.COMPLETED :
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: context.deviceWidth,
                              decoration: BoxDecoration(
                                  color: primaryColor
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: verticalSpaceLarge),
                                  Text('availablePoints'.tr().toString(),
                                    style: Theme.of(context).textTheme.button!.copyWith(
                                      letterSpacing: 4,
                                      color: colorLightWhite,),
                                    textAlign: TextAlign.center,
                                    softWrap: false,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: verticalSpaceExtraSmall),
                                  Text("${value.allPointsDetailsModel!.data!.allPointsData!.availabelPoints}",
                                    style: Theme.of(context).textTheme.headline4!.copyWith(
                                      //letterSpacing: 4,
                                      color: colorLightWhite,),
                                  ),
                                  SizedBox(height: verticalSpaceMedium),
                                  ButtonBig(
                                    onTap: (){
                                      if(value.allPointsDetailsModel!.data!.allPointsData!.availabelPoints! >=
                                          int.parse(value.allPointsDetailsModel!.data!.minlimitOfPointredeem!)
                                      ){
                                        redeemPointsViewModel.selectedFile = null;
                                        redeemPointsViewModel.sendMoneyTo = null;

                                        Navigator.pushNamed(context, RoutesName.redeemPointsScreen,
                                            arguments: {
                                          "availablePoints" : "${value.allPointsDetailsModel!.data!.allPointsData!.availabelPoints}",
                                          "minLimitToRedeem" : "${value.allPointsDetailsModel!.data!.minlimitOfPointredeem}"
                                        }
                                        );
                                      }else{
                                        Utils.flushBarErrorMessage("Insufficient Balance", context, Icons.error_outline_rounded, colorLightWhite);
                                      }

                                    },
                                    height: 36,
                                    width: 160,
                                    backgroundColor: colorLightWhite,
                                    textColor: primaryColor,
                                    text: 'redeemPoints'.tr().toString(),
                                    showProgress: false,
                                    radius: radiusValue,
                                    fontSize: 14,
                                    letterspacing: 0,
                                    textPadding: 20,
                                  ),
                                  SizedBox(height: verticalSpaceSmall),
                                  Text('youNeedMinimum'.tr().toString(),
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: colorLightWhite
                                    ),
                                  ),
                                  SizedBox(height: verticalSpaceLarge),
                                ],
                              ),
                            ),
                            SizedBox(height: 1),
                            ButtonBig(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.requestPointsScreen);
                              },
                              height: bigButtonHeight,
                              //width: 220,
                              backgroundColor: primaryColor,
                              textColor: colorLightWhite,
                              text: 'requestMorePoints'.tr().toString(),
                              showProgress: false,
                              radius: 0,
                              fontSize: 14,
                              letterspacing: 0,
                              textPadding: 20,
                            ),
                            SizedBox(height: verticalSpaceSmall),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text('pointsHistory'.tr().toString(),
                                  style: Theme.of(context).textTheme.subtitle1
                              ),
                            ),
                            SizedBox(height: verticalSpaceSmall),
                            PointsMessageWidget(
                              onTap: (){},
                              prefixIcon: Icons.wallet_giftcard_rounded,
                              prefixIconColor: secondaryColor,
                              prefixIconsSize: 20,
                              headingText: 'congratulations'.tr().toString(),
                              captionText: 'youHaveEarned'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 150,
                              suffixText: "+${value.allPointsDetailsModel!.data!.allPointsData!.joiningPoint}",
                              suffixTextColor: primaryColor,
                            ),
                            PointsOptionsWidget(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.pointsEarnedScreen);
                              },
                              prefixIcon: Icons.call_received_rounded,
                              prefixIconColor: primaryColor,
                              prefixIconsSize: 20,
                              headingText: 'pointsEarned'.tr().toString(),
                              captionText: 'historyPostsLike'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 125,
                              sufixIcon: Icons.arrow_forward_ios_rounded,
                              sufixIconColor: Theme.of(context).textTheme.bodyText1!.color,
                              sufixIconsSize: 20,
                            ),
                            PointsOptionsWidget(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.pointsCreditedScreen);
                              },
                              prefixIcon: Icons.call_received_rounded,
                              prefixIconColor: primaryColor,
                              prefixIconsSize: 20,
                              headingText: 'pointsCredited'.tr().toString(),
                              captionText: 'historyAddedByLekhny'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 125,
                              sufixIcon: Icons.arrow_forward_ios_rounded,
                              sufixIconColor: Theme.of(context).textTheme.bodyText1!.color,
                              sufixIconsSize: 20,
                            ),
                            PointsOptionsWidget(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.pointsDeductedScreen);
                              },
                              prefixIcon: Icons.call_made_rounded,
                              prefixIconColor: errorColor,
                              prefixIconsSize: 20,
                              headingText: 'pointsDeducted'.tr().toString(),
                              captionText: 'historyPublishingPost'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 125,
                              sufixIcon: Icons.arrow_forward_ios_rounded,
                              sufixIconColor: Theme.of(context).textTheme.bodyText1!.color,
                              sufixIconsSize: 20,
                            ),
                            PointsOptionsWidget(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.redeemedPointsScreen);
                              },
                              prefixIcon: Icons.currency_rupee_rounded,
                              prefixIconColor: primaryColor,
                              prefixIconsSize: 20,
                              headingText: 'redeemPoints'.tr().toString(),
                              captionText: 'historyRedeemPoints'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 125,
                              sufixIcon: Icons.arrow_forward_ios_rounded,
                              sufixIconColor: Theme.of(context).textTheme.bodyText1!.color,
                              sufixIconsSize: 20,
                            ),
                            PointsOptionsWidget(
                              onTap: (){
                                Navigator.pushNamed(context, RoutesName.pointsRequestStatusScreen);
                              },
                              prefixIcon: Icons.access_time_rounded,
                              prefixIconColor: Theme.of(context).textTheme.bodyText1! .color,
                              prefixIconsSize: 20,
                              headingText: 'pointsRequestStatus'.tr().toString(),
                              captionText: 'checkStatus'.tr().toString(),
                              captionTextWidth: context.deviceWidth - 125,
                              sufixIcon: Icons.arrow_forward_ios_rounded,
                              sufixIconColor: Theme.of(context).textTheme.bodyText1!.color,
                              sufixIconsSize: 20,
                            ),

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

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
