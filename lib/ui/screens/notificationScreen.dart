import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/allPointsDetailsViewModel.dart';
import 'package:lekhny/viewModel/draftsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //const NotificationScreen({Key? key}) : super(key: key);

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  var headers;



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
          title: Text('Notifications',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: SizedBox(
          width: context.deviceWidth,
          child: Padding(
            padding: EdgeInsets.only(top: verticalSpaceLarge*3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.notifications_active_outlined,
                  size: 100,
                  color: Theme.of(context).disabledColor,
                ),
                SizedBox(height: verticalSpaceMedium),
                Text("No Notifications",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),

                )
              ],

            ),
          ),
        ),
      ),
    );
  }

  Future <void> _scroll ()async{
    print("scroll working");
    final allPointsDetailsViewModel = Provider.of<AllPointsDetailsViewModel>(context, listen: false);
    if (allPointsDetailsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);

      await allPointsDetailsViewModel.getPointsEarnedData(headers, page, true);

      //paginationViewModel.setLoad(false);

    }
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
