import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/pofilePostsViewModel.dart';
import 'package:lekhny/viewModel/profileViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class ProfilePosts extends StatefulWidget {
  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

class _ProfilePostsState extends State<ProfilePosts> {
  //const ProfilePosts({Key? key}) : super(key: key);
  final List<String> items = [
    'Published',
    'Drafts',
    'Series',
  ];

  int page = 1;

  String? selectedValue = 'Published';

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  var headers;

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
    print("build");
    final themeManager = Provider.of<ThemeManager>(context);
    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
    return CustomScrollView(
        //primary: false,
        //shrinkWrap: false,
        controller: scrollController,
        //scrollBehavior: ScrollBehavior(),
        physics: BouncingScrollPhysics(),
        slivers: [
          Consumer<ProfilePostsViewModel>(
              builder: (context,value,child){
                return SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: verticalSpaceSmall),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                      color: Theme.of(context).canvasColor,
                    ),
                    height: 50,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('yourStories'.tr().toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            //underline: Divider(height: 2, color: primaryColor,),
                            selectedItemHighlightColor: Theme.of(context).canvasColor,
                            selectedItemBuilder: (BuildContext context){
                              return <Widget>[
                                Center(
                                  child: Text('Published',
                                    style: TextStyle(
                                        color: primaryColor
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text('Drafts',
                                    style: TextStyle(
                                        color: primaryColor
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text('Series',
                                    style: TextStyle(
                                        color: primaryColor
                                    ),
                                  ),
                                ),
                              ];
                            },
                            icon: Icon(Icons.arrow_drop_down_rounded,
                            ),
                            style: Theme.of(context).textTheme.bodyText2,
                            hint: Text(selectedValue.toString()),
                            items: items
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                                .toList(),
                            value: value.selectedValue,
                            onChanged: (dropDownValue)async {

                              value.setSelectedValue(dropDownValue);

                              if(value.selectedValue == 'Published'){
                                page = 1;
                                value.publishedPostData =[];
                                //await value.getPostsBySubCategoryData(null, headers, subCategoryId, page, false);
                                await value.getPublishedPostData(headers, page, false);

                              }else if(value.selectedValue == 'Drafts'){
                                page = 1;
                                value.unPublishedPostData =[];
                                await value.getUnPublishedPostData(headers, page, false);

                              }else if(value.selectedValue == 'Series'){
                                page = 1;
                                value.publishedSeriesData =[];
                                await value.getPublishedSeriesData(headers, page, false);

                              }
                            },
                            buttonSplashColor: Colors.transparent,
                            buttonHighlightColor: Colors.transparent,
                            //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
                            iconSize: 24,
                            iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
                            // iconDisabledColor: Colors.grey,
                            buttonHeight: 25,
                            buttonWidth: 90,
                            buttonPadding: EdgeInsets.only(left: 0, right: 0),
                            // buttonDecoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(radiusValue),
                            //   border: Border.all(
                            //     color: Theme.of(context).textTheme.bodyText1!.color!,
                            //   ),
                            //   color: Colors.transparent,
                            // ),
                            //buttonElevation: 2,
                            itemHeight: 40,
                            //itemPadding: const EdgeInsets.only(left: 15, right: 15),
                            dropdownMaxHeight: 150,
                            dropdownWidth: 120,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              // border: Border(
                              //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
                              // ),
                              borderRadius: BorderRadius.circular(radiusValue),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            dropdownElevation: 1,
                            //scrollbarRadius: const Radius.circular(40),
                            //scrollbarThickness: 6,
                            //scrollbarAlwaysShow: true,
                            offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }
          ),

          Consumer<ProfilePostsViewModel>(
              builder: (context,value,child){
                //print('satus ${value.homePageData.status}');
                //print('value ${value.homePageData.data![0]!.data!.length}');
                switch(value.profilePostsData.status){
                  case Status.LOADING :
                    return SliverToBoxAdapter(
                      child: Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )
                      ),
                    );

                  case Status.ERROR :
                    return SliverToBoxAdapter(
                      child: Text('${value.profilePostsData.message.toString()} this is the error'),
                    );

                  case Status.COMPLETED :
                    return (value.selectedValue == "Published")?
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom:verticalSpaceSmall),
                        child: GridView.count(
                            childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
                            shrinkWrap: true,
                            crossAxisCount: (context.deviceWidth>500)?6:3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 0,
                            children: List.generate(
                                (value.load == true)? (value.publishedPostData.length + 1) : value.publishedPostData.length ,
                                    (index){
                                  if (index < value.publishedPostData.length){
                                    imageBaseUrl = (value.publishedPostData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                    (value.publishedPostData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.publishedPostData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                                    return BookWidget(
                                        onTap: (){
                                          Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                              arguments: {"postId" : value.publishedPostData[index].postID.toString()}
                                          );
                                        },
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        showParts: false,
                                        showViews: false,
                                        showBookTitle: true,
                                        showWriter: false,
                                        partsValue: "",
                                        partsSpace: 0,
                                        imgSpace: 10,
                                        imageHeight: 100,
                                        imageWidth: 150,
                                        imgUrl: "${imageBaseUrl}${value.publishedPostData[index].bookCover}",
                                        viewsValue: "",
                                        bookTextWidth: 100,
                                        bookName: "${value.publishedPostData[index].title}",
                                        bookNameSpace: 0,
                                        writerTextWidth: 0,
                                        writerName: ""
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
                                }
                            )
                        ),
                      ),
                    ):
                    (value.selectedValue == "Drafts")?
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, bottom:verticalSpaceSmall),
                        child: GridView.count(
                            childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
                            shrinkWrap: true,
                            crossAxisCount: (context.deviceWidth>500)?6:3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 0,
                            children: List.generate(
                                (value.load == true)? (value.unPublishedPostData.length + 1) : value.unPublishedPostData.length ,
                                    (index){
                                  if (index < value.unPublishedPostData.length){
                                    imageBaseUrl = (value.unPublishedPostData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                    (value.unPublishedPostData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.unPublishedPostData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                                    return BookWidget(
                                        onTap: (){
                                          Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                              arguments: {"postId" : value.unPublishedPostData[index].postID.toString(), "baseUrl" : imageBaseUrl.toString() }
                                          );
                                        },
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        showParts: false,
                                        showViews: false,
                                        showBookTitle: true,
                                        showWriter: false,
                                        partsValue: "",
                                        partsSpace: 0,
                                        imgSpace: 10,
                                        imageHeight: 100,
                                        imageWidth: 150,
                                        imgUrl: "${imageBaseUrl}${value.unPublishedPostData[index].bookCover}",
                                        viewsValue: "",
                                        bookTextWidth: 100,
                                        bookName: "${value.unPublishedPostData[index].title}",
                                        bookNameSpace: 0,
                                        writerTextWidth: 0,
                                        writerName: ""
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
                                }
                            )
                        ),
                      ),
                    ):
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, bottom:verticalSpaceSmall),
                        child: GridView.count(
                            childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
                            shrinkWrap: true,
                            crossAxisCount: (context.deviceWidth>500)?6:3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 0,
                            children: List.generate(
                                (value.load == true)? (value.publishedSeriesData.length + 1) : value.publishedSeriesData.length ,
                                    (index){
                                  if (index < value.publishedSeriesData.length){
                                    imageBaseUrl = (value.publishedSeriesData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                                    (value.publishedSeriesData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.publishedSeriesData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;

                                    return BookWidget(
                                        onTap: (){
                                          Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                              arguments: {"postId" : value.publishedSeriesData[index].postID.toString(), "baseUrl" : imageBaseUrl.toString() }
                                          );
                                        },
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        showParts: false,
                                        showViews: false,
                                        showBookTitle: true,
                                        showWriter: false,
                                        partsValue: "",
                                        partsSpace: 0,
                                        imgSpace: 10,
                                        imageHeight: 100,
                                        imageWidth: 150,
                                        imgUrl: "${imageBaseUrl}${value.publishedSeriesData[index].bookCover}",
                                        viewsValue: "",
                                        bookTextWidth: 100,
                                        bookName: "${value.publishedSeriesData[index].title}",
                                        bookNameSpace: 0,
                                        writerTextWidth: 0,
                                        writerName: ""
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
                                }
                            )
                        ),
                      ),
                    );

                }
                return SliverToBoxAdapter(child: Container());

              }
          ),


        ]
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
      if (profilePostsViewModel.selectedValue == "Published"){
        //await profilePostsViewModel.getPostsByCategoryData(null, headers, "${widget.args!["categoryID"]}",page, true);
        await profilePostsViewModel.getPublishedPostData(headers, page, true);
      }else if (profilePostsViewModel.selectedValue == "Drafts"){
        await profilePostsViewModel.getUnPublishedPostData(headers, page, true);
      }else if (profilePostsViewModel.selectedValue == "Series"){
        await profilePostsViewModel.getPublishedSeriesData(headers, page, true);
      }

      //paginationViewModel.setLoad(false);

    }
  }
}
