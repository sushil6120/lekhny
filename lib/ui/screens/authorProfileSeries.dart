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
import 'package:lekhny/viewModel/writerPostsViewModel.dart';
import 'package:provider/provider.dart';

class AuthorProfileSeries extends StatefulWidget {
  String? writerId;
  AuthorProfileSeries({this.writerId});
  @override
  State<AuthorProfileSeries> createState() => _AuthorProfileSeriesState();
}

class _AuthorProfileSeriesState extends State<AuthorProfileSeries> {
  //const ProfilePosts({Key? key}) : super(key: key);

  int page = 1;

  final ScrollController scrollController = ScrollController();
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  var headers;

  @override
  void initState() {

    final writerPostsViewModel = Provider.of<WriterPostsViewModel>(context, listen: false);

    writerPostsViewModel.writerSeriesData = [];

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

        writerPostsViewModel.getWriterSeriesData(null, headers, widget.writerId, page, false);
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
    return Consumer<WriterPostsViewModel>(
        builder: (context,value,child){
          //print('satus ${value.homePageData.status}');
          //print('value ${value.homePageData.data![0]!.data!.length}');
          switch(value.writerPostsData.status){
            case Status.LOADING :
              return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  )
              );

            case Status.ERROR :
              return Text('${value.writerPostsData.message.toString()} this is the error');

            case Status.COMPLETED :
              return Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom:verticalSpaceSmall, top: verticalSpaceSmall),
                child: GridView.count(
                    controller: scrollController,
                    physics: BouncingScrollPhysics(),
                    childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
                    shrinkWrap: true,
                    crossAxisCount: (context.deviceWidth>500)?6:3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 0,
                    children: List.generate(
                        (value.load == true)? (value.writerSeriesData.length + 1) : value.writerSeriesData.length ,
                            (index){
                          if (index < value.writerSeriesData.length){
                            // imageBaseUrl = (value.writerSeriesData[index].bookLanguage == "3")?AppUrl.englishImagebaseUrl:
                            // (value.writerSeriesData[index].bookLanguage == "2")?AppUrl.hindiImagebaseUrl:(value.writerSeriesData[index].bookLanguage == "4")?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
                            return BookWidget(
                                onTap: (){
                                  Navigator.pushNamed(context, RoutesName.bookDetailsScreen,
                                      arguments: {"postId" : value.writerSeriesData[index].id.toString()}
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
                                imgUrl: "${imageBaseUrl}${value.writerSeriesData[index].bookCoverImage}",
                                viewsValue: "",
                                bookTextWidth: 100,
                                bookName: "${value.writerSeriesData[index].bookTitle}",
                                bookNameSpace: 0,
                                writerTextWidth: 0,
                                writerName: "${value.writerSeriesData[index].name}",
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
              );

          }
          return Container();

        }
    );
  }

  Future <void> _scroll ()async{
    print("scroll working");
    final writerPostsViewModel = Provider.of<WriterPostsViewModel>(context, listen: false);
    if (writerPostsViewModel.load == true){
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {

      page = page + 1;
      print(page);

      await writerPostsViewModel.getWriterSeriesData(null, headers, widget.writerId, page, true);

    }
  }
}
