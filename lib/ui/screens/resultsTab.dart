import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lekhny/data/model/monthlyCompetitionResultModelClass.dart';
import 'package:lekhny/provider/themeManagerProvider.dart';
import 'package:lekhny/styles/colors.dart';
import 'package:lekhny/styles/responsive.dart';
import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
import 'package:lekhny/ui/global%20widgets/textFormFieldBig.dart';
import 'package:lekhny/ui/widget/home%20page%20widget/headingRowWidget.dart';
import 'package:lekhny/utils/appUrl.dart';
import 'package:lekhny/utils/demoCaroselData.dart';
import 'package:lekhny/utils/images.dart';
import 'package:lekhny/utils/valueConstants.dart';
import 'package:provider/provider.dart';

class ResultsTab extends StatefulWidget {

  MonthlyCompetitionResultModelClass? monthlyCompetitionResultModel;
  ResultsTab(this.monthlyCompetitionResultModel);

  @override
  State<ResultsTab> createState() => _ResultsTabState();
}

class _ResultsTabState extends State<ResultsTab> {
  //const ResultsTab({Key? key}) : super(key: key);
  final List<String> items = [
    'Daily',
    'Monthly',
    'Yearly',
  ];

  String? selectedValue;
  String? imageBaseUrl;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    imageBaseUrl = (context.locale == Locale('en'))?AppUrl.englishImagebaseUrl:
    (context.locale == Locale('hi'))?AppUrl.hindiImagebaseUrl:(context.locale == Locale('ur'))?AppUrl.urduImagebaseUrl:AppUrl.hindiImagebaseUrl;
    return Scaffold(
      body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // SliverToBoxAdapter(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 15),
            //     //margin: EdgeInsets.symmetric(horizontal: 15),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
            //       color: Theme.of(context).canvasColor,
            //     ),
            //     height: 50,
            //
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text('Contest Results',
            //           style: Theme.of(context).textTheme.bodyText1,
            //         ),
            //         DropdownButtonHideUnderline(
            //           child: DropdownButton2(
            //             isExpanded: true,
            //             //underline: Divider(height: 2, color: primaryColor,),
            //             selectedItemHighlightColor: Theme.of(context).canvasColor,
            //             selectedItemBuilder: (BuildContext conetxt){
            //               return <Widget>[
            //                 Center(
            //                   child: Text('Daily',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text('Monthly',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text('Yearly',
            //                     style: TextStyle(
            //                         color: primaryColor
            //                     ),
            //                   ),
            //                 ),
            //
            //               ];
            //             },
            //             icon: Icon(Icons.arrow_drop_down_rounded,
            //             ),
            //             style: Theme.of(context).textTheme.bodyText2,
            //             hint: Text(selectedValue.toString()),
            //             items: items
            //                 .map((item) => DropdownMenuItem<String>(
            //               value: item,
            //               child: Text(
            //                 item,
            //                 style: Theme.of(context).textTheme.bodyText2,
            //                 overflow: TextOverflow.ellipsis,
            //               ),
            //             ))
            //                 .toList(),
            //             value: selectedValue,
            //             onChanged: (value) {
            //               setState(() {
            //                 selectedValue = value as String;
            //                 if(selectedValue == 'Daily'){
            //                   //context.locale = Locale('en');
            //
            //                 }else if(selectedValue == 'Monthly'){
            //                   //context.locale = Locale('hi');
            //
            //                 }else if(selectedValue == 'Yearly'){
            //                   //context.locale = Locale('ur');
            //
            //                 }
            //               });
            //             },
            //             buttonSplashColor: Colors.transparent,
            //             buttonHighlightColor: Colors.transparent,
            //             //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
            //             iconSize: 24,
            //             iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
            //             // iconDisabledColor: Colors.grey,
            //             buttonHeight: 25,
            //             buttonWidth: 90,
            //             buttonPadding: EdgeInsets.only(left: 0, right: 0),
            //             // buttonDecoration: BoxDecoration(
            //             //   borderRadius: BorderRadius.circular(radiusValue),
            //             //   border: Border.all(
            //             //     color: Theme.of(context).textTheme.bodyText1!.color!,
            //             //   ),
            //             //   color: Colors.transparent,
            //             // ),
            //             //buttonElevation: 2,
            //             itemHeight: 40,
            //             //itemPadding: const EdgeInsets.only(left: 15, right: 15),
            //             dropdownMaxHeight: 150,
            //             dropdownWidth: 120,
            //             dropdownPadding: null,
            //             dropdownDecoration: BoxDecoration(
            //               // border: Border(
            //               //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
            //               // ),
            //               borderRadius: BorderRadius.circular(radiusValue),
            //               color: Theme.of(context).scaffoldBackgroundColor,
            //             ),
            //             dropdownElevation: 1,
            //             //scrollbarRadius: const Radius.circular(40),
            //             //scrollbarThickness: 6,
            //             //scrollbarAlwaysShow: true,
            //             offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SliverToBoxAdapter(
            //   child: Column(
            //     children: [
            //       SizedBox(height: verticalSpaceSmall),
            //       Container(
            //         width: context.deviceWidth,
            //         padding: EdgeInsets.only(top: 25, bottom: 25),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).canvasColor,
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             HeadingRowWidget(
            //                 headingText: 'Competition Particulars',
            //                 textButton: 'SEE ALL',
            //                 showTextButton: false,
            //                 onTap: (){}
            //             ),
            //             SizedBox(height: verticalSpaceExtraSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: Text('- Registrations Strats on 1st Jan, 2022\n- Submission ends on 10th Jan, 2022\n- Results announced on 15th Jan, 2022',
            //                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //                     height: 1.6
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(height: verticalSpaceSmall),
            //       Container(
            //         width: context.deviceWidth,
            //         padding: EdgeInsets.only(top: 25, bottom: 25),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).canvasColor,
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             HeadingRowWidget(
            //                 headingText: 'How To Enter',
            //                 textButton: 'SEE ALL',
            //                 showTextButton: false,
            //                 onTap: (){}
            //             ),
            //             SizedBox(height: verticalSpaceExtraSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: Text('1. Subscribe us on our email.\n2. Process - Subscribe - Registered - Write option from menu bar - Choose language - Choose competition category - Upload your content - Wait for result.',
            //                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //                     height: 1.6
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(height: verticalSpaceSmall),
            //       Container(
            //         width: context.deviceWidth,
            //         padding: EdgeInsets.only(top: 25, bottom: 25),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).canvasColor,
            //         ),
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             HeadingRowWidget(
            //                 headingText: 'Contest Rules',
            //                 textButton: 'SEE ALL',
            //                 showTextButton: false,
            //                 onTap: (){}
            //             ),
            //             SizedBox(height: verticalSpaceExtraSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: Text('1. Participants should submit their work before 8pm on 18th Feb, 2021.\n'
            //                   '2. Paticipants must submit their original work.\n'
            //                   '3. Any entry containing cliche will not be accepted.\n'
            //                   '4. Mention the name or relationship for you are writing (Preferred using images)',
            //                 style: Theme.of(context).textTheme.bodyText2!.copyWith(
            //                     height: 1.6
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: verticalSpaceSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: TextFormFieldBig(
            //                 hintText: 'Full Name',
            //                 height: bigButtonHeight,
            //                 prefixIcon: Icon(Icons.person_outline_outlined,
            //                   color: secondaryColor,
            //                   size: 20,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: verticalSpaceExtraSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: TextFormFieldBig(
            //                 hintText: 'Email',
            //                 height: bigButtonHeight,
            //                 prefixIcon: Icon(Icons.email_outlined,
            //                   color: secondaryColor,
            //                   size: 20,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: verticalSpaceSmall),
            //             Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 15),
            //               child: GestureDetector(
            //                 onTap: (){
            //                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
            //                 },
            //                 child: ButtonBig(
            //                     height: bigButtonHeight,
            //                     width: double.infinity,
            //                     backgroundColor: primaryColor,
            //                     text: 'SUBSCRIBE',
            //                     showProgress: false,
            //                     radius: radiusValue
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SliverToBoxAdapter(
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.monthlyCompetitionResultModel!.data!.length,
                  itemBuilder: (BuildContext context, int mainIndex ){
                    return Container(
                      width: context.deviceWidth,
                      padding: EdgeInsets.only(top: 25, bottom: 25),
                      margin: EdgeInsets.only(top: verticalSpaceSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: context.deviceWidth-30,
                            child: Text("${widget.monthlyCompetitionResultModel!.data![mainIndex].compTitle}",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              //maxLines: (context.locale == Locale('ur'))?3:4,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: verticalSpaceExtraSmall),
                          SizedBox(
                            width: context.deviceWidth-30,
                            child: Text("${widget.monthlyCompetitionResultModel!.data![mainIndex].compSortDesc.toString().replaceAll("</br>", "").replaceAll("<br>", "").replaceAll("<BR>", "").replaceAll("</BR>", "")}",
                              style: Theme.of(context).textTheme.caption,
                              textAlign: TextAlign.start,
                              softWrap: true,
                              //maxLines: (context.locale == Locale('ur'))?3:4,
                              //overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: verticalSpaceSmall),
                          Container(
                            height: 180,
                            //color: Colors.red,
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.monthlyCompetitionResultModel!.data![mainIndex].compWinnerPostAsRank!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        width: context.deviceWidth*0.88,
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
                                        padding: (context.locale == Locale('ur'))?EdgeInsets.only(right: 140, left: 15):EdgeInsets.only(left: 140, right: 15),
                                        margin: (context.locale == Locale('ur'))?
                                        (index== 0)?EdgeInsets.only(left: 15, right: 15,):EdgeInsets.only(left: 15):
                                        (index==0)?EdgeInsets.only(left: 15, right: 15):EdgeInsets.only(right: 15),
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(height: verticalSpaceSmall),
                                                  SizedBox(
                                                    child: Text("${widget.monthlyCompetitionResultModel!.data![mainIndex].compWinnerPostAsRank![index].postTitle}",
                                                      style: Theme.of(context).textTheme.subtitle1,
                                                      textAlign: TextAlign.start,
                                                      softWrap: true,
                                                      maxLines: (index == 0 || index == 1 || index == 2)?1:2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  SizedBox(
                                                    child: Text("${widget.monthlyCompetitionResultModel!.data![mainIndex].compWinnerPostAsRank![index].authorName}",
                                                      style: Theme.of(context).textTheme.caption,
                                                      textAlign: TextAlign.start,
                                                      softWrap: false,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.fade,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.end,
                                              //   children: [
                                              //     Row(
                                              //       mainAxisAlignment: MainAxisAlignment.start,
                                              //       children: [
                                              //         Icon(Icons.remove_red_eye_outlined,
                                              //           size: 14,
                                              //           color: Theme.of(context).disabledColor,
                                              //         ),
                                              //         SizedBox(width: 2),
                                              //         Text('${demoData[index]["views"]}',
                                              //           style: Theme.of(context).textTheme.caption!.copyWith(
                                              //               letterSpacing: 0.5
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //     SizedBox(width: 15),
                                              //     Row(
                                              //       mainAxisAlignment: MainAxisAlignment.start,
                                              //       children: [
                                              //         Icon(Icons.thumb_up_alt_outlined,
                                              //           size: 14,
                                              //           color: Theme.of(context).disabledColor,
                                              //         ),
                                              //         SizedBox(width: 2),
                                              //         Text('${demoData[index]["views"]}',
                                              //           style: Theme.of(context).textTheme.caption!.copyWith(
                                              //               letterSpacing: 0.5
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ],
                                              // )
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: (index ==0)?SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: SvgPicture.asset(ribbon1),
                                                ):
                                                (index ==1)?SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: SvgPicture.asset(ribbon2),
                                                ):
                                                (index ==2)?SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: SvgPicture.asset(ribbon3),
                                                ):Container(),
                                              )

                                            ],
                                          ),
                                        ),

                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        //margin: EdgeInsets.only(left: 30, top:5),
                                        margin: (context.locale == Locale('ur'))?
                                        (index==0)?EdgeInsets.only(right: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(right: 15, top:2,bottom: verticalSpaceSmall):
                                        (index==0)?EdgeInsets.only(left: 30, top:2,bottom: verticalSpaceSmall):EdgeInsets.only(left: 15, top:2,bottom: verticalSpaceSmall),
                                        width: 110,
                                        height: 160,
                                        alignment: Alignment.topCenter,
                                        decoration: BoxDecoration(
                                          //color: Colors.red,
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  spreadRadius: 0,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 5)
                                              )
                                            ]
                                        ),
                                        child: AspectRatio(
                                          aspectRatio: 1 /1.5,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(radiusValue)),
                                            child: CachedNetworkImage(
                                              imageUrl: "${imageBaseUrl}${widget.monthlyCompetitionResultModel!.data![mainIndex].compWinnerPostAsRank![index].postCoverImage}",
                                              fit: BoxFit.cover,
                                              alignment: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  }
              ),
            )
          ]
      ),
    );
  }
}
