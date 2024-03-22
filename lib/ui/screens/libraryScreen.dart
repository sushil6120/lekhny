import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/model/languageCategoryModelClass.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookListContainer.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/screens/categoryBooks.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/searchTextFormFieldBig.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/categoryBookViewModel.dart';
import 'package:lekhny/viewModel/categoryViewModel.dart';
import 'package:lekhny/viewModel/searchScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  CategoryViewModel categoryViewModel = CategoryViewModel();

  String? appLanguage;
  String? imageBaseUrl;

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
        categoryViewModel.getCategoryData(null, headers);
        print("init is working");

      });
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final categoryBookViewModel = Provider.of<CategoryBookViewModel>(context, listen: false);

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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            elevation: 1,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('library'.tr().toString(),
              style: Theme.of(context).textTheme.headline6,
            ),
            centerTitle: true,
          ),

            body: ChangeNotifierProvider<CategoryViewModel>(
              create: (BuildContext context)=> categoryViewModel,
              child: Consumer<CategoryViewModel>(
                  builder: (context,value,child){
                    //print('satus ${value.homePageData.status}');
                    //print('value ${value.homePageData.data![0]!.data!.length}');
                    switch(value.categoryData.status){
                      case Status.LOADING :
                        return Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            )
                        );

                      case Status.ERROR :
                        return Text('${value.categoryData.message.toString()} this is the error');

                      case Status.COMPLETED :
                        return CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          primary: false,
                          shrinkWrap: true,
                          slivers: [
                            SliverToBoxAdapter(
                              child: SizedBox(height: verticalSpaceSmall-4),
                            ),
                            SliverAppBar(
                              elevation: 0,
                              automaticallyImplyLeading: false,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              floating: true,
                              //pinned: true,
                              centerTitle: true,
                              pinned: true,
                              flexibleSpace: FlexibleSpaceBar(
                                  expandedTitleScale: 1,
                                  titlePadding: EdgeInsets.only(top: 12, bottom: 4),
                                  centerTitle: true,
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Consumer<SearchScreenViewModel>(builder: (BuildContext context, value, Widget? child){
                                          return SearchTextFormFieldBig(
                                            onTap: (){
                                              value.textFieldLength = 0;
                                              Navigator.pushNamed(context, RoutesName.searchScreen);

                                            },
                                            hintText: 'Search Book',
                                            height: 40,
                                            suffixIcon: Icon(Icons.search,
                                              color: Theme.of(context).disabledColor,
                                              size: 16,
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SizedBox(height: verticalSpaceSmall-4),
                            ),
                            SliverToBoxAdapter(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  HeadingRowWidget(
                                      headingText: 'category'.tr().toString(),
                                      textButton: '',
                                      showTextButton: false,
                                      onTap: (){}
                                  ),
                                  SizedBox(height: verticalSpaceSmall),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    child: GridView.count(
                                        physics: ScrollPhysics(),
                                        childAspectRatio: 2/1.2,
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        children: List.generate(
                                            value.categoryModel!.data!.length, (index) => GestureDetector(
                                              onTap: (){
                                                categoryBookViewModel.categoryBookData = [];
                                                categoryBookViewModel.isAll = true;
                                                categoryBookViewModel.tappedIndex = 0;
                                                categoryBookViewModel.subCategoryBookData =[];
                                                Navigator.pushNamed(context, RoutesName.categoryBookScreen,
                                                    arguments: {"categoryName" : "${value.categoryModel!.data![index].categoryName}", "categoryID" : "${value.categoryModel!.data![index].categoryID}"}
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                //width: context.deviceWidth*0.88,
                                                decoration: BoxDecoration(
                                                  // gradient: LinearGradient(
                                                  //     begin: Alignment.centerLeft,
                                                  //     end: Alignment.centerRight,
                                                  //     //stops: [0.0,1.0],
                                                  //     colors: [
                                                  //       colorLight3,
                                                  //     Color(0xff7c6793),
                                                  //
                                                  //     ]),
                                                  color: (themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,
                                                  borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                                ),
                                                height: 145,
                                                // padding: (context.locale == Locale('ur'))?EdgeInsets.only(right: 140, left: 15):EdgeInsets.only(left: 140, right: 15),
                                                // margin: (context.locale == Locale('ur'))?
                                                // (index== 0)?EdgeInsets.only(left: 15, right: 15,):EdgeInsets.only(left: 15):
                                                // (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
                                                child: Stack(
                                                  children: [
                                                    // Align(
                                                    //     child: Container(
                                                    //       alignment: (context.locale == Locale('ur'))?Alignment.centerLeft:Alignment.centerRight,
                                                    //       child: Image.asset('${categoryDemoData[index]["imgUrl"]}'),
                                                    //     )
                                                    // ),
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(radiusValue),
                                                      child: CachedNetworkImage(
                                                        matchTextDirection: true,
                                                        height: 145,
                                                          placeholder: (context, string){
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                color: (themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,
                                                              ),
                                                            );
                                                          },
                                                          fadeOutDuration: Duration(seconds: 0),
                                                          imageUrl: "${AppUrl.upcomingBookImagebaseUrl}${value.categoryModel!.data![index].categoryImg}",
                                                          fit: BoxFit.cover,
                                                          alignment: Alignment.center,
                                                          errorWidget: (context, url, error) => Container(
                                                              decoration: BoxDecoration(
                                                                  color: (themeManager.themeMode== ThemeMode.dark)?darkModeHighlightColor2:secondaryColorLight,
                                                              ),
                                                          )
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: (context.locale == Locale('ur'))?Alignment.topRight:Alignment.topLeft,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(radiusValue),
                                                        child: Container(
                                                          height: 145,
                                                          //margin: EdgeInsets.only(top:15, left: 15, right: 15),
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                                colors: [Colors.black.withOpacity(0.62), Colors.transparent],
                                                                begin: (context.locale == Locale('ur'))?FractionalOffset.centerRight:FractionalOffset.centerLeft,
                                                                end: (context.locale == Locale('ur'))?FractionalOffset.centerLeft:FractionalOffset.centerRight,
                                                                stops: [0,1]
                                                            ),
                                                          ),
                                                          //alignment: Alignment.bottomLeft,
                                                          width: double.infinity,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10, right:10, top:10 ),
                                                            child: Text('${value.categoryModel!.data![index].categoryName}',
                                                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                                                color: colorLightWhite
                                                              ),
                                                              textAlign: TextAlign.start,
                                                              softWrap: true,
                                                              maxLines: 3,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),


                                                  ],
                                                ),

                                              ),
                                            ))
                                    ),
                                  ),
                                  SizedBox(height: verticalSpaceSmall),

                                ],
                              ),
                            ),
                          ],
                        );

                    }
                    return Container();

                  }
              ),

            ),
        ),
      ),
    );
  }
}
