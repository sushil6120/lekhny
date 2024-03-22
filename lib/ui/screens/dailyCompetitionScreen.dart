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
import 'package:lekhny/utils/extensions.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/DailyCompetitionViewModel.dart';
import 'package:lekhny/viewModel/pofilePostsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class DailyCompetitionScreen extends StatefulWidget {
  @override
  State<DailyCompetitionScreen> createState() => _DailyCompetitionScreenState();
}

class _DailyCompetitionScreenState extends State<DailyCompetitionScreen> {
  //const DailyCompetitionScreen({Key? key}) : super(key: key);

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  dynamic headers;

  @override
  void initState() {

    final dailyCompetitionViewModel = Provider.of<DailyCompetitionViewModel>(context, listen: false);


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

        dailyCompetitionViewModel!.getDailyCompetitionTopicData(null, headers);

      });
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishDailyCompImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiDailyCompImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduDailyCompImagebaseUrl:AppUrl.hindiDailyCompImagebaseUrl;

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
                Text('todayTopics'.tr().toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
                Icon(Icons.search_rounded,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ],
            ),
          ),
        ),
        body: Consumer<DailyCompetitionViewModel>(
            builder: (context,value,child){
              switch(value.dailyCompetitionData.status){
                case Status.LOADING :
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  );

                case Status.ERROR :
                  return Text('${value.dailyCompetitionData.message.toString()} this is the error');

                case Status.COMPLETED :
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(

                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.dailyCompetitionTopicModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return   Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric( vertical: 20),
                              height: 245,
                              width: context.deviceWidth -36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 245,
                                    width: context.deviceWidth -36,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                      child: CachedNetworkImage(
                                        imageUrl: "${imageBaseUrl}${value.dailyCompetitionTopicModel!.data![index].competitionCover}",
                                        fit: BoxFit.cover,
                                        alignment: Alignment.bottomCenter,
                                        // errorBuilder: (BuildContext context, Object exception,
                                        //     StackTrace? stackTrace) {
                                        //   return const Text('😢');
                                        // },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 245,
                                    width: context.deviceWidth -36,
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.all(Radius.circular(radiusValue)),

                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 110,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: colorLight3),
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                          ),
                                          //margin: EdgeInsets.only(left: 15, right: 15, top: 1,bottom: 1),
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2) ,
                                          child: Text("#${value.dailyCompetitionTopicModel!.data![index].competitionType}".toUpperCase(),
                                            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                                color: colorLightWhite
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: 10),
                                        Text("${value.dailyCompetitionTopicModel!.data![index].competitionTitle}",
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.headline5!.copyWith(
                                              color: colorLightWhite
                                          ),

                                        ),
                                        SizedBox(height: 10,),
                                        Text("${value.dailyCompetitionTopicModel!.data![index].competitionDate}".formatDateWoTime(),
                                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                            color: colorLight2
                                        ),
                                        ),
                                        SizedBox(height: 40),
                                        GestureDetector(
                                          onTap: (){

                                            value.setTappedIndex(index);
                                            value.getDailyCompetitionParticipateData(
                                                null,
                                                headers,
                                                value.dailyCompetitionTopicModel!.data![index].competitionID.toString(),
                                                context)
                                            ;

                                          },
                                          child: ButtonBig(
                                            height: 35,
                                            width: 160,
                                            backgroundColor: colorLight2,
                                            text: 'enterContest'.tr().toString(),
                                            showProgress: (value.tappedIndex == index)? true: false,
                                            radius: radiusValue,
                                            progressColor: colorDark1,
                                            progressStrokeWidth: 1.5,
                                            textPadding: 0,
                                            letterspacing: 0,
                                            textColor: colorDark1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]

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
    );
  }

}





//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
