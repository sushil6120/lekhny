import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lekhny/viewModel/pofilePostsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class PublishedSeriesScreen extends StatefulWidget {
  @override
  State<PublishedSeriesScreen> createState() => _PublishedSeriesScreenState();
}

class _PublishedSeriesScreenState extends State<PublishedSeriesScreen> {
  //const PublishedSeriesScreen({Key? key}) : super(key: key);

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  dynamic headers;

  @override
  void initState() {

    final profilePostsViewModel = Provider.of<ProfilePostsViewModel>(context, listen: false);

    profilePostsViewModel.publishedSeriesData = [];

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

        profilePostsViewModel.getPublishedSeriesData(headers, page, false);
        scrollController.addListener( _scroll);

      });
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

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
                  Text('Published Series',
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
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (value.load == true)? (value.publishedSeriesData.length + 1) : value.publishedSeriesData.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < value.publishedSeriesData.length){
                                imageBaseUrl = (value.publishedSeriesData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                (value.publishedSeriesData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.publishedSeriesData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                                return Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: (index == value.publishedSeriesData.length -1)?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 150,
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
                                              imageUrl: "${imageBaseUrl}${value.publishedSeriesData![index].bookCover}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 150,
                                        width: context.deviceWidth - 150,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [

                                                  Text("Total Parts #${value.publishedSeriesData![index].ttoalPart}",
                                                      style: Theme.of(context).textTheme.caption
                                                  ),
                                                  SizedBox(height: 2),
                                                  SizedBox(
                                                    width: context.deviceWidth - 160,
                                                    child: Text("${value.publishedSeriesData![index].title}",
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                      textAlign: TextAlign.start,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.remove_red_eye_outlined,
                                                            size: 14,
                                                            color: Theme.of(context).disabledColor,
                                                          ),
                                                          SizedBox(width: 2),
                                                          Text("${value.publishedSeriesData![index].totalViwers}",
                                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 15),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.thumb_up_alt_outlined,
                                                            size: 14,
                                                            color: Theme.of(context).disabledColor,
                                                          ),
                                                          SizedBox(width: 2),
                                                          Text("${value.publishedSeriesData![index].totallikes}",
                                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, RoutesName.publishedSeriesAllPartsScreen,
                                                          arguments: {"mainPostId" : "${value.publishedSeriesData![index].mainpostid}" }
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("See All Chapters",
                                                          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                                              color: primaryColor,
                                                              height:  1
                                                          ),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.arrow_forward_rounded,
                                                          size: 14,
                                                          color: primaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.end,

                                                children: [
                                                  OutlineButtonBig(
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
                                                ],
                                              ),
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
    print("scroll working");
    final profilePostsViewModel = Provider.of<ProfilePostsViewModel>(context, listen: false);
    if (profilePostsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);
      await profilePostsViewModel.getPublishedSeriesData(headers, page, true);

      //paginationViewModel.setLoad(false);

    }
  }
}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
