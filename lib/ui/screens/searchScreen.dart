import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/circularProgressWidget.dart';
import 'package:lekhny/ui/global%20widgets/textFieldLabelTextWidget.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/viewModel/redeemPointsViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/appBarBackButton.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/buttonBigWithIcon.dart';
import 'package:lekhny/ui/global%20widgets/dropdownWidget.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldLong.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/screens/stickydemopage.dart';
import 'package:lekhny/ui/widget/write%20page%20widget/writePageOptionWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/enterBookDetailsScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //const SearchScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();

  TextEditingController searchController = TextEditingController();

  String? appLanguage;
  String? imageBaseUrl;
  String? userProfileImageBaseUrl;
  var headers;


  @override
  void initState() {

    final searchScreenViewModel = Provider.of<SearchScreenViewModel>(context, listen: false);

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

        searchScreenViewModel.getTrendingSearchData(null, headers);

      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override

  Widget build(BuildContext context) {

    userProfileImageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishUserProfileImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiUserProfileImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduUserProfileImagebaseUrl:AppUrl.hindiUserProfileImagebaseUrl;

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Theme.of(context).brightness,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Theme.of(context).brightness
        ),
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              titleSpacing: 0,
              centerTitle: false,
              elevation: 0.5,
              leading: AppBarBackButton(),
              actions: [Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.search,
                    color: primaryColor,
                  )
              )
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Consumer<SearchScreenViewModel>(builder: (BuildContext context, value, Widget? child){
                return TextFormField(
                  onChanged: (textFieldValue){
                    value.setTextFieldLength(textFieldValue);
                    var data = {
                      'searchKey': textFieldValue.toString()
                    };
                    value.getMainSearchData(data, headers);
                  },
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search Books & Writers",
                    hintStyle: TextStyle(
                        color: Theme.of(context).textSelectionTheme.selectionColor
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none
                    ),
                  ),
                );
              }),
            ),
            body: Consumer<SearchScreenViewModel>(builder: (BuildContext context, value, Widget? child){
              return (value.textFieldLength == 0)?SizedBox(
                height: context.actualHeight -context.appBarHeight,
                child: (value.trendingSearchLoading == true)?Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: CupertinoActivityIndicator(
                        color: primaryColor
                    ),
                  ),
                ):ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: (value.trendingSearchModel != null)?value.trendingSearchModel!.data!.length: 0,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: (index == 0)?EdgeInsets.only(left: 15.0, right: 15.0, top: 35, bottom: 35):
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 35),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                arguments: {"postId" : value.trendingSearchModel!.data![index].postID.toString()}
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.trending_up_rounded,
                                    size: 20,
                                    color: Theme.of(context).textTheme.bodyText1!.color,
                                  ),
                                  SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Trending",
                                          style: Theme.of(context).textTheme.caption
                                      ),
                                      SizedBox(height: 5),
                                      SizedBox(
                                        width: context.deviceWidth- 150,
                                        child: Text("${value.trendingSearchModel!.data![index].trandigPost}",
                                            style: Theme.of(context).textTheme.subtitle2,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.search,
                                size: 20,
                                color: Theme.of(context).textTheme.bodyText1!.color,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                )):
                SizedBox(
                  height: context.actualHeight -context.appBarHeight,
                  child: (value.mainSearchLoading == true)?Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CupertinoActivityIndicator(
                          color: primaryColor
                      ),
                    ),
                  ):
                  (value.mainSearchModel == null ||
                      value.mainSearchModel!.data!.writters!.isEmpty && value.mainSearchModel!.data!.postBytitle!.isEmpty )?
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child:  Text("No Results Found",
                          style: Theme.of(context).textTheme.bodyText2
                      ),
                    ),
                  ):
                  CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              //final item = available[index];
                              //if (index > available.length) return null;
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, RoutesName.authorProfileScreen,
                                      arguments: {"writerId" : value.mainSearchModel!.data!.writters![index].authID.toString()}
                                  );
                                },
                                child: Padding(
                                  padding: (index == 0)?const EdgeInsets.only(left: 15.0, right: 15.0, top: 35, bottom: 35):
                                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 35),
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 65,
                                          width: 65,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                            child: (value.mainSearchModel!.data!.writters![index].authProfile != null)?
                                            CachedNetworkImage(
                                              imageUrl: "${AppUrl.profileImagebaseUrl}${value.mainSearchModel!.data!.writters![index].authProfile}",
                                              fit: BoxFit.cover,
                                            ):
                                            Image.asset(blankProfilePicture),
                                          )
                                      ),
                                      SizedBox(width: 18),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: context.deviceWidth- 150,
                                            child: Text("${value.mainSearchModel!.data!.writters![index].authName}",
                                                style: Theme.of(context).textTheme.subtitle2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text("Lekhny Writer",
                                              style: Theme.of(context).textTheme.caption
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ); // you can add your available item here
                            },
                            childCount: (value.mainSearchModel!.data!.writters!.isNotEmpty)?value.mainSearchModel!.data!.writters!.length:0,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              //final item = unavailable[index];
                              //if (index > unavailable.length) return null;
                              return Padding(
                                padding: (index == 0)?EdgeInsets.only(left: 15.0, right: 15.0, top: (value.mainSearchModel!.data!.writters!.isNotEmpty)?0:35, bottom:35):
                                EdgeInsets.only(left: 15.0, right: 15.0, bottom: 35),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                        arguments: {"postId" : value.mainSearchModel!.data!.postBytitle![index].postID.toString()}
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      BookWidget(
                                          onTap: (){},
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          showParts: false,
                                          showViews: false,
                                          showBookTitle: false,
                                          showWriter: false,
                                          partsValue: "",
                                          partsSpace: 0,
                                          imgSpace: 0,
                                          imageHeight: 65,
                                          imageWidth: 95,
                                          imgUrl: "${imageBaseUrl}${value.mainSearchModel!.data!.postBytitle![index].postCover}",
                                          viewsValue: "",
                                          bookTextWidth: 95,
                                          bookName: "",
                                          bookNameSpace: 0,
                                          writerTextWidth: 95,
                                          writerName: ""
                                      ),
                                      SizedBox(width: 18),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: context.deviceWidth- 150,
                                            child: Text("${value.mainSearchModel!.data!.postBytitle![index].postTitle}",
                                                style: Theme.of(context).textTheme.subtitle2,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text("${value.mainSearchModel!.data!.postBytitle![index].authName}",
                                              style: Theme.of(context).textTheme.caption
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ); // you can add your unavailable item here
                            },
                            childCount: (value.mainSearchModel!.data!.postBytitle!.isNotEmpty)?value.mainSearchModel!.data!.postBytitle!.length:0,
                          ),
                        )
                      ]),
                );
            })
            ),
          ),
        );
  }
}




