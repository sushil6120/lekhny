import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lekhny/data/response/status.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/outlineButtonBig.dart';
import 'package:lekhny/utils/routes/routesName.dart';
import 'package:lekhny/utils/utilsFunction.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:lekhny/viewModel/publishedSeriesAllPartsViewModel.dart';
import 'package:lekhny/viewModel/sharedPreferencesViewModel.dart';
import 'package:provider/provider.dart';

class PublishedSeriesAllPartsScreen extends StatefulWidget {

  Map<String,dynamic>? args;
  PublishedSeriesAllPartsScreen(this.args);
  @override
  State<PublishedSeriesAllPartsScreen> createState() => _PublishedSeriesAllPartsScreenState();
}

class _PublishedSeriesAllPartsScreenState extends State<PublishedSeriesAllPartsScreen> {
  //const PublishedSeriesAllPartsScreen({Key? key}) : super(key: key);

  SharedPreferencesViewModel sharedPreferencesViewModel = SharedPreferencesViewModel();


  String? appLanguage;
  String? imageBaseUrl;
  dynamic headers;

  @override
  void initState() {

    final publishedSeriesAllPartsViewModel = Provider.of<PublishedSeriesAllPartsViewModel>(context, listen: false);


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

        publishedSeriesAllPartsViewModel.getPublishedSeriesAllPartsData(widget.args!["mainPostId"], null, headers);

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
          centerTitle: false,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Consumer<PublishedSeriesAllPartsViewModel>(builder: (BuildContext context, value, Widget? child){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(value.singleBookPartsModel!.data![value.singleBookPartsModel!.data!.length - 1].publishStatus == 1){

                        Navigator.pushNamed(context, RoutesName.textEditorScreen,
                            arguments: {"postId" : null, "isContest" : '2', "contestId": null, "data" : "","mainPostId": value.singleBookPartsModel!.data![value.singleBookPartsModel!.data!.length - 1].id.toString() }
                        );
                        
                      }else{
                        Utils.toastMessage("Cannot add new chapter. Last chapter is unpublished.");

                      }

                    },
                    child: Text('Add Next Chapter',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: primaryColor
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        body: Consumer<PublishedSeriesAllPartsViewModel>(
            builder: (context,value,child){

              switch(value.publishedSeriesAllPartsData.status){
                case Status.LOADING :
                  return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  );

                case Status.ERROR :
                  return Text('${value.publishedSeriesAllPartsData.message.toString()} this is the error');

                case Status.COMPLETED :
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: value.singleBookPartsModel!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                           return Container(
                             width: context.deviceWidth,
                             padding: EdgeInsets.only(top:20, bottom:20, left: 18, right: 18),
                             margin: (index == value.singleBookPartsModel!.data!.length -1)?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: verticalSpaceExtraSmall),
                             decoration: BoxDecoration(
                                 color: Theme.of(context).canvasColor
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("${index+1}",
                                   style: Theme.of(context).textTheme.bodyText2,
                                 ),
                                 SizedBox(width: 20),
                                 Container(
                                   width: context.deviceWidth - 70,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     //mainAxisSize: MainAxisSize.max,
                                     children: [
                                       Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text((value.singleBookPartsModel!.data![index].publishStatus == 0)?"UNPUBLISHED":"PUBLISHED",
                                             style: Theme.of(context).textTheme.overline!.copyWith(
                                               color: (value.singleBookPartsModel!.data![index].publishStatus == 0)?errorColor:primaryColor
                                             ),
                                             textAlign: TextAlign.start,
                                             softWrap: true,
                                             maxLines: 1,
                                             overflow: TextOverflow.ellipsis,
                                           ),
                                           SizedBox(
                                             width: context.deviceWidth - 160,
                                             child: Text("${value.singleBookPartsModel!.data![index].bookTitle}",
                                               style: Theme.of(context).textTheme.subtitle1,
                                               textAlign: TextAlign.start,
                                               softWrap: true,
                                               maxLines: 1,
                                               overflow: TextOverflow.ellipsis,
                                             ),
                                           ),

                                           (value.tappedIndex == index)?
                                           SizedBox(
                                             height: 25,
                                             child: Align(
                                               alignment: Alignment.bottomLeft,
                                               child: CupertinoActivityIndicator(
                                                   color: primaryColor
                                               ),
                                             ),
                                           ):
                                           GestureDetector(
                                             onTap: (){

                                               value.setTappedIndex(index);
                                               value.getSingleBookData(
                                                   value.singleBookPartsModel!.data![index].id.toString(),
                                                   null,
                                                   headers,
                                                   context);

                                               // Navigator.pushNamed(context, RoutesName.textEditorScreen,
                                               //     arguments: {"postId" : null, "isContest" : '2', "contestId": null, "data" : "","mainPostId": "${value.publishedPostData![index].postID}" }
                                               // );
                                             },
                                             child: SizedBox(
                                               height: 25,
                                               child: Align(
                                                 alignment: Alignment.bottomLeft,
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.center,
                                                   children: [
                                                     Text("Edit Chapter",
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
                                             ),
                                           )
                                           ,
                                         ],
                                       ),
                                       (value.singleBookPartsModel!.data!.length-1 == index)?
                                       Align(
                                         alignment: Alignment.centerRight,
                                         child: Padding(
                                           padding: EdgeInsets.only(top:verticalSpaceSmall ),
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
                                       ):Container(),
                                     ],
                                   ),
                                 ),

                               ],
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
