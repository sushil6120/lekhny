import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
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
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/topTenWritersScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/extensions.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/draftsViewModel.dart';
import 'package:lekhny/viewModel/lekhnyPointsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PointsCreditedScreen extends StatefulWidget {
  @override
  State<PointsCreditedScreen> createState() => _PointsCreditedScreenState();
}

class _PointsCreditedScreenState extends State<PointsCreditedScreen> {
  //const PointsCreditedScreen({Key? key}) : super(key: key);

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
          centerTitle: true,
          elevation: 0.5,
          leading: AppBarBackButton(),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Points Credited',
            style: Theme.of(context).textTheme.headline6,
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.allPointsDetailsModel!.data!.dipositPoint!.length,
                            separatorBuilder: (BuildContext context, int index) {
                              return Divider(
                                height: 0.1,
                                color: Theme.of(context).disabledColor,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {

                              return Container(
                                width: context.deviceWidth,
                                padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
                                margin: EdgeInsets.only(bottom: 1),
                                decoration: BoxDecoration(

                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("${index+1}",
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                        SizedBox(width: 25),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: context.deviceWidth- 150,
                                              child: Text("${value.allPointsDetailsModel!.data!.dipositPoint![index].dipositDate}".formatDate(),
                                                style: Theme.of(context).textTheme.subtitle2,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text("Points Credited by Lekhny",
                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text("+${"${value.allPointsDetailsModel!.data!.dipositPoint![index].dipositPoint}.0"}",
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                          color: primaryColor
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        //SizedBox(height: verticalSpaceSmall),

                      ],
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
