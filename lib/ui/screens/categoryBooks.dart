import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/screens/demoPage.dart';
import 'package:lekhny/ui/screens/settingsScreen.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lekhny/viewModel/categoryBookViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class CategoryBooksScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  CategoryBooksScreen(this.args);

  @override
  State<CategoryBooksScreen> createState() => _CategoryBooksScreenState();
}

class _CategoryBooksScreenState extends State<CategoryBooksScreen> {

  final ScrollController scrollController = ScrollController();

  int page = 1;

  String? selectedValue;
  String? subCategoryId;

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  //CategoryBookViewModel categoryBookViewModel = CategoryBookViewModel();

  String? appLanguage;
  String? imageBaseUrl;
  var headers;

  @override
  void initState() {


    final categoryBookViewModel = Provider.of<CategoryBookViewModel>(context, listen: false);

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

        print(" this is headers ${headers}");
        print("this is id ${widget.args!["categoryID"]}");
        categoryBookViewModel.getSubCategoryData("${widget.args!["categoryID"]}", null, headers);
        categoryBookViewModel.getPostsByCategoryData(null, headers, "${widget.args!["categoryID"]}",page, false);
        print("init is working");

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
                  Text("${widget.args!["categoryName"]}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Consumer<SearchScreenViewModel>(builder: (BuildContext context, value, Widget? child){
                    return GestureDetector(
                      onTap: (){
                        value.textFieldLength = 0;
                        Navigator.pushNamed(context, RoutesName.searchScreen);
                      },
                      child: Icon(
                        Icons.search_rounded,color: Theme.of(context).textTheme.headline4!.color,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          body: Consumer<CategoryBookViewModel>(
              builder: (context,value,child){
                //print('satus ${value.homePageData.status}');
                //print('value ${value.homePageData.data![0]!.data!.length}');
                switch(value.subCategoryData.status){
                  case Status.LOADING :
                    return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        )
                    );

                  case Status.ERROR :
                    return Text('${value.subCategoryData.message.toString()} this is the error');

                  case Status.COMPLETED :
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: verticalSpaceSmall2),
                        SizedBox(
                          //color: Colors.grey,
                          height: 35,
                          child: ListView.builder(

                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: value.subCategoryModel!.data!.length +1,
                            itemBuilder: (BuildContext context, int index) {
                              return (index == 0)? GestureDetector(
                                onTap: (){
                                  page = 1;
                                  value.setTappedIndex(index);
                                  value.subCategoryBookData =[];
                                  subCategoryId = null;
                                  value.setIsAll(true);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: (value.tappedIndex == index)?primaryColor:Theme.of(context).scaffoldBackgroundColor
                                  ),
                                  margin: (context.locale == Locale('ur'))?
                                  (index== 0)?EdgeInsets.only(left: 15, right: 15, top: 1,bottom: 1):EdgeInsets.only(left: 15, top: 1,bottom: 1):
                                  (index==0)?EdgeInsets.only(left: 15, right: 15,top: 1,bottom: 1):EdgeInsets.only(right: 15, top: 1,bottom: 1),
                                  padding: const EdgeInsets.symmetric(horizontal: 10,) ,
                                  child: Text(
                                    'All',
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: (value.tappedIndex == index)?colorLightWhite:Theme.of(context).textTheme.bodyText2!.color
                                    ),
                                  ),
                                ),
                              ):GestureDetector(
                                onTap: ()async{
                                  page = 1;
                                  value.setTappedIndex(index);
                                  value.setIsAll(false);
                                  value.subCategoryBookData =[];
                                  subCategoryId = '${value.subCategoryModel!.data![index-1].subCatID}';
                                  await value.getPostsBySubCategoryData(null, headers, subCategoryId, page, false);

                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: Theme.of(context).disabledColor),
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: (value.tappedIndex == index)?primaryColor:Theme.of(context).scaffoldBackgroundColor
                                  ),
                                  margin: (context.locale == Locale('ur'))?
                                  (index== 0)?EdgeInsets.only(left: 15, right: 15, top: 1,bottom: 1):EdgeInsets.only(left: 15, top: 1,bottom: 1):
                                  (index==0)?EdgeInsets.only(left: 15, right: 15,top: 1,bottom: 1):EdgeInsets.only(right: 15, top: 1,bottom: 1),
                                  padding: const EdgeInsets.symmetric(horizontal: 10,) ,
                                  child: Text(
                                    '${value.subCategoryModel!.data![index-1].subCategory}',
                                    style: Theme.of(context).textTheme.caption!.copyWith(
                                        color: (value.tappedIndex == index)?colorLightWhite:Theme.of(context).textTheme.bodyText2!.color
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: verticalSpaceSmall2),
                        (value.isAll == true)?
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5, top: verticalSpaceSmall2),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                        (value.load == true)? (value.categoryBookData.length + 1) : value.categoryBookData.length ,
                                        (index){
                                          if (index < value.categoryBookData.length){
                                            return GestureDetector(
                                              onTap: (){
                                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                                //     subCategoryList: categoryDemoData[index][List],
                                                //     appBarTitle: categoryDemoData[index][String])));
                                              },
                                              child: BookWidget(
                                                  onTap: (){
                                                    Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                        arguments: {"postId" : value.categoryBookData[index].postID.toString() }
                                                    );
                                                  },
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  showParts: false,
                                                  showViews: false,
                                                  showBookTitle: true,
                                                  showWriter: true,
                                                  partsValue: "",
                                                  partsSpace: 0,
                                                  imgSpace: (context.locale == Locale('ur'))?8:10,
                                                  imageHeight: 100,
                                                  imageWidth: 150,
                                                  imgUrl: "${imageBaseUrl}${value.categoryBookData[index].bookCover}",
                                                  viewsValue: "",
                                                  bookTextWidth: 100,
                                                  bookName: "${value.categoryBookData[index].title}",
                                                  bookNameSpace: 4,
                                                  writerTextWidth: 100,
                                                  writerName: "${value.categoryBookData[index].author}"
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
                                        }
                                )
                            ),
                          ),
                        ):
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5,right: 5, top: verticalSpaceSmall2),
                            child: GridView.count(
                                controller: scrollController,
                                physics: BouncingScrollPhysics(),

                                childAspectRatio: (context.deviceWidth>500)?1/1.75:1/1.9,
                                shrinkWrap: true,
                                crossAxisCount: (context.deviceWidth>500)?6:3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                children: List.generate(
                                    (value.load == true)? (value.subCategoryBookData.length + 1) : value.subCategoryBookData.length ,
                                        (index){
                                      if (index < value.subCategoryBookData.length){
                                        return GestureDetector(
                                          onTap: (){
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
                                            //     subCategoryList: categoryDemoData[index][List],
                                            //     appBarTitle: categoryDemoData[index][String])));
                                          },
                                          child: BookWidget(
                                              onTap: (){
                                                Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                                    arguments: {"postId" : value.subCategoryBookData[index].postID.toString() }
                                                );
                                              },
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              showParts: false,
                                              showViews: false,
                                              showBookTitle: true,
                                              showWriter: true,
                                              partsValue: "",
                                              partsSpace: 0,
                                              imgSpace: (context.locale == Locale('ur'))?8:10,
                                              imageHeight: 100,
                                              imageWidth: 150,
                                              imgUrl: "${imageBaseUrl}${value.subCategoryBookData[index].postCoverImage}",
                                              viewsValue: "",
                                              bookTextWidth: 100,
                                              bookName: "${value.subCategoryBookData[index].postTitle}",
                                              bookNameSpace: 4,
                                              writerTextWidth: 100,
                                              writerName: "${value.subCategoryBookData[index].autherName}"
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
                                    }
                                )
                            ),
                          ),
                        )
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
    final categoryBookViewModel = Provider.of<CategoryBookViewModel>(context, listen: false);
    if (categoryBookViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);
      if (categoryBookViewModel.isAll == true){
      await categoryBookViewModel.getPostsByCategoryData(null, headers, "${widget.args!["categoryID"]}",page, true);
      }else{
        await categoryBookViewModel.getPostsBySubCategoryData(null, headers, subCategoryId, page, true);
      }

    }
  }

}

//(index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
//(index==0)?EdgeInsets.only(left: 30, top:5,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:5,bottom: verticalSpaceSmall),
