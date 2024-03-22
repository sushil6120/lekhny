// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lekhny/provider/themeManagerProvider.dart';
// import 'package:lekhny/styles/colors.dart';
// import 'package:lekhny/styles/responsive.dart';
// import 'package:lekhny/ui/global%20widgets/buttonBig.dart';
// import 'package:lekhny/ui/screens/demoGalleryScreen.dart';
// import 'package:lekhny/ui/screens/demoIgtvScreen.dart';
// import 'package:lekhny/ui/screens/demoReelsScreen.dart';
// import 'package:lekhny/ui/screens/settingsScreen.dart';
// import 'package:lekhny/ui/widget/profile%20page%20widget/writersInfoTextWidget.dart';
// import 'package:lekhny/utils/valueConstants.dart';
// import 'package:provider/provider.dart';
//
// class DemoProfileScreen extends StatelessWidget {
//   //const DemoProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final themeManager = Provider.of<ThemeManager>(context);
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         centerTitle: false,
//         elevation: 0.5,
//         automaticallyImplyLeading: false,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 child: Text('Arundhati Roy',
//                   style: Theme.of(context).textTheme.headline6,
//                 ),
//               ),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       //Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
//                     },
//                     child: Icon(
//                       Icons.mail_outline_rounded,color: Theme.of(context).textTheme.headline4!.color,
//                     ),
//                   ),
//                   SizedBox(width: 25),
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));
//                     },
//                     child: Icon(
//                       Icons.settings_outlined,color: Theme.of(context).textTheme.headline4!.color,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: DefaultTabController(
//         length: 3,
//         child: NestedScrollView(
//           headerSliverBuilder: (context, _){
//             return [
//               SliverList(
//                   delegate: SliverChildListDelegate([
//                     Container(
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 140,
//                             //color: Colors.red,
//                             child: Stack(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topCenter,
//                                   child: Container(
//                                     width: context.deviceWidth,
//                                     height: 80,
//                                     child: Stack(
//                                         children:[
//                                           Container(
//                                             width: context.deviceWidth,
//                                             height: 80,
//                                             child: Image.network('https://images.indianexpress.com/2019/07/pen.jpg',
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                           Align(
//                                             alignment: (context.locale == Locale('ur'))?
//                                             Alignment.topLeft:
//                                             Alignment.topRight,
//                                             child: Container(
//                                                 height: 25,
//                                                 width: 25,
//                                                 decoration: BoxDecoration(
//                                                     color: Theme.of(context).canvasColor,
//                                                     border: Border.all(width: 1, color: Theme.of(context).disabledColor),
//                                                     borderRadius: BorderRadius.all(Radius.circular(20))
//                                                 ),
//                                                 margin: EdgeInsets.only(left: 15, right: 15, top: 10),
//                                                 child: Center(
//                                                   child: Icon(Icons.edit_outlined,
//                                                     size: 16,
//                                                   ),
//                                                 )
//                                             ),
//                                           ),
//                                         ]
//                                     ),
//                                   ) ,
//                                 ),
//
//                                 Align(
//                                     alignment: Alignment.bottomLeft,
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.end,
//                                       children: [
//                                         Container(
//                                           height: 110,
//                                           width: 115,
//                                           margin: EdgeInsets.symmetric(horizontal: 15),
//                                           child: Stack(
//                                             children: [
//                                               Container(
//                                                   height: 110,
//                                                   width: 110,
//                                                   child: CircleAvatar(
//                                                     foregroundImage: NetworkImage('https://www.siliconindia.com/news/newsimages/special/xbq2g5fZ.jpeg',
//                                                     ) ,
//                                                   )
//                                               ),
//                                               Align(
//                                                 alignment: (context.locale == Locale('ur'))?
//                                                 Alignment.bottomLeft:
//                                                 Alignment.bottomRight,
//                                                 child: Container(
//                                                     height: 25,
//                                                     width: 25,
//                                                     decoration: BoxDecoration(
//                                                         color: Theme.of(context).canvasColor,
//                                                         border: Border.all(width: 1, color: Theme.of(context).disabledColor),
//                                                         borderRadius: BorderRadius.all(Radius.circular(20))
//                                                     ),
//                                                     margin: EdgeInsets.symmetric(horizontal: 15),
//                                                     child: Center(
//                                                       child: Icon(Icons.camera_alt_outlined,
//                                                         size: 16,
//                                                       ),
//                                                     )
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 70,
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text('Arundhati Roy',
//                                                 style: Theme.of(context).textTheme.subtitle1,
//                                               ),
//                                               SizedBox(height: 2),
//                                               Text('Lekhny Stambh',
//                                                 style: Theme.of(context).textTheme.caption,
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     )
//                                 )
//
//                               ],
//                             ),
//                           ),
//                           Container(
//                               height: 140,
//                               //color: Colors.green,
//                               margin: EdgeInsets.symmetric(horizontal: 15),
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children :[
//                                     Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                         children : [
//                                           WritersInfoTextWidget(
//                                             boldText: '8',
//                                             lightText: 'Posts',
//                                           ),
//                                           WritersInfoTextWidget(
//                                             boldText: '500',
//                                             lightText: 'Followers',
//                                           ),
//                                           WritersInfoTextWidget(
//                                             boldText: '12k',
//                                             lightText: 'Following',
//                                           ),
//                                           WritersInfoTextWidget(
//                                             boldText: '5',
//                                             lightText: 'Trophy',
//                                           ),
//                                         ]
//                                     ),
//                                     SizedBox(height: verticalSpaceSmall),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//
//                                         ButtonBig(
//                                           height: 30,
//                                           width: context.deviceWidth*.5 -25,
//                                           backgroundColor: Theme.of(context).primaryColor,
//                                           text: 'Edit Profile',
//                                           showProgress: false,
//                                           radius: radiusValue,
//                                           fontSize: 12,
//                                           letterspacing: 0.2,
//
//                                         ),
//                                         ButtonBig(
//                                           height: 30,
//                                           width: context.deviceWidth*.5 -25,
//                                           backgroundColor: Theme.of(context).cardColor,
//                                           text: 'Share',
//                                           showProgress: false,
//                                           radius: radiusValue,
//                                           fontSize: 12,
//                                           textColor: Theme.of(context).textTheme.headline6!.color,
//                                           letterspacing: 0.2,
//                                         ),
//
//                                       ],
//                                     )
//                                   ]
//                               )
//                           ),
//                         ],
//
//                       ),
//                     ),
//                   ]
//                   )
//               )
//             ];
//           },
//           body: Column(
//             children: [
//               Material(
//                 child: TabBar(
//                   indicatorColor: Theme.of(context).textTheme.headline5!.color,
//                   tabs: [
//                     Tab(child: Text('Posts',
//                       style: Theme.of(context).textTheme.subtitle1,),
//                     ),
//                     Tab(child: Text('Library',
//                       style: Theme.of(context).textTheme.subtitle1,),
//                     ),
//                     Tab(child: Text('Dashboard',
//                       style: Theme.of(context).textTheme.subtitle1,),
//                     ),
//
//                   ],
//                 ),
//
//               ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     Gallery(),
//                     Igtv(),
//                     Reels()
//
//                   ],
//                 )
//               )
//             ],
//           ),
//         )
//       ),
//
//     );
//   }
// }
