import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/services/readingScreenValues.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/ui/global%20widgets/divider.dart';
import 'package:lekhny/ui/global%20widgets/lastPageWidget.dart';
import 'package:lekhny/ui/global%20widgets/readingScreenDrawer.dart';
import 'package:lekhny/ui/widget/settings%20page%20widget/changeThemeSwitchWidget.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/readingScreenViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';
import 'package:html2md/html2md.dart' as html2md;

class ReadingScreen extends StatefulWidget {
  Map<String,dynamic>? args;
  ReadingScreen(this.args);

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {

  final GlobalKey pageKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final PageController _pageController = PageController();

  ReadingScreenViewModel? readingScreenViewModel;
  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();
  ReadingScreenValues readingScreenValues = ReadingScreenValues();

  ValueNotifier<int> _pageNumber = ValueNotifier<int>(1);

  String? appLanguage;
  String? text;
  String? postId;
  var headers;

  @override
  void initState() {
    postId = widget.args!["postId"].toString();
    readingScreenViewModel = Provider.of<ReadingScreenViewModel>(context, listen: false);
    // TODO: implement initState
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
        print(" this is token ${value.toString()}");
        readingScreenViewModel!.getSingleBookData(postId!, null, headers);
        print("init is working");

      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    print('build');
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          statusBarIconBrightness: (themeManager.isDarkMode == true)?Brightness.dark:Brightness.light,
          systemNavigationBarContrastEnforced: false,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Theme.of(context).brightness
      ),
      child: Consumer<ReadingScreenViewModel>(
          builder: (context,value,child){
            //print('value ${value.singleBookDataModel!.data![0].postData}');
            switch(value.singleBookData.status){
              case Status.LOADING :
                return Scaffold(
                  body: Stack(
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          )
                      ),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Container(
                      //       height: context.safeAreaHeight,
                      //       color: Colors.black
                      //   ),
                      // )

                    ],
                  ),
                );

              case Status.ERROR :
                return Scaffold(
                    body: Text('${value.singleBookData.message.toString()} this is the error')
                );

              case Status.COMPLETED :

                TextStyle _textStyle = TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: readingScreenViewModel!.fontSize,
                    color: Theme.of(context).textTheme.headline4!.color
                );
                String? text1 = value.singleBookDataModel!.data![0].postData!;
                String? text2 = text1.replaceAll("<br>", "\n");
                text = html2md.convert(text2).replaceAll("*", "");

                readingScreenValues.getSplittedTextValue(_textStyle, text, context);
                return Scaffold(
                  key: _key,
                  drawer: ReadingScreenDrawer(
                    singleBookPartsModel: value.singleBookPartsModel,
                    currentChapterIndex:  widget.args!["index"],
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                              //padding: EdgeInsets.symmetric(horizontal: 5),
                              key: pageKey,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: PageView.builder(
                                  physics: BouncingScrollPhysics(),
                                  onPageChanged: (value){
                                    _pageNumber.value = value+1;
                                    // readingScreenValues.changeState(val);
                                  },
                                  itemCount: readingScreenValues.splittedTextList.length+1,
                                  controller: _pageController,
                                  itemBuilder: (context, index){
                                    return (index == readingScreenValues.splittedTextList.length)?
                                    LastPageWidget(
                                        singleBookDetailsModel: value.singleBookDetailsModel,
                                        currentChapterIndex: widget.args!["index"],
                                        singleBookPartsModel: value.singleBookPartsModel,
                                        postLikesListModelClass: value.postLikesListModelClass,
                                        postId: postId,
                                        headers: headers,

                                    ):
                                    GestureDetector(
                                      onTap: (){
                                        _settingModalBottomSheet(context, widget.args!["index"], value.singleBookPartsModel!.data![widget.args!["index"]].bookTitle);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 15, right: 15, top: 30),
                                        child: Text(
                                          readingScreenValues.splittedTextList[index],
                                          style: _textStyle,
                                        ),
                                      ),
                                    );
                                  }),

                            )
                        ),
                        // Container(
                        //     height: context.safeAreaHeight,
                        //     color: Colors.black
                        // )

                      ],
                    ),
                  ),
                );

            }
            return Container();

          }
      ),
    );
  }

  void _settingModalBottomSheet(context, int? part, String? bookName){
    showModalBottomSheet(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radiusValue)),
        context: context,
        builder: (BuildContext bc){
          return Padding(
            padding: EdgeInsets.only(top: verticalSpaceSmall, bottom: verticalSpaceSmall),
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CHAPTER - ${part! + 1}",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: primaryColor
                            ),
                          ),
                          SizedBox(height: 5,),
                          SizedBox(
                            width: 250,
                            child: Text("${bookName}",
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          _key.currentState!.openDrawer();
                        },
                        child: Icon(Icons.menu),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: verticalSpaceSmall),
                DividerWidget(),
                SizedBox(height: verticalSpaceSmall),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dark Mode',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Container(
                        width: 40,
                        child: ChangeThemeButtomWidget(),
                      )

                    ],
                  ),
                ),
                SizedBox(height: verticalSpaceSmall),
                Text('Font Size',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: primaryColor,
                    //inactiveTrackColor: p,
                    trackShape: RectangularSliderTrackShape(),
                    trackHeight: 1.5,
                    thumbColor: primaryColor,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  ),
                  child: Container(
                    width: 400,
                    child: StatefulBuilder(
                      builder: (context, state){
                        return Slider(
                          min: 12,
                          max: 32,
                          value: readingScreenViewModel!.fontSize,
                          onChanged: (val) {
                            readingScreenViewModel!.changeFontSize(val);
                            state((){});
                          },
                        );
                      },
                    ),
                  ),
                ),
                _pageControl()

              ],
            ),
          );
        }
    );
  }

  Widget _pageControl(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: (){
              _pageController.animateToPage(
                  0, duration: kDuration, curve: kCurves);

            },
            icon: Icon(Icons.first_page)),
        IconButton(
            onPressed: (){
              _pageController.previousPage(duration: kDuration, curve: kCurves);

            },
            icon: Icon(Icons.navigate_before)),
        ValueListenableBuilder(
          valueListenable: _pageNumber,
          builder: (BuildContext context, value, child){
            return Text("Page ${_pageNumber.value}/${readingScreenValues.splittedTextList.length+1}",
              style: Theme.of(context).textTheme.bodyText2,
            );
          },
        ),
        IconButton(
            onPressed: (){
              _pageController.nextPage(duration: kDuration, curve: kCurves);

            },
            icon: Icon(Icons.navigate_next)),
        IconButton(
            onPressed: (){
              _pageController.animateToPage(
                  readingScreenValues.splittedTextList.length, duration: kDuration, curve: kCurves);

            },
            icon: Icon(Icons.last_page)),


      ],
    );

  }
}
