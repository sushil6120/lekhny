import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
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
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/ui/widget/profile%20page%20widget/writersInfoTextWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/demoText.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/upcomingBookDetailsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:lekhny/viewModel/upcomingBookDetailsViewModel.dart';
import 'package:provider/provider.dart';

class UpcomingBookScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  UpcomingBookScreen(this.args);

  @override
  State<UpcomingBookScreen> createState() => _UpcomingBookScreenState();
}

class _UpcomingBookScreenState extends State<UpcomingBookScreen> {

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  String? bookId;

  @override
  void initState() {

    final upcomingBookDetailsViewModel = Provider.of<UpcomingBookDetailsViewModel>(context, listen: false);
    bookId = widget.args!["bookId"];
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
        upcomingBookDetailsViewModel.getUpcomingBookDetailsData(bookId!, null, headers);
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
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: Theme.of(context).brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBarBackButton(),
                //SizedBox(width: 30),
                Icon(Icons.search_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            ),
          ),
        ),
        body: Consumer<UpcomingBookDetailsViewModel>(
            builder: (context,value,child){
              //print('satus ${value.homePageData.status}');
              //print('value ${value.homePageData.data![0]!.data!.length}');
              switch(value.upcomingBookDetailsData.status){
                case Status.LOADING :
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  );

                case Status.ERROR :
                  return Text('${value.upcomingBookDetailsData.message.toString()} this is the error');

                case Status.COMPLETED :
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
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
                                    imageUrl: "${AppUrl.upcomingBookImagebaseUrl}${value.upcomingBookDetailsModel!.data!.bookDetails!.bookImage}",
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: verticalSpaceSmall),
                          Align(
                            alignment: Alignment.center,
                            child: Text("${value.upcomingBookDetailsModel!.data!.bookDetails!.booktitle}",
                              style: Theme.of(context).textTheme.subtitle1,
                              textAlign: TextAlign.center,
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 2),
                          Align(
                            alignment: Alignment.center,
                            child: Text("${value.upcomingBookDetailsModel!.data!.bookDetails!.writerName}",
                                style: Theme.of(context).textTheme.bodyText2
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: verticalSpaceMedium, bottom: verticalSpaceSmall),
                            child: Divider(color: Theme.of(context).disabledColor),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("About This Book",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: verticalSpaceSmall2, bottom: verticalSpaceMedium),
                            child: Text("${value.upcomingBookDetailsModel!.data!.bookDetails!.bookDetails}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text("About Author",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right: 15, top: verticalSpaceSmall2, bottom: verticalSpaceMedium),
                            child: Text("${value.upcomingBookDetailsModel!.data!.bookDetails!.writerDetails}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15, right:15, bottom: verticalSpaceSmall),
                            child: Text("More Upcoming Books",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          Container(
                            height: 205,
                            margin: EdgeInsets.only(bottom: verticalSpaceSmall),
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: value.upcomingBookDetailsModel!.data!.anotherBooks!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: (context.locale == Locale('ur'))?
                                  (index== 0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(left: 15):
                                  (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),

                                  child: BookWidget(
                                    onTap: (){
                                      Navigator.pushNamed(context, RoutesName.upcomingBookScreen,
                                          arguments: {"bookId" : "${value.upcomingBookDetailsModel!.data!.anotherBooks![index].bookID}"}
                                      );

                                    },
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    showParts: false,
                                    showViews: false,
                                    showBookTitle: true,
                                    showWriter: true,
                                    partsValue: "",
                                    partsSpace: 0,
                                    imgSpace: 10,
                                    imageHeight: 100,
                                    imageWidth: 150,
                                    imgUrl: "${AppUrl.upcomingBookImagebaseUrl}${value.upcomingBookDetailsModel!.data!.anotherBooks![index].bookImage}",
                                    viewsValue: "0",
                                    bookTextWidth: 100,
                                    bookName: "${value.upcomingBookDetailsModel!.data!.anotherBooks![index].booktitle}",
                                    bookNameSpace: 4,
                                    writerTextWidth: 100,
                                    writerName: "${value.upcomingBookDetailsModel!.data!.anotherBooks![index].writerName}",
                                  ),
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  );

              }
              return Container();

            }
        ),
        bottomNavigationBar: Consumer<UpcomingBookDetailsViewModel>(
            builder: (context,value,child){
              //print('satus ${value.homePageData.status}');
              //print('value ${value.homePageData.data![0]!.data!.length}');
              switch(value.upcomingBookDetailsData.status){
                case Status.LOADING :
                  return SizedBox();

                case Status.ERROR :
                  return SizedBox();

                case Status.COMPLETED :
                  return InkWell(
                    onTap:(){
                      launchUrlStart(url: "${value.upcomingBookDetailsModel!.data!.bookDetails!.buyLink}");
                    },
                    child: Container(
                      height: bigButtonHeight,
                      width: context.deviceWidth,
                      decoration: BoxDecoration(
                          color: primaryColor
                      ),
                      alignment: Alignment.center,
                      child: Text('Buy Now',
                        style: Theme.of(context).textTheme.button!.copyWith(
                            color: colorLightWhite,
                            letterSpacing: 0
                        ),
                      ),
                    ),
                  );

              }
              return Container();

            }
        ),
      ),
    );
  }
  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

}

//Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children :[
//                             Text('Buy now on',
//                               style: Theme.of(context).textTheme.button!.copyWith(
//                                   color: colorLightWhite,
//                                   letterSpacing: 0
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Padding(
//                                 padding: EdgeInsets.only(bottom: 5, top: 14.5),
//                                 child: SvgPicture.asset(amazon, height: 17, width: 35, color: colorLightWhite))
//                           ]
//                       ),
