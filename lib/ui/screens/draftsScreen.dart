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
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/draftsViewModel.dart';
import 'package:lekhny/viewModel/pofilePostsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class DraftScreen extends StatefulWidget {
  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  //const DraftScreen({Key? key}) : super(key: key);


  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  dynamic headers;

  @override
  void initState() {

    final profilePostsViewModel = Provider.of<ProfilePostsViewModel>(context, listen: false);

    profilePostsViewModel.unPublishedPostData = [];

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

        profilePostsViewModel.getUnPublishedPostData(headers, page, false);
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
                  Text('Drafts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Icon(Icons.search_rounded,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
          body: Consumer<ProfilePostsViewModel>(
              builder: (context,value,child){

                switch(value.profilePostsData.status){
                  case Status.LOADING :
                    return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )
                    );

                  case Status.ERROR :
                    return Text('${value.profilePostsData.message.toString()} this is the error');

                  case Status.COMPLETED :
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (value.load == true)? (value.unPublishedPostData.length + 1) : value.unPublishedPostData.length ,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < value.unPublishedPostData.length){
                                imageBaseUrl = (value.unPublishedPostData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                (value.unPublishedPostData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.unPublishedPostData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                                return Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: (index == value.unPublishedPostData!.length -1)?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Container(
                                        width: 80,
                                        height: 120,
                                        margin: EdgeInsets.symmetric(horizontal: 15),
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 1 /1.5,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                            child: CachedNetworkImage(
                                              imageUrl: "${imageBaseUrl}${value.unPublishedPostData![index].bookCover}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 120,
                                        width: context.deviceWidth - 125,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //mainAxisSize: MainAxisSize.max,
                                            children: [
                                              SizedBox(
                                                width: context.deviceWidth - 150,
                                                child: Text("${value.unPublishedPostData![index].title}",
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                  textAlign: TextAlign.start,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              (value.tappedIndex == index)?
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: CupertinoActivityIndicator(
                                                    color: primaryColor
                                                ),
                                              ):
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      value.setTappedIndex(index);
                                                      value.getSingleBookData(
                                                          value.unPublishedPostData![index].postID.toString(),
                                                          null,
                                                          headers,
                                                          context);
                                                      // Navigator.pushNamed(context, RoutesName.textEditorScreen,
                                                      //     arguments: {"postId" : "${value.unPublishedPostData![index].postID}", "isContest" : '2', "contestId": null }
                                                      // );
                                                    },
                                                    child: Text("Edit Draft",
                                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                          color: primaryColor,
                                                          height:  1
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(Icons.arrow_forward_rounded,
                                                    size: 14,
                                                    color: primaryColor,
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: OutlineButtonBig(
                                                  onTap: (){

                                                  },
                                                  height: 25,
                                                  width: 80,
                                                  backgroundColor: Theme.of(context).canvasColor,
                                                  text: 'Delete',
                                                  showProgress: false,
                                                  radius: radiusValue,
                                                  fontSize: 12,
                                                  letterspacing: 0.2,
                                                  textColor: Theme.of(context).textTheme.subtitle1!.color,
                                                  borderColor: Theme.of(context).textTheme.subtitle1!.color,
                                                  borderWidth: 1,

                                                ),
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              //   crossAxisAlignment: CrossAxisAlignment.end,
                                              //
                                              //   children: [
                                              //
                                              //     SizedBox(width: verticalSpaceSmall),
                                              //     OutlineButtonBig(
                                              //       onTap: (){
                                              //
                                              //       },
                                              //       height: 25,
                                              //       width: 80,
                                              //       backgroundColor: Theme.of(context).canvasColor,
                                              //       text: 'Publish',
                                              //       showProgress: false,
                                              //       radius: radiusValue,
                                              //       fontSize: 12,
                                              //       letterspacing: 0.2,
                                              //       textColor: primaryColor,
                                              //       borderColor: primaryColor,
                                              //       borderWidth: 1,
                                              //
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15,)
                                    ],
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

  Future <void> _scroll ()async{
    final profilePostsViewModel = Provider.of<ProfilePostsViewModel>(context, listen: false);
    if (profilePostsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);
      await profilePostsViewModel.getUnPublishedPostData(headers, page, true);

      //paginationViewModel.setLoad(false);

    }
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
