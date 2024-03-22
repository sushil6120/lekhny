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

class PublishedPostScreen extends StatefulWidget {
  @override
  State<PublishedPostScreen> createState() => _PublishedPostScreenState();
}

class _PublishedPostScreenState extends State<PublishedPostScreen> {
  //const PublishedPostScreen({Key? key}) : super(key: key);

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  dynamic headers;

  @override
  void initState() {

    final profilePostsViewModel = Provider.of<ProfilePostsViewModel>(context, listen: false);

    profilePostsViewModel.publishedPostData = [];

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

        profilePostsViewModel.getPublishedPostData(headers, page, false);
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
                  Text('Published Posts',
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
                            itemCount: (value.load == true)? (value.publishedPostData.length + 1) : value.publishedPostData.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < value.publishedPostData.length){
                                imageBaseUrl = (value.publishedPostData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                (value.publishedPostData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.publishedPostData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                                return  Container(
                                  width: context.deviceWidth,
                                  padding: EdgeInsets.only(top: 25, bottom: 25),
                                  margin: (index == value.publishedPostData.length -1)?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: verticalSpaceSmall),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 135,
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
                                              imageUrl: "${imageBaseUrl}${value.publishedPostData![index].bookCover}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 135,
                                        width: context.deviceWidth - 135,
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
                                                  SizedBox(
                                                    width: context.deviceWidth - 160,
                                                    child: Text("${value.publishedPostData![index].title}",
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
                                                          Text('${value.publishedPostData![index].views}',
                                                            style: Theme.of(context).textTheme.caption!.copyWith(
                                                                letterSpacing: 0.5
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // SizedBox(width: 15),
                                                      // Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //     Icon(Icons.thumb_up_alt_outlined,
                                                      //       size: 14,
                                                      //       color: Theme.of(context).disabledColor,
                                                      //     ),
                                                      //     SizedBox(width: 2),
                                                      //     Text('${demoData[index]["views"]}',
                                                      //       style: Theme.of(context).textTheme.caption!.copyWith(
                                                      //           letterSpacing: 0.5
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15),
                                                  GestureDetector(
                                                    onTap: (){
                                                      Navigator.pushNamed(context, RoutesName.textEditorScreen,
                                                          arguments: {"postId" : null, "isContest" : '2', "contestId": null, "data" : "","mainPostId": "${value.publishedPostData![index].postID}" }
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Text("Add Next Chapter",
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
                                                  SizedBox(width: verticalSpaceSmall),
                                                  (value.tappedIndex == index)?
                                                  SizedBox(
                                                    height: 25,
                                                    width: 80,
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                                      child: CupertinoActivityIndicator(
                                                          color: primaryColor
                                                      ),
                                                    ),
                                                  ):
                                                  OutlineButtonBig(
                                                    onTap: (){
                                                      value.setTappedIndex(index);
                                                      value.getSingleBookData(
                                                          value.publishedPostData![index].postID.toString(),
                                                          null,
                                                          headers,
                                                          context);

                                                    },
                                                    height: 25,
                                                    width: 80,
                                                    backgroundColor: Theme.of(context).canvasColor,
                                                    text: 'Edit',
                                                    showProgress: false,
                                                    radius: radiusValue,
                                                    fontSize: 12,
                                                    letterspacing: 0.2,
                                                    textColor: primaryColor,
                                                    borderColor: primaryColor,
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
      await profilePostsViewModel.getPublishedPostData(headers, page, true);

      //paginationViewModel.setLoad(false);

    }
  }
}





//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
