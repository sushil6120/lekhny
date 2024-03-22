// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:lekhny/styles/colors.dart';
// import 'package:lekhny/styles/responsive.dart';
// import 'package:lekhny/ui/global%20widgets/bookWidget.dart';
// import 'package:lekhny/utils/demoCaroselData.dart';
// import 'package:lekhny/utils/valueConstants.dart';
//
// class Gallery extends StatefulWidget {
//   @override
//   State<Gallery> createState() => _GalleryState();
// }
//
// class _GalleryState extends State<Gallery> {
//   //const Gallery({Key? key}) : super(key: key);
//   final List<String> items = [
//     'Published',
//     'Draft',
//     'Series',
//   ];
//
//   String? selectedValue;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         physics: ClampingScrollPhysics(),
//         slivers: [
//           SliverToBoxAdapter(
//               child: SizedBox(height: verticalSpaceSmall)
//           ),
//           SliverToBoxAdapter(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               margin: EdgeInsets.symmetric(horizontal: 15),
//               height: 50,
//               color: Theme.of(context).canvasColor,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text('Your Stories',
//                     style: Theme.of(context).textTheme.bodyText1,
//                   ),
//                   DropdownButtonHideUnderline(
//                     child: DropdownButton2(
//                       isExpanded: true,
//                       //underline: Divider(height: 2, color: primaryColor,),
//                       selectedItemHighlightColor: Theme.of(context).canvasColor,
//                       selectedItemBuilder: (BuildContext conetxt){
//                         return <Widget>[
//                           Center(
//                             child: Text('Published',
//                               style: TextStyle(
//                                   color: primaryColor
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text('Draft',
//                               style: TextStyle(
//                                   color: primaryColor
//                               ),
//                             ),
//                           ),
//                           Center(
//                             child: Text('Series',
//                               style: TextStyle(
//                                   color: primaryColor
//                               ),
//                             ),
//                           ),
//
//                         ];
//                       },
//                       icon: Icon(Icons.arrow_drop_down_rounded,
//                       ),
//                       style: Theme.of(context).textTheme.bodyText2,
//                       hint: Text(selectedValue.toString()),
//                       items: items
//                           .map((item) => DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(
//                           item,
//                           style: Theme.of(context).textTheme.bodyText2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ))
//                           .toList(),
//                       value: selectedValue,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedValue = value as String;
//                           if(selectedValue == 'Published'){
//                             //context.locale = Locale('en');
//
//                           }else if(selectedValue == 'Draft'){
//                             //context.locale = Locale('hi');
//
//                           }else if(selectedValue == 'Series'){
//                             //context.locale = Locale('ur');
//
//                           }
//                         });
//                       },
//                       buttonSplashColor: Colors.transparent,
//                       buttonHighlightColor: Colors.transparent,
//                       //buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
//                       iconSize: 24,
//                       iconEnabledColor: Theme.of(context).textTheme.headline4!.color!,
//                       // iconDisabledColor: Colors.grey,
//                       buttonHeight: 25,
//                       buttonWidth: 90,
//                       buttonPadding: EdgeInsets.only(left: 0, right: 0),
//                       // buttonDecoration: BoxDecoration(
//                       //   borderRadius: BorderRadius.circular(radiusValue),
//                       //   border: Border.all(
//                       //     color: Theme.of(context).textTheme.bodyText1!.color!,
//                       //   ),
//                       //   color: Colors.transparent,
//                       // ),
//                       //buttonElevation: 2,
//                       itemHeight: 40,
//                       //itemPadding: const EdgeInsets.only(left: 15, right: 15),
//                       dropdownMaxHeight: 150,
//                       dropdownWidth: 120,
//                       dropdownPadding: null,
//                       dropdownDecoration: BoxDecoration(
//                         // border: Border(
//                         //   bottom: BorderSide(width: 1, color: Theme.of(context).primaryIconTheme.color! ),
//                         // ),
//                         borderRadius: BorderRadius.circular(radiusValue),
//                         color: Theme.of(context).scaffoldBackgroundColor,
//                       ),
//                       dropdownElevation: 1,
//                       //scrollbarRadius: const Radius.circular(40),
//                       //scrollbarThickness: 6,
//                       //scrollbarAlwaysShow: true,
//                       offset: (context.locale == Locale('ur'))?Offset(0, -10):Offset(0, -10),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//               child: SizedBox(height: verticalSpaceSmall)
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15),
//               child: GridView.count(
//                   physics: BouncingScrollPhysics(),
//                   childAspectRatio: (context.deviceWidth>500)?1/1.7:1/1.85,
//                   shrinkWrap: true,
//                   crossAxisCount: (context.deviceWidth>500)?6:3,
//                   crossAxisSpacing: 15,
//                   mainAxisSpacing: 15,
//                   children: List.generate(
//                       demoData.length, (index) => GestureDetector(
//                     onTap: (){
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubCategoryScreen(
//                       //     subCategoryList: categoryDemoData[index][List],
//                       //     appBarTitle: categoryDemoData[index][String])));
//                     },
//                     child: BookWidget(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         showParts: false,
//                         showViews: false,
//                         showBookTitle: true,
//                         showWriter: true,
//                         partsValue: demoData[index]["parts"],
//                         partsSpace: 0,
//                         imgSpace: 10,
//                         imageHeight: 100,
//                         imageWidth: 150,
//                         imgUrl: demoData[index]["bookCover"],
//                         viewsValue: demoData[index]["views"],
//                         bookTextWidth: 100,
//                         bookName: demoData[index]["book"],
//                         bookNameSpace: 4,
//                         writerTextWidth: 100,
//                         writerName: demoData[index]["author"]
//                     ),
//                   ))
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//               child: SizedBox(height: verticalSpaceSmall)
//           ),
//         ]
//       ),
//     );
//   }
// }
